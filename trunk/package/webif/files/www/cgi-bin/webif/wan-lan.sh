#!/usr/bin/webif-page
<? 
. "/usr/lib/webif/webif.sh"
###################################################################
# WAN and LAN configuration page
#
# Description:
#	Configures basic WAN and LAN interface settings.
#
# Author(s) [in order of work date]: 
#       Original webif authors of wan.sh and lan.sh
# 	Jeremy Collake <jeremy.collake@gmail.com>
#
# Major revisions:
#
# NVRAM variables referenced:
#
# Configuration files referenced: 
#   none
#

header "Network" "WAN-LAN" "@TR<<WAN-LAN Configuration>>" ' onLoad="modechange()" ' "$SCRIPT_NAME"

load_settings network

FORM_wandns="${wan_dns:-$(nvram get wan_dns)}"
LISTVAL="$FORM_wandns"
handle_list "$FORM_dnsremove" "$FORM_wandnsadd" "$FORM_wandnssubmit" 'ip|FORM_dnsadd|@TR<<WAN DNS Address>>|required' && {
	FORM_wandns="$LISTVAL"
	save_setting network wan_dns "$FORM_wandns"
}
FORM_wandnsadd=${FORM_wandnsadd:-192.168.1.1}

if empty "$FORM_submit"; then
	FORM_wan_proto=${wan_proto:-$(nvram get wan_proto)}
	case "$FORM_wan_proto" in
		# supported types
		static|dhcp|pptp|pppoe) ;;
		# otherwise select "none"
		*) FORM_wan_proto="none";;
	esac
	
	# pptp, dhcp and static common
	FORM_wan_ipaddr=${wan_ipaddr:-$(nvram get wan_ipaddr)}
	FORM_wan_netmask=${wan_netmask:-$(nvram get wan_netmask)}
	FORM_wan_gateway=${wan_gateway:-$(nvram get wan_gateway)}
	
  	# ppp common
	FORM_ppp_username=${ppp_username:-$(nvram get ppp_username)}
	FORM_ppp_passwd=${ppp_passwd:-$(nvram get ppp_passwd)}
	FORM_ppp_idletime=${ppp_idletime:-$(nvram get ppp_idletime)}
	FORM_ppp_redialperiod=${ppp_redialperiod:-$(nvram get ppp_redialperiod)}
	FORM_ppp_mtu=${ppp_mtu:-$(nvram get ppp_mtu)}

	redial=${ppp_demand:-$(nvram get ppp_demand)}
	case "$redial" in
		1|enabled|on) FORM_ppp_redial="demand";;	
		*) FORM_ppp_redial="persist";;	
	esac
	
	FORM_pptp_server_ip=${pptp_server_ip:-$(nvram get pptp_server_ip)}
else
	SAVED=1

	empty "$FORM_wan_proto" && {
		ERROR="@TR<<No WAN Proto|No WAN protocol has been selected>>" 
		return 255
	}

	case "$FORM_wan_proto" in
		static)
			V_IP="required"
			V_NM="required"
			;;
		pptp)
			V_PPTP="required"
			;;
	esac

