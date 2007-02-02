#!/usr/bin/webif-page
<?
###################################################################
# Wireless survey page
#
# Description:
#	Perform a wireless survey and display pretty results.
#
# Author(s) [in order of work date]:
#	Jeremy Collake <jeremy.collake@gmail.com>
#	Dmytro Dykhman <dmytro@iroot.ca>
#
# Major revisions:
#
#
# Configuration files referenced:
#   none
#
# TODO:
#   I originally wrote this before I had bothered to learn much about
#   awk, so it uses 'pure' shell scripting. It would be much simpler
#   and probably more efficient to use awk. Maybe recode someday, but
#   why fix what's isn't broken...
#
. "/usr/lib/webif/webif.sh"

##### Variables

MAX_TRIES=4
MAX_CELLS=100
Wimg=0
color=0
counter=0
current=1

tempfile=$(mktemp /tmp/.survtemp.XXXXXX)
tempfile2=$(mktemp /tmp/.survtemp.XXXXXX)
tempscan=$(mktemp /tmp/.survscan.XXXXXX)

#######################################

header "Status" "Site Survey" "<img src=/images/wscan.jpg align=absmiddle>&nbsp;@TR<<Wireless survey>>"


######## Join WIFI ########

if [ "$FORM_joinwifi" != "" ]; then

if is_kamikaze; then

		. "/lib/config/uci.sh"

		config_cb() {
		config_get TYPE "$CONFIG_SECTION" TYPE
	case "$TYPE" in
		wifi-iface)
		config_get device "$CONFIG_SECTION" device
		config_get vifs "$device" vifs
		append vface "$CONFIG_SECTION" "$N"
		;;
	esac
	}

		config_load wireless

	for vcfg in $vface; do
		config_get FORM_device $vcfg device

		if [ "$FORM_device" = "$device" ]; then
			uci_set "wireless" "$vcfg" "network" "lan"
			uci_set "wireless" "$vcfg" "mode" "sta"
			uci_set "wireless" "$vcfg" "ssid" "$FORM_wifi"
				if [ "$FORM_wepkey" != "" ]; then
					uci_set "wireless" "$vcfg" "encryption" "$FORM_keytype"
					uci_set "wireless" "$vcfg" "key" "$FORM_wepkey"
				else
					uci_set "wireless" "$vcfg" "encryption" "none"
					uci_set "wireless" "$vcfg" "key" ""
				fi
		fi
	done
	uci_commit "wireless"

	#iwconfig wl0 mode "repeater"
	#iwconfig wl0 ESSID "$FORM_wifi"

	cat <<EOF
	<meta http-equiv="refresh" content="4;url=reboot.sh?reboot=do">
	<br>
	<b>Successfully joined "$FORM_wifi" network. Router must reboot ...<b>
EOF
	footer
	exit

else #<- if kamikaze

	nvram set wl0_mode="sta"
	nvram set wl0_infra="1"
	nvram set wl_ssid="$FORM_wifi"
	nvram commit

	WL_MODE=$(nvram get wl0_ifname)
	#wifi up 2>/dev/null >/dev/null </dev/null
	iwconfig $WL_MODE essid "$FORM_wifi"

	cat <<EOF
	<meta http-equiv="refresh" content="4;url=$SCRIPT_NAME">
	<br>
	<b>Successfully joined "$FORM_wifi" network ...<b>
EOF
	footer
	exit
fi #<- end if kamikaze

fi #<- end if Join WIFI


DisplayTable()
{

cat <<EOF
<script type="text/javascript" src="/js/window.js">
</script>
<script>
function java1(target) {
document.wepkeyform.wifi.value = target
}
</script>

<div id="dwindow" style="position:absolute;background-color:#EBEBEB;cursor:hand;left:0px;top:0px;display:none" onMousedown="initializedrag(event)" onMouseup="stopdrag()" onSelectStart="return false">
<table width="100%" border="0" ><tr bgcolor=navy><td><div align="right"><img src="/images/close.gif" onClick="closeit()"></div></td>
</tr></table>
<table width="100%" height="100%" border="0" cellspacing="1" bgcolor="#333333">
<tr height="1"><td bgcolor="#FFFFFF"><br>
<form action='$SCRIPT_NAME' method='post' name='wepkeyform'>
<table width="100%" border="0" >
<tr><td><img src="/images/wep.gif"></td>
<td><input type="text" name="wepkey">&nbsp;&nbsp;
<input type='submit' class='flatbtn' name='joinwifi' value='@TR<<Join>>' >
</td></tr><tr height="1"><td>Key:</td>
<td><select name="keytype">
<option value="wep" selected>WEP</option>
<option value="psk">PSK</option>
<option value="psk2">PSK2</option>
<option value="wpa">WPA</option>
<option value="wpa2">WPA2</option>
</select><input type="hidden" name="wifi" value=""></td>
</tr></table></form></td></tr></table></div>

<br><a href='$SCRIPT_NAME'>@TR<<Re-scan>></a><br><br><table width="98%" border="0" cellspacing="1" bgcolor="#999999" >
<tr class="wifiscantitle" >
<td width='32'>@TR<<Signal>>/</td>
<td width='32'>@TR<<Noise>></td>
<td>@TR<<Status>></td>
<td>@TR<<SSID>></td>
<td>@TR<<MAC>></td>
<td width='20'>@TR<<Channel>></td>
<td>@TR<<Rate>></td>
<td>&nbsp;</td>
</tr>
EOF

}

