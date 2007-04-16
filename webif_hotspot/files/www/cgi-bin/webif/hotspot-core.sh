#!/usr/bin/webif-page
<?
. /usr/lib/webif/webif.sh
is_kamikaze && {
	local _val
	uci_load "hotspot"
	eval "_val=\$CONFIG_chilli_TYPE" 2>/dev/null
	! equal "$_val" "hotspot" && {
		uci_add "hotspot" "hotspot" "chilli"
		uci_commit "hotspot"
		uci_load "hotspot"
	}
}

if empty "$FORM_submit"; then
	is_kamikaze && {
		FORM_chilli_debug="$CONFIG_chilli_debug"
		FORM_chilli_net="$CONFIG_chilli_net"
		FORM_chilli_dns1="$CONFIG_chilli_dns1"
		FORM_chilli_dns2="$CONFIG_chilli_dns2"
		FORM_chilli_dhcpif="$CONFIG_chilli_dhcpif"
		FORM_chilli_dhcpmac="$CONFIG_chilli_dhcpmac"
		FORM_chilli_lease="$CONFIG_chilli_lease"
		FORM_chilli_pidfile="$CONFIG_chilli_pidfile"
		FORM_chilli_interval="$CONFIG_chilli_interval"
		FORM_chilli_domain="$CONFIG_chilli_domain"
		FORM_chilli_dynip="$CONFIG_chilli_dynip"
		FORM_chilli_statip="$CONFIG_chilli_statip"
	} || {
		FORM_chilli_debug="${chilli_debug:-$(nvram get chilli_debug)}"
		FORM_chilli_net="${chilli_net:-$(nvram get chilli_net)}"
		FORM_chilli_dns1="${chilli_dns1:-$(nvram get chilli_dns1)}"
		FORM_chilli_dns2="${chilli_dns2:-$(nvram get chilli_dns2)}"
		FORM_chilli_dhcpif="${chilli_dhcpif:-$(nvram get chilli_dhcpif)}"
		FORM_chilli_dhcpmac="${chilli_dhcpmac:-$(nvram get chilli_dhcpmac)}"
		FORM_chilli_lease="${chilli_lease:-$(nvram get chilli_lease)}"
		FORM_chilli_pidfile="${chilli_pidfile:-$(nvram get chilli_pidfile)}"
		FORM_chilli_interval="${chilli_interval:-$(nvram get chilli_interval)}"
		FORM_chilli_domain="${chilli_domain:-$(nvram get chilli_domain)}"
		FORM_chilli_dynip="${chilli_dynip:-$(nvram get chilli_dynip)}"
		FORM_chilli_statip="${chilli_statip:-$(nvram get chilli_statip)}"
	}
else
	SAVED=1
	validate <<EOF
int|FORM_chilli_debug|@TR<<hotspot_core_Debug#Debug>>||$FORM_chilli_debug
string|FORM_chilli_net|@TR<<hotspot_core_DHCP_Network#DHCP Network>>||$FORM_chilli_net
string|FORM_chilli_dhcpif|@TR<<hotspot_core_DHCP_Interface#DHCP Interface>>||$FORM_chilli_dhcpif
string|FORM_chilli_dhcpmac|@TR<<hotspot_core_DHCP_MAC#DHCP MAC>>||$FORM_chilli_dhcpmac
string|FORM_chilli_lease|@TR<<hotspot_core_DHCP_Lease#DHCP Lease>>||$FORM_chilli_lease
string|FORM_chilli_dns1|hotspot_core_DNS1#DNS1||$FORM_chilli_dns1
string|FORM_chilli_dns2|hotspot_core_DNS2#DNS2||$FORM_chilli_dns2
string|FORM_chilli_domain|@TR<<hotspot_core_Domain#Domain>>||$FORM_chilli_domain
string|FORM_chilli_interval|@TR<<hotspot_core_Interval#Interval||$FORM_chilli_interval
string|FORM_chilli_pidfile|@TR<<hotspot_core_Pidfile#Pidfile>>||$FORM_chilli_pidfile
string|FORM_chilli_dynip|@TR<<hotspot_core_Dynamic_IP_Pool#Dynamic IP Pool||$FORM_chilli_dynip
string|FORM_chilli_statip|@TR<<hotspot_core_Static_IP_Pool#Static IP Pool>>||$FORM_chilli_statip
EOF
	equal "$?" 0 && {
		is_kamikaze && {
			uci_set hotspot chilli debug "$FORM_chilli_debug"
			uci_set hotspot chilli dns1 "$FORM_chilli_dns1"
			uci_set hotspot chilli dns2 "$FORM_chilli_dns2"
			uci_set hotspot chilli lease "$FORM_chilli_lease"
			uci_set hotspot chilli interval "$FORM_chilli_interval"
			uci_set hotspot chilli domain "$FORM_chilli_domain"
			uci_set hotspot chilli pidfile "$FORM_chilli_pidfile"
			uci_set hotspot chilli statip "$FORM_chilli_statip"
			uci_set hotspot chilli dynip "$FORM_chilli_dynip"
			uci_set hotspot chilli dhcpif "$FORM_chilli_dhcpif"
			uci_set hotspot chilli dhcpmac "$FORM_chilli_dhcpmac"
		} || {
			save_setting hotspot chilli_debug "$FORM_chilli_debug"
			save_setting hotspot chilli_dns1 "$FORM_chilli_dns1"
			save_setting hotspot chilli_dns2 "$FORM_chilli_dns2"
			save_setting hotspot chilli_lease "$FORM_chilli_lease"
			save_setting hotspot chilli_interval "$FORM_chilli_interval"
			save_setting hotspot chilli_domain "$FORM_chilli_domain"
			save_setting hotspot chilli_pidfile "$FORM_chilli_pidfile"
			save_setting hotspot chilli_statip "$FORM_chilli_statip"
			save_setting hotspot chilli_dynip "$FORM_chilli_dynip"
			save_setting hotspot chilli_dhcpif "$FORM_chilli_dhcpif"
			save_setting hotspot chilli_dhcpmac "$FORM_chilli_dhcpmac"
		}
	}