validate <<EOF
ip|FORM_wan_ipaddr|@TR<<IP Address>>|$V_IP|$FORM_wan_ipaddr
netmask|FORM_wan_netmask|@TR<<WAN Netmask>>|$V_NM|$FORM_wan_netmask
ip|FORM_wan_gateway|@TR<<Default Gateway>>||$FORM_wan_gateway
ip|FORM_pptp_server_ip|@TR<<PPTP Server IP>>|$V_PPTP|$FORM_pptp_server_ip
EOF
	equal "$?" 0 && {
		save_setting network wan_proto $FORM_wan_proto
		
		# Settings specific to one protocol type
		case "$FORM_wan_proto" in
			static) save_setting network wan_gateway $FORM_wan_gateway ;;
			pptp) save_setting network pptp_server_ip "$FORM_pptp_server_ip" ;;
		esac
		
		# Common settings for PPTP, Static and DHCP 
		case "$FORM_wan_proto" in
			pptp|static|dhcp)
				save_setting network wan_ipaddr $FORM_wan_ipaddr
				save_setting network wan_netmask $FORM_wan_netmask 
			;;
		esac
		
		# Common PPP settings
		case "$FORM_wan_proto" in
			pppoe|pptp)
				empty "$FORM_ppp_username" || save_setting network ppp_username $FORM_ppp_username
				empty "$FORM_ppp_passwd" || save_setting network ppp_passwd $FORM_ppp_passwd
		
				# These can be blank
				save_setting network ppp_idletime "$FORM_ppp_idletime"
				save_setting network ppp_redialperiod "$FORM_ppp_redialperiod"
				save_setting network ppp_mtu "$FORM_ppp_mtu"

				save_setting network wan_ifname "ppp0"
		
				case "$FORM_ppp_redial" in
					demand)
						save_setting network ppp_demand 1
						;;
					persist)
						save_setting network ppp_demand ""
						;;
				esac	
			;;
			*)
				wan_ifname=${wan_ifname:-$(nvram get wan_ifname)}
				[ -z "$wan_ifname" -o "${wan_ifname%%[0-9]*}" = "ppp" ] && {
					wan_device=${wan_device:-$(nvram get wan_device)}
					wan_device=${wan_device:-vlan1}
					save_setting network wan_ifname "$wan_device"
				}
			;;
		esac
	}
fi

# detect pptp package and compile option
[ -x "/sbin/ifup.pptp" ] && {
	PPTP_OPTION="option|pptp|PPTP"
	PPTP_SERVER_OPTION="field|PPTP Server IP|pptp_server|hidden
text|pptp_server_ip|$FORM_pptp_server_ip"
}
[ -x "/sbin/ifup.pppoe" ] && {
	PPPOE_OPTION="option|pppoe|PPPoE"
}


cat <<EOF
<script type="text/javascript" src="/webif.js "></script>
<script type="text/javascript">
<!--
function modechange()
{
	var v;
	v = (isset('wan_proto', 'pppoe') || isset('wan_proto', 'pptp'));
	set_visible('ppp_settings', v);
	set_visible('username', v);
	set_visible('passwd', v);
	set_visible('redial', v);
	set_visible('mtu', v);
	set_visible('demand_idletime', v && isset('ppp_redial', 'demand'));
	set_visible('persist_redialperiod', v && !isset('ppp_redial', 'demand'));
	
	v = (isset('wan_proto', 'static') || isset('wan_proto', 'pptp') || isset('wan_proto', 'dhcp'));
	set_visible('wan_ip_settings', v);
	set_visible('wan_ipaddr', v);
	set_visible('wan_netmask', v);
	
	v = isset('wan_proto', 'static');
	set_visible('wan_gateway', v);
	set_visible('wan_dns', v);

	v = isset('wan_proto', 'pptp');
	set_visible('pptp_server',v);

	hide('save');
	show('save');
}
-->
</script>
EOF

display_form <<EOF
onchange|modechange
start_form|@TR<<WAN Configuration>>
field|@TR<<Connection Type>>
select|wan_proto|$FORM_wan_proto
option|none|@TR<<No WAN#None>>
option|dhcp|@TR<<DHCP>>
option|static|@TR<<Static IP>>
$PPPOE_OPTION
$PPTP_OPTION
helplink|http://wiki.openwrt.org/OpenWrtDocs/Configuration#head-b62c144b9886b221e0c4b870edb0dd23a7b6acab
end_form
start_form|@TR<<IP Settings>>|wan_ip_settings|hidden
field|@TR<<WAN IP Address>>|ipaddr|hidden
text|wan_ipaddr|$FORM_wan_ipaddr
field|@TR<<Netmask>>|wan_netmask|hidden
text|wan_netmask|$FORM_wan_netmask
field|@TR<<Default Gateway>>|wan_gateway|hidden
text|wan_gateway|$FORM_wan_gateway
$PPTP_SERVER_OPTION
helpitem|WAN IP Settings
helptext|Helptext WAN IP Settings#IP Settings are optional for DHCP and PPTP. They are used as defaults in case the DHCP server is unavailable.
end_form
start_form|@TR<<WAN DNS Servers>>|wan_dns|hidden
listedit|wandns|$SCRIPT_NAME?wan_proto=static&|$FORM_wandns|$FORM_wandnsadd
helpitem|Note
helptext|Helptext WAN DNS save#You should save your settings on this page before adding/removing DNS servers
end_form

