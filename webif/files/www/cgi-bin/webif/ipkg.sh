#!/usr/bin/webif-page
<? 
. /usr/lib/webif/webif.sh
###################################################################
# Packages configuration page
#
# Description:
#	Allows installation and removal of packages.
#
# Author(s) [in order of work date]: 
#   OpenWrt developers (??)
#   todo: person who added descriptions..
#   eJunky
#   emag
#   Jeremy Collake <jeremy.collake@gmail.com>
#
# Major revisions:
#
# NVRAM variables referenced:
#   none
#
# Configuration files referenced: 
#   none
#
# Utilities/applets referenced:
#   ipkg
#
#

header "System" "Packages" "@TR<<Packages>>" '' "$SCRIPT_NAME"

##################################################################
# 
# Install from URL and Add Repository code - self-contained block.
#

! empty "$FORM_install_url" &&
{
	# just set up to pass-through to normal handler
	FORM_action="install"
	FORM_pkg="$FORM_pkgurl"	
}

! empty "$FORM_install_repo" &&
{	
	validate "string|FORM_repourl|@TR<<Repository URL>>|min=4 max=4096 required|$FORM_repourl"
	if equal "$?" "0"; then	
		# since firstboot doesn't make a copy of ipkg.conf, we must do it		
		# todo: need a mutex or lock here
		tmpfile=$(mktemp "/tmp/.webif-ipkg-XXXXXX")
		cp "/etc/ipkg.conf" "$tmpfile"
		echo "src $FORM_reponame $FORM_repourl" >> "$tmpfile"
		rm "/etc/ipkg.conf"
		mv "$tmpfile" "/etc/ipkg.conf"
		echo "<br />Repository sources updated. Performing update of package lists ...<br /><pre>"
		ipkg update
		echo "</pre>"
	else
		echo "<div class=\"warning\">ERROR: You did not specify all necessary repository fields.</div>"	
	fi
}


repo_list=$(awk '/src/ { print "string|<tr><td>" $2 "</td><td></td><td>" $3 "</td></tr>"}' /etc/ipkg.conf)

display_form <<EOF
start_form|@TR<<Add Repository>>
field|@TR<<Repo. Name>>
text|reponame|$FORM_reponame|
field|@TR<<Repo. URL>>
text|repourl|$FORM_repourl|
field|&nbsp;
submit|install_repo| Add Repository 
string|<tr><td><br /><br /><br /><br /></td></tr>
string|<tr><td colspan="2"><h4>@TR<<Current Repositories>>:</h4></td><td>
helpitem|Add Repository
helptext|Add Repository#A repository is a server that contains a list of packages that can be installed on your OpenWrt device. Adding a new one allows you to list packages here that are not shown by default.
$repo_list
helpitem|Backports Tip
helptext|HelpText Backports Tip#For a much larger assortment of packages, see if there is a backports repository available for your firmware (there is one for White Russian RC5). Such a repository brings
an offering of packages from the latest bleeding edge branch of the firmware.
end_form
start_form|@TR<<Install Package From URL>>
field|URL of Package
text|pkgurl|$FORM_pkgurl
field| 
submit|install_url|Install Package From URL |
helpitem|Install Package
helptext|Install Package#Normally one installs a package by clicking on the install link in the list of packages below. However, you can install a package not listed in the known repositories here.
end_form
EOF

# Block ends
##################################################################

display_form <<EOF
start_form|@TR<<Packages Available>>|||nohelp
EOF

?>
<a href="ipkg.sh?action=update">@TR<<Update package lists>></a>
<?
display_form <<EOF
end_form
EOF
?>

<?
echo "<pre>"
if [ "$FORM_action" = "update" ]; then	
	ipkg update
elif [ "$FORM_action" = "install" ]; then	
	yes n | ipkg install `echo "$FORM_pkg" | sed -e 's, ,+,g'`	
elif [ "$FORM_action" = "remove" ]; then	
	ipkg remove `echo "$FORM_pkg" | sed -e 's, ,+,g'`
fi
echo "</pre>"
?>
</pre>
<table>
  <h3>@TR<<Installed Packages>></h3>
  <br />
  <table style="width: 90%"><tr><th width="150">Action</th><th width="200">Package</th><th>Description</th></tr>
<?
ipkg list_installed | egrep -v "(base-files|bridge|busybox|uclibc|kernel|Done\.)" | awk -F ' ' '
$2 !~ /terminated/ {       
       link=$1
       gsub(/\+/,"%2B",link)
       desc=$5 " " $6 " " $7 " " $8 " " $9 " " $10 " " $11 " " $12 " " $13 " " $14 " " $15 " " $16 " " $17 " " $18 " " $19 " " $20 " " $21 " " $22 " " $23 " " $24 " " $25 " " $26 " " $27
       print "<tr><td><a href=\"ipkg.sh?action=remove&pkg=" link "\">@TR<<Uninstall>></td><td>" $1 "</td><td><font size=-1>" desc "</font></td></tr>"       
}
'
?>
  </table>
  <br />
  <h3>@TR<<Available packages>></h3>
  <br />
  <table style="width: 90%"><tr><th width="150">Action</th><th width="250">Package</th><th>Description</th></tr>
<?
egrep 'Package:|Description:' /usr/lib/ipkg/status /usr/lib/ipkg/lists/* 2>&- | sed -e 's, ,,' -e 's,/usr/lib/ipkg/lists/,,' | awk -F: '
$1 ~ /status/ {
	installed[$3]++;
}
($1 !~ /terminated/) && ($1 !~ /\/status/) && (!installed[$3]) && ($2 !~ /Description/) {
	if (current != $1) print "<tr><th>" $1 "</th></tr>"
	link=$3
	gsub(/\+/,"%2B",link)		
	getline descline
        split(descline,desc,":")
        print "<tr><td><a href=\"ipkg.sh?action=install&pkg=" link "\">@TR<<Install>></td><td>" $3 "</td><td><font size=-1>" desc[3] "</font></td></tr>"
        current=$1
}
'
?>
</table>
<br /><br /><br />

<? footer ?>
<!--
##WEBIF:name:System:300:Packages
-->