DisplayTR()
{

if [ "$color" = "1" ] ; then color="2" ; else color="1" ; fi

echo "<tr bgcolor="#FFFFFF" class="wifiscanrow$color">"

##### Signal Ratio

if [ $RSSI -lt 60 ]; then Wimg=5 ; elif [ $RSSI -lt 72 ]; then Wimg=4 ; elif [ $RSSI -lt 81 ]; then Wimg=3 ; elif [ $RSSI -lt 85 ]; then Wimg=2 ; elif [ $RSSI -lt 92 ]; then Wimg=1 ; else Wimg=0 ; fi
echo "<td><center><img src="/images/wifi$Wimg.gif" ALT='-" $RSSI "dBm'></center></td>"

##### Noise Ratio
if [ $NOISE -gt 95 ]; then Wimg=0 ; elif [ $NOISE -gt 92 ]; then Wimg=1 ; elif [ $NOISE -gt 88 ]; then Wimg=2 ; elif [ $NOISE -gt 85 ]; then Wimg=3 ; elif [ $NOISE -gt 80 ]; then Wimg=4 ; else Wimg=5 ; fi
echo "<td><center><img src="/images/wifi$Wimg.gif" ALT='-" $NOISE "dBm'></center></td>"

##### Security
if  [ "$SEC" = "ESS WEP" ] || [ "$SEC" = "on" ] ; then Wimg="wep" ; else Wimg="opn" ; fi

echo "<td><center><img src="/images/$Wimg.gif" ALT='$SEC'></center></td>"
echo "<td>&nbsp;&nbsp;" $SSID
#echo "$current_line" | cut -c8-20 | cut -d '"' -f1
echo "</td>"
echo "<td><center>" $BSSID "</center></td>"
echo "<td><center>" $CHANNEL "</center></td>"

##### Speed (needs improvements!)
if  [ "$RATE" = "66" ] ; then Wimg="54 Mbps" ; elif  [ "$RATE" = "75" ] ; then Wimg="54 Mbps" ; elif  [ "$RATE" = "44" ] ; then Wimg="11 Mbps" ; else Wimg="(?)" ; fi

echo "<td><center>$Wimg</center></td>"
echo "<td><center>"

	if  [ "$SEC" = "ESS WEP" ] || [ "$SEC" = "on" ] ; then
		echo "<input type='submit' style='border: 1px solid #000000; font-size:8pt; ' name='joinwifi' value='@TR<<Join>>' onClick=loadwindow('$SCRIPT_NAME/?wep=1&ssid=$SSID',300,100);java1('$SSID')>"
	else
		echo "<form action='$SCRIPT_NAME' method='post'><input type="hidden" name='wifi' value='$SSID'><input type='submit' style='border: 1px solid #000000; font-size:8pt; ' name='joinwifi' value='@TR<<Join>>'></form>"
	fi
echo "</center></td></tr>"


}


######################### The Scanning Part #####
##### wl scanning