start_form|@TR<<PPP Settings>>|ppp_settings|hidden
field|@TR<<Redial Policy>>|redial|hidden
select|ppp_redial|$FORM_ppp_redial
option|demand|@TR<<Connect on Demand>>
option|persist|@TR<<Keep Alive>>
field|@TR<<Maximum Idle Time>>|demand_idletime|hidden
text|ppp_idletime|$FORM_ppp_idletime
helpitem|Maximum Idle Time
helptext|Helptext Idle Time#The number of seconds without internet traffic that the router should wait before disconnecting from the Internet (Connect on Demand only)
field|@TR<<Redial Timeout>>|persist_redialperiod|hidden
text|ppp_redialperiod|$FORM_ppp_redialperiod
helpitem|Redial Timeout
helptext|Helptext Redial Timeout#The number of seconds to wait after receiving no response from the provider before trying to reconnect
field|@TR<<Username>>|username|hidden
text|ppp_username|$FORM_ppp_username
field|@TR<<Password>>|passwd|hidden
password|ppp_passwd|$FORM_ppp_passwd
field|@TR<<MTU>>|mtu|hidden
text|ppp_mtu|$FORM_ppp_mtu
end_form
EOF


FORM_landns="${lan_dns:-$(nvram get lan_dns)}"
LISTVAL="$FORM_landns"
handle_list "$FORM_dnsremove" "$FORM_landnsadd" "$FORM_landnssubmit" 'ip|FORM_dnsadd|@TR<<DNS Address>>|required' && {
	FORM_landns="$LISTVAL"
	save_setting network lan_dns "$FORM_landns"
}
FORM_landnsadd=${FORM_landnsadd:-192.168.1.1}

if empty "$FORM_submit"; then 
	FORM_lan_ipaddr=${lan_ipaddr:-$(nvram get lan_ipaddr)}
	FORM_lan_netmask=${lan_netmask:-$(nvram get lan_netmask)}
	FORM_lan_gateway=${lan_gateway:-$(nvram get lan_gateway)}
else 
	SAVED=1
	validate <<EOF
ip|FORM_lan_ipaddr|@TR<<IP Address>>|required|$FORM_lan_ipaddr
netmask|FORM_lan_netmask|@TR<<Netmask>>|required|$FORM_lan_netmask
ip|FORM_lan_gateway|@TR<<Gateway>>||$FORM_lan_gateway
EOF
	equal "$?" 0 && {
		save_setting network lan_ipaddr $FORM_lan_ipaddr
		save_setting network lan_netmask $FORM_lan_netmask
		save_setting network lan_gateway $FORM_lan_gateway
	}
fi

display_form <<EOF
start_form|@TR<<LAN Configuration>>
field|@TR<<LAN IP Address>>
text|lan_ipaddr|$FORM_lan_ipaddr
helpitem|IP Address
helptext|Helptext LAN IP Address#This is the address you want this device to have on your LAN.
field|@TR<<Netmask>>
text|lan_netmask|$FORM_lan_netmask
helpitem|Netmask
helptext|Helptext Netmask#This bitmask indicates what addresses are included in your LAN.
field|@TR<<Default Gateway>>
text|lan_gateway|$FORM_lan_gateway
end_form
start_form|@TR<<LAN DNS Servers>>
listedit|landns|$SCRIPT_NAME?|$FORM_landns|$FORM_landnsadd
helpitem|Note
helptext|Helptext LAN DNS save#You need save your settings on this page before adding/removing DNS servers
end_form
EOF

footer ?>
<!--
##WEBIF:name:Network:100:WAN-LAN
-->
