#!/usr/bin/webif-page
<?
. /usr/lib/webif/webif.sh
header "Status" "DHCP Clients" "@TR<<DHCP Leases>>"
?>
<table style="width: 90%; text-align: left;" border="0" cellpadding="2" cellspacing="2" align="center">
<tbody>
	<tr>
		<th>@TR<<MAC Address>></th>
		<th>@TR<<IP Address>></th>
		<th>@TR<<Name>></th>
		<th>@TR<<Expires in>></th>
	</tr>
<? exists /tmp/dhcp.leases && awk -vdate="$(date +%s)" '
$1 > 0 {
	print "<tr>"
	print "<td>" $2 "</td>"
	print "<td>" $3 "</td>"
	print "<td>" $4 "</td>"
	print "<td>"
	t = $1 - date
	h = int(t / 60 / 60)
	if (h > 0) printf h "h "
	m = int(t / 60 % 60)
	if (m > 0) printf m "min "
	s = int(t % 60)
	printf s "sec "
	printf "</td>"
	print "</tr>"
}
' /tmp/dhcp.leases
exists /tmp/dhcp.leases && grep -q "." /tmp/dhcp.leases > /dev/null
! equal "$?" "0" &&
{
	echo "<tr><td>@TR<<There are no known DHCP leases.>></td></tr>"
}
?>
<tr><td><br /><br /></td></tr>
</tbody></table>
<table width="100%"><tbody>
<tr><td><font size="-1"><strong>@TR<<DHCP Leases>>:</strong>&nbsp; @TR<<HelpText DHCP Leases#DHCP leases are assigned to network clients that request an IP address from the DHCP server of the router. Clients that requested their IP lease before this router was last rebooted may not be listed until they request a renewal of their lease.>></font></td></tr>
<tr><td><br /><br /></td></tr>
</tbody>
</table>
<br />
<?
show_validated_logo
footer ?>
<!--
##WEBIF:name:Status:200:DHCP Clients
-->