WL()
{

if is_package_installed "wl" ; then 

Dopurge ()
{
sed 1d < $tempfile > $tempfile2
rm $tempfile
mv $tempfile2 $tempfile     
}

for counter in $(seq 1 $MAX_TRIES); do
	wl scan
	wl scanresults > $tempscan 2> /dev/null
	if equal $(sed '2,$ d' $tempscan | cut -c0-4) "SSID" ; then break ; fi
	sleep 1
done

if [ $counter -gt $MAX_TRIES ]; then
	echo "<tr><td>@TR<<Sorry, no scan results.>></td></tr>"
else

#---------------------------------------------
# We need to add a "break" on the first line!

current_line=$(grep -i '' < $tempscan)
echo "" > $tempfile
echo "$current_line" >> $tempfile
rm $tempscan
#--------------------------------------------

DisplayTable

# Read File
#-------------------------

while read f
do

# DEBUG
#------\/
#echo $f "<br>"

current_line=$(sed '2,$ d' $tempfile)

#echo "-> '" $current_line "'<br>"

if equal "$current_line" "" ; then
	let "current=1"
	#echo "->" $current
else
	let "current=0"		
fi

if equal "$current" "1" ;then

Dopurge

current_line=$(sed '2,$ d' $tempfile)

if equal "$current_line" "" ;then
echo ""
else

##### Set Variables
#current_line=$(sed '2,$ d' $tempfile)
SSID=$(sed '2,$ d' $tempfile | sed -e s/'SSID: '//g -e s/'"'//g)
Dopurge
RSSI=$(sed '2,$ d' $tempfile | cut -c22-23)
NOISE=$(sed '2,$ d' $tempfile | cut -c37-38)
CHANNEL=$(sed '2,$ d' $tempfile  | cut -c53-55 )
Dopurge
BSSID=$(sed '2,$ d' $tempfile  | cut -c7-24 )
SEC=$(sed '2,$ d' $tempfile  | cut -c38-44 )
Dopurge
RATE=$(sed '2,$ d' $tempfile  | wc -c)
#RATED=$(sed '2,$ d' $tempfile)

DisplayTR

fi
fi

Dopurge

done < $tempfile

rm $tempfile
#rm $tempfile2
echo "</table><br><a href='$SCRIPT_NAME'>@TR<<Re-scan>></a><br>"
fi
else

	if ! empty "$FORM_install_package"; then
	echo "Installing wl package ...<pre>"
	install_package "wl"
	echo "</pre>"
	fi

echo "<form enctype='multipart/form-data' action='$SCRIPT_NAME' method='post'>"
install_package_button="string|<div class=warning>Wireless Scanning will not work until you install "wl": </div>
submit|install_package| Install "wl" Package |"

display_form <<EOF
$install_package_button
EOF
echo "</form>"

fi
}

######### iwlist scanning
IWLIST()
{
#echo " Please wait while scan is performed ... <br /><br />"
found_networks=0
counter=0
for counter in $(seq 1 $MAX_TRIES); do
        #echo "."
        iwlist scan > $tempfile 2> /dev/null
        grep -i "Address" < $tempfile >> /dev/null
        equal "$?" "0" && break
        sleep 1
done

first_hit=1
if [ $counter -gt $MAX_TRIES ]; then
        echo "<tr><td>@TR<<Sorry, no scan results.>></td></tr>"
else

DisplayTable
        current=0
        counter=0
        for counter in $(seq 1 $MAX_CELLS); do
                current_line=$(sed '2,$ d' < $tempfile)
                empty "$current_line" && break
                # line must contain both "Cell" and "Address" to be considered
                #  start of a new cell..
                echo "$current_line" | grep "Cell" >> /dev/null
                result_one=$?
                echo "$current_line" | grep "Address" >> /dev/null
                result_two=$?
                if equal "$result_one" "0" && equal "$result_two" "0" ; then
                        if equal "$first_hit" "0" ; then
                                let "current+=1"
                        fi
                        first_hit=0
                fi
                if equal "$first_hit" "0" ; then
                        echo "$current_line" >> "$tempfile"_"${current}"
                fi

                sed 1d < $tempfile > $tempfile2
                rm $tempfile
                mv $tempfile2 $tempfile
        done

        current=0
        counter=0
        for counter in $(seq 1 $MAX_CELLS); do
                ! exists "$tempfile"_"${current}" && break
                ####################################################
                # parse out MAC
                address_pre=$(sed '2,$ d' < "$tempfile"_"${current}" | sed -e s/'Cell'//g -e s/'Address'//g -e s/'-'//g)
                count=0
                for i in $address_pre; do
                        case $count in
                                0) CELL_ID=$i;;
                                2) BSSID=$i;;
                                3) break;;
                        esac
                        let "count+=1"
                done

####################################################

SSID=$(grep -i "ESSID" < "$tempfile"_"${current}" | sed -e s/'ESSID:'//g -e s/'"'//g -e s/'  '//g)
CHANNEL=$(grep -i "Channel" < "$tempfile"_"${current}" | sed -e s/'Channel:'//g -e s/' '//g)

	quality_pre=$(grep -i "Quality" < "$tempfile"_"${current}" | sed -e s/'Quality:'//g -e s/'Signal level:'//g  -e s/'dBm'//g -e s/'Noise level:'//g -e s/'-'//g)
                count=0
	for i in $quality_pre; do
		case $count in
			0) QUALITY=$i;;
			1) RSSI=$i;;
			2) NOISE=$i
			break;;
		esac
			let "count+=1"
	done

SEC=$(grep -i "Encryption key" < "$tempfile"_"${current}" | sed -e s/'Encryption key:'//g -e s/' '//g)
RATE=1

DisplayTR
rm -f "$tempfile"_"${current}"
let "found_networks+=1"
let "current+=1"
done
fi #<- end if were scan results

rm -f "$tempfile"
rm -f "$tempfile2"
}


if is_kamikaze; then

	if is_package_installed "wl" ; then #<- for Broadcom units //[ -s "/usr/sbin/wl" ]
		WL
	else
		IWLIST
	fi
else
	IWLIST
fi

footer ?>
<!--
##WEBIF:name:Status:980:Site Survey
-->