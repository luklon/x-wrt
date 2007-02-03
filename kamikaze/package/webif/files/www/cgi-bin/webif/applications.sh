#!/usr/bin/webif-page
<?
###################################################################
# Applications page
#
# Description:
#        List and install additional applications.
#
# Author(s) [in order of work date]:        
#        Dmytro Dykhman <dmytro@iroot.ca>
#
# Major revisions:
#
#
# Configuration files referenced:
#   none
#
# TODO:

. /usr/lib/webif/functions.sh

count=0
var=""


HEADER="HTTP/1.0 200 OK
Content-type: text/html

<html><head>
<link rel="stylesheet" type="text/css" href="/themes/active/style-extend.css">
<script type="text/javascript" src="/js/balloontip.js">
</script><script type="text/javascript" src="/js/imgdepth.js">
</script>"


CONFIRM()
{
echo "<script type='text/javascript'>"
echo "<!--"
echo "function confirm$count() {"
echo "if (window.confirm(\"This package is not installed. \n\nDo you want to install it now?\n\n\n(Installation may include router reset) ...continue?\n\")){" 
echo "window.location=\"$var?package=install\""
echo "} }" 
echo "// --></script>"
let "count+=1"
}

HighLight="class='gradualshine' onMouseover='slowhigh(this)' onMouseout='slowlow(this)'"


if [ "$FORM_page" = "index" ]; then
echo $HEADER
echo "</head></html>"
exit

elif [ "$FORM_page" = "web" ]; then

cat <<EOF
$HEADER
</head>

<body>
<center>
<table width="98%" border="0" cellspacing="1" >

  <tr class='appindex'>
      <td width="20%"><center><a href="" rel="b1"><img src="/images/app.4.jpg" border="0" $HighLight ></a><br><font color=silver>Apache Webserver</font></center></td>
      <td width="20%"><div align="center"><a href="" rel="b2"><img src="/images/app.6.jpg" border="0" $HighLight ></a><br><font color=silver>FTP Server</font></div></td>
      <td width="20%"><div align="center"><a href="" rel="b3"><img src="/images/app.7.jpg" border="0" $HighLight ></a><br><font color=silver>MySQL Server</font></div></td>
      <td width="20%">&nbsp;</td>
      <td width="20%">&nbsp;</td>
  </tr>
  <tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
  </tr>
</table>
<div id="b1" class="balloonstyle">
Apache Web server 1.3.3 - Powerfull webserver to serve webpages on World Wide Web.
</div>

<div id="b2" class="balloonstyle">
ProFTPD ?.? - Powerfull FTP server for sharing files globally.
</div>

<div id="b3" class="balloonstyle">
MySQL 4.3 - Massive database server
</div></center></body></html>
EOF

elif [ "$FORM_page" = "security" ]; then
	
echo "$HEADER"
var="app.hydra.sh" ; CONFIRM

echo "</head><body><table width='98%' border='0' cellspacing='1' ><tr class='appindex'>"

	#------------------------
	if  [ -s "/usr/sbin/hydra" ]  ; then 

	#<<---If package is already installed--->>
	echo "<td width='20%'><center><a href='app.hydra.sh' rel='b1'><img src='/images/app.2.jpg' border='0'></a><br>Hydra</center></td>"
	else

	#<<---If package is NOT installed--->>
	echo "<td width='20%'><center><a href='javascript:confirm0()' rel='b1'><img src='/images/app.2.jpg' border='0' $HighLight ><a><br><font color=silver>Hydra</font></center></td>"
	fi
	#------------------------
	cat <<EOF
	<td width="20%">&nbsp;</td>
	<td width="20%">&nbsp;</td>
	<td width="20%">&nbsp;</td>
	<td width="20%">&nbsp;</td>
	</tr></table>
	<div id="b1" class="balloonstyle"  style="width: 300px;">
	Hydra 4.5 - "Password Brute Force" - attacker for checking weak passwords. Great utility to check your (http,ftp,ssh) services.
	</div>
	</body></html>
EOF

elif [ "$FORM_page" = "network" ]; then

echo "$HEADER"
var="app.samba.sh" ; CONFIRM
var="app.swap.sh" ; CONFIRM