fi

header "HotSpot" "hotspot_core_Core#Core" "@TR<<hotspot_core_Core_Settings#Core Settings>>" '' "$SCRIPT_NAME"

display_form <<EOF
start_form|@TR<<hotspot_core_Core_Settings#Core Settings>>
field|@TR<<hotspot_core_Debug#Debug>>|chilli_debug
checkbox|chilli_debug|$FORM_chilli_debug|1
helpitem|hotspot_core_Debug#Debug
helptext|hotspot_core_Debug_helptext#Enable/Disable debugging.
field|@TR<<hotspot_core_DHCP_Network#DHCP Network>>|chilli_net
text|chilli_net|$FORM_chilli_net
helpitem|hotspot_core_DHCP_Network#DHCP Network
helptext|hotspot_core_DHCP_Network_helptext#Client's DHCP Network IP Subnet (192.168.182.0/24 by default).
field|@TR<<hotspot_core_DHCP_Interface#DHCP Interface>>|chilli_dhcpif
text|chilli_dhcpif|$FORM_chilli_dhcpif
field|@TR<<hotspot_core_DHCP_MAC#DHCP MAC>>|chilli_dhcpmac
text|chilli_dhcpmac|$FORM_chilli_dhcpmac
field|@TR<<hotspot_core_DHCP_Lease#DHCP Lease>>|chilli_lease
text|chilli_lease|$FORM_chilli_lease
helpitem|hotspot_core_DHCP_Lease#DHCP Lease
helptext|hotspot_core_DHCP_Lease_helptext#DHCP Lease time for clients before expires (default is 600).
field|@TR<<hotspot_core_DNS1#DNS1>>|chilli_dns1
text|chilli_dns1|$FORM_chilli_dns1
field|@TR<<hotspot_core_DNS2#DNS2>>|chilli_dns2
text|chilli_dns2|$FORM_chilli_dns2
field|@TR<<hotspot_core_Domain#Domain>>|chilli_domain
text|chilli_domain|$FORM_chilli_domain
helpitem|hotspot_core_DHCP_DNS#DHCP DNS
helptext|hotspot_core_DHCP_DNS_helptext#DNS Servers offered to clients (if omitted system default will be used).
field|@TR<<hotspot_core_Interval#Interval>>|chilli_interval
text|chilli_interval|$FORM_chilli_interval
field|@TR<<hotspot_core_Pidfile#Pidfile>>|chilli_pidfile
text|chilli_pidfile|$FORM_chilli_pidfile
helpitem|hotspot_core_Pidfile#Pidfile
helptext|hotspot_core_Pidfile_helptext#File to store information about the process id.
field|@TR<<hotspot_core_Dynamic_IP_Pool#Dynamic IP Pool>>|chilli_dynip
text|chilli_dynip|$FORM_chilli_dynip
helpitem|hotspot_core_Dynamic_IP_Pool#Dynamic IP Pool
helptext|hotspot_core_Dynamic_IP_Pool_helptext#Allocation of dynamic IP Addresses to clients.
field|@TR<<hotspot_core_Static_IP_Pool#Static IP Pool>>|chilli_statip
text|chilli_statip|$FORM_chilli_statip
helpitem|hotspot_core_Static_IP_Pool#Static IP Pool
helptext|hotspot_core_Static_IP_Pool_helptext#Allocation of static IP Addresses.
end_form
EOF

footer ?>
<!--
##WEBIF:name:HotSpot:1:hotspot_core_Core#Core
-->