echo "</head><body><table width='98%' border='0' cellspacing='1' ><tr class='appindex'>"

	##################################
	if  is_package_installed "kmod-cifs" && is_package_installed "cifsmount" ; then
	echo "<td width='20%'><center><a href='app.samba.sh' rel='b1'><img src='/images/app.10.jpg' border='0'></a><br>Samba Client</center></td>"
	else
	echo "<td width='20%'><center><a href='javascript:confirm0()' rel='b1'><img src='/images/app.10.jpg' border='0' $HighLight ><a><br><font color=silver>Samba Client</font></center></td>"
	fi
	##################################
	if  is_package_installed "kmod-loop" && is_package_installed "losetup" && is_package_installed "swap-utils" ; then
	echo "<td width='20%'><center><a href='app.swap.sh' rel='b2'><img src='/images/app.12.jpg' border='0'></a><br>Memory SWAP</center></td>"
	else
	echo "<td width='20%'><center><a href='javascript:confirm1()' rel='b2'><img src='/images/app.12.jpg' border='0' $HighLight><a><br><font color=silver>Memory SWAP</font></center></td>"
	fi
	#--------------------------------
	cat <<EOF
	<td width="20%">&nbsp;</td>
	<td width="20%">&nbsp;</td>
	<td width="20%">&nbsp;</td>
	</tr></table>
	<div id="b1" class="balloonstyle"  style="width: 200px;">
	Samba Client- Allows to map network drive from Windows based file system.
	</div>
	<div id="b2" class="balloonstyle"  style="width: 250px;">
	Memory SWAP - Allows to set more RAM by using external storage.<br><br>Examples: Network Drive, MMC, USB
	</div>
	</body></html>
EOF

elif [ "$FORM_page" = "remove" ]; then

	cat <<EOF
$HEADER
	</head>
	<table width="100%" border="0" cellspacing="1">
EOF
	#### Check list to remove

	pkgrmv="<input type='hidden' name='remove' value='1'><input type=submit class='flatbtn' name=rmvapp value='@TR<<Remove Application>>'>"

	echo "<tr><td colspan=2><br><u>> Web Applications</u><br><br></td></tr>"

	echo "<tr><td colspan=2><br><u>> Security Applications</u><br><br></td></tr>"
	if  [ -s "/usr/sbin/hydra" ]  ; then echo "<tr><td width=90%><img src='/images/app.2.jpg' width="22" height="22" align="absmiddle" >&nbsp;Hydra</td><td><form action='app.hydra.sh' method='post'>$pkgrmv</form></td></tr>" ; fi

	echo "<tr><td colspan=2><br><u>> Network Applications</u><br><br></td></tr>"
	if  is_package_installed "kmod-cifs"  &&  is_package_installed "cifsmount"  ; then echo "<tr><td width=90%><img src='/images/app.10.jpg' width="22" height="22" align="absmiddle" >&nbsp;Samba Client</td><td><form action='app.samba.sh' method='post'>$pkgrmv</form></td></tr>" ; fi
	if  is_package_installed "kmod-loop" && is_package_installed "swap-utils" &&  is_package_installed "losetup"  ; then echo "<tr><td width=90%><img src='/images/app.12.jpg' width="22" height="22" align="absmiddle" >&nbsp;Memory Swap</td><td><form action='app.swap.sh' method='post'>$pkgrmv</form></td></tr>" ; fi


	echo "</table></html>"
	exit

elif [ "$FORM_page" = "list" ]; then

	cat <<EOF
$HEADER
	</head><body >
	<table width="90%" border="0" cellpadding="0" cellspacing="0" >
	<tr>
	<td><a href="applications.sh?page=web" target="AppIndex"><img src="/images/app.8.jpg" border="0" ></a></td>
	<td><strong>Web Applications</strong></td>
	</tr>
	<tr>
	<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
	<td><a href="applications.sh?page=security" target="AppIndex"><img src="/images/app.5.jpg" border="0" ></a></td>
	<td><strong>Security Applications</strong></td>
	</tr>
	<tr>
	<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
	<td><a href="applications.sh?page=network" target="AppIndex"><img src="/images/app.9.jpg" border="0" ></a></td>
	<td><strong>Network Applications</strong></td>
	</tr>
	<tr>
	<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
	<td colspan=2 height=1 bgcolor="#CCCCCC"></td>
	</tr>
	<tr>
	<td><a href="applications.sh?page=remove" target="AppIndex"><img src="/images/app.11.jpg" border="0" ></a></td>
	<td><strong>Remove Applications</strong></td>
	</tr>
	<tr>
	<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
	</table></body></html>
EOF

else

. /usr/lib/webif/webif.sh

header "Applications" "List" "<img src=/images/app.jpg align="absmiddle">&nbsp;@TR<<List of Applications>>"

	cat <<EOF
	<font color="#FF0000">This page is currently in development process. Some features may not function. </font><br>
	<table width="95%" border="0" cellspacing="1">
	<tr><td width="30%">&nbsp;</td><td width="70%">&nbsp;</td></tr>
	<tr>
	<td>
	<IFRAME SRC="applications.sh?page=list" STYLE="width:100%; height:350px; border:1px dotted #888888;" FRAMEBORDER="0" SCROLLING="NO" name="AppList"></IFRAME>
	</td>
	<td>
	<IFRAME SRC="applications.sh?page=index" STYLE="width:90%; height:350px; border:1px dotted #888888;" FRAMEBORDER="0" SCROLLING="YES" name="AppIndex"></IFRAME>
	</td>
	</tr>
	<tr>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	</tr></table>
EOF
footer
fi

?>
<!--
##WEBIF:name:Applications:1:<List>
-->
