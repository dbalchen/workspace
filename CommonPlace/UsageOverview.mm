<map version="freeplane 1.3.0">
<!--To view this file, download free mind mapping software Freeplane from http://freeplane.sourceforge.net -->
<node ID="sec-2" CREATED="1553536041435" MODIFIED="1553540072026" COLOR="#0033ff" LINK="CommonPlace.mm"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Usage Overview
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" COLOR="#808080" WIDTH="8"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Usage is made up of events which are records of transactions made by our customers. We tend to think of usage
in two ways, <b>Voice</b> and <b>Data</b>.<br  />
</p>

<p>
<b>Voice</b>
</p>
<ol class="org-ol">
<li><b>Alcatel Lucent (APLX)</b> - The <b>Alcatel Lucent APLX</b> switch record
are found mostly in the Maine market. This switch produces both
<i>Mobile Originating and Mobile Terminated</i> records.</li>
<li><b>Nortel (NTI)</b> - The <b>NORTEL NTI</b> switch record is the most common
voice record format and since an NTI record contains both the
<i>originating and terminating features</i> certain call types may
result in a record being generated.</li>
<li><b>CIBER</b> - For <i>InCollect and OutCollect</i> processing.<br  /></li>
</ol>

<p>
<b>Data</b>
</p>
<ol class="org-ol">
<li><b>SMSC Server</b> - Both <b>Motorola</b> and <b>Acatel-Lucent SMS</b> records
that can be either a <i>Mobile Originating or Terminating</i> record
type.</li>
<li><b>AAA Server</b> - Produces one record for each complete data session.
<ul class="org-ul">
<li><b>PGW</b> - P-Gateway <b>LTE</b> data usage</li>
<li><b>ECS</b> - ECS <b>3G and lower</b> data usage.</li>
<li><b>AAA</b> - Raw AAA usage found on the CallDump only.</li>
<li><b>TAS</b> - <i>Volte</i> Voice over <b>LTE</b>.</li>
</ul></li>
<li><b>VALI</b> - <i>Premium SMS (Valista)</i> pre-rated records one record per
event.</li>
<li><b>GSM Roaming</b> - Voice and data records from our customers who are
roaming in Europe and other <b>GSM</b> countries.</li>
<li><b>MMSC</b> - Used for both pictures and picture messaging text only
(treated as an <b>SMS</b> message in the system). Produces both <i>Mobile
Originating and Terminating</i> records with a possible one to many
relationships (multiple recipients).</li>
<li><b>TAP</b> - Used for Incollect/Outcollect <b>4G</b> processing.</li>
</ol>
</body>
</html>
</richcontent>
<hook NAME="MapStyle" zoom="0.566">
    <properties show_icon_for_attributes="true" show_note_icons="true"/>

<map_styles>
<stylenode LOCALIZED_TEXT="styles.root_node">
<stylenode LOCALIZED_TEXT="styles.predefined" POSITION="right">
<stylenode LOCALIZED_TEXT="default" MAX_WIDTH="600" COLOR="#000000" STYLE="as_parent">
<font NAME="SansSerif" SIZE="10" BOLD="false" ITALIC="false"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.details"/>
<stylenode LOCALIZED_TEXT="defaultstyle.note"/>
<stylenode LOCALIZED_TEXT="defaultstyle.floating">
<edge STYLE="hide_edge"/>
<cloud COLOR="#f0f0f0" SHAPE="ROUND_RECT"/>
</stylenode>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.user-defined" POSITION="right">
<stylenode LOCALIZED_TEXT="styles.topic" COLOR="#18898b" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subtopic" COLOR="#cc3300" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subsubtopic" COLOR="#669900">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.important">
<icon BUILTIN="yes"/>
</stylenode>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.AutomaticLayout" POSITION="right">
<stylenode LOCALIZED_TEXT="AutomaticLayout.level.root" COLOR="#000000">
<font SIZE="18"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,1" COLOR="#0033ff">
<font SIZE="16"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,2" COLOR="#00b439">
<font SIZE="14"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,3" COLOR="#990000">
<font SIZE="12"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,4" COLOR="#111111">
<font SIZE="10"/>
</stylenode>
</stylenode>
</stylenode>
</map_styles>
</hook>
<node POSITION="left" ID="sec-2-1" CREATED="1553536041435" MODIFIED="1553536041435" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Network Elements
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Element</b></th>
<th scope="col" class="org-left"><b>New Host</b></th>
<th scope="col" class="org-left"><b>New Directory</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">APPL</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI1/APPL</td>
</tr>

<tr>
<td class="org-left">ASHE</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI1/ASHE</td>
</tr>

<tr>
<td class="org-left">CDP</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/CONT/CDP</td>
</tr>

<tr>
<td class="org-left">CDR2</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI1/CDR2</td>
</tr>

<tr>
<td class="org-left">CIB_IC</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/switch/DIRI</td>
</tr>

<tr>
<td class="org-left">CIB_OCR</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/switch/SYNR</td>
</tr>

<tr>
<td class="org-left">CLIN</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI1/CLIN</td>
</tr>

<tr>
<td class="org-left">COLU</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI1/COLU</td>
</tr>

<tr>
<td class="org-left">CONG</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI1/CONG</td>
</tr>

<tr>
<td class="org-left">ECS</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/AAA/AAA1</td>
</tr>

<tr>
<td class="org-left">EURE</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI1/EURE</td>
</tr>

<tr>
<td class="org-left">GRAN</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI1/GRAN</td>
</tr>

<tr>
<td class="org-left">GREE</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI1/GREE</td>
</tr>

<tr>
<td class="org-left">GSM_IR</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/GSMI/GSMS</td>
</tr>

<tr>
<td class="org-left">GSM_IR</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/GSMI/GSMV</td>
</tr>

<tr>
<td class="org-left">JOHN</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI1/JOHN</td>
</tr>

<tr>
<td class="org-left">JOPL</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI1/JOPL</td>
</tr>

<tr>
<td class="org-left">KNOX</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI1/KNOX</td>
</tr>

<tr>
<td class="org-left">LLYN</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/APLX/LLYN</td>
</tr>

<tr>
<td class="org-left">LROE</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/APLX/LROE</td>
</tr>

<tr>
<td class="org-left">LTE</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/PGW/PGW1</td>
</tr>

<tr>
<td class="org-left">LTE</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/GSMI/GSMD</td>
</tr>

<tr>
<td class="org-left">MADI</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI1/MADI</td>
</tr>

<tr>
<td class="org-left">MEDF</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI2/MEDF</td>
</tr>

<tr>
<td class="org-left">MMSC</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/SMS_MMS/PMG1</td>
</tr>

<tr>
<td class="org-left">MMSC</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/SMS_MMS/PTX1</td>
</tr>

<tr>
<td class="org-left">MORG</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/APLX/MORG</td>
</tr>

<tr>
<td class="org-left">NEWB</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI2/NEWB</td>
</tr>

<tr>
<td class="org-left">OKLA</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI2/OKLA</td>
</tr>

<tr>
<td class="org-left">OMAH</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI1/OMAH</td>
</tr>

<tr>
<td class="org-left">OWAS</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI2/OWAS</td>
</tr>

<tr>
<td class="org-left">PEO2</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI2/PEO2</td>
</tr>

<tr>
<td class="org-left">ROC2</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI2/ROC2</td>
</tr>

<tr>
<td class="org-left">SALI</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI2/SALI</td>
</tr>

<tr>
<td class="org-left">SMS_NSN</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/SMS_MMS/MOT</td>
</tr>

<tr>
<td class="org-left">SMS_NSN</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/GSMI/GSMT</td>
</tr>

<tr>
<td class="org-left">TAS</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/TAS/TAS1</td>
</tr>

<tr>
<td class="org-left">VALISTA</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/CONT/VALI</td>
</tr>

<tr>
<td class="org-left">YAKI</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/NTI2/YAKI</td>
</tr>

<tr>
<td class="org-left">TAP_IN</td>
<td class="org-left">kpr01bchl4</td>
<td class="org-left">/pkgbl04/inf/prdsys/prodwrk4/var/usc/projs/smm/DATA/TAPIN</td>
</tr>

<tr>
<td class="org-left">TAP_OUT</td>
<td class="org-left">kpr01bchl4</td>
<td class="org-left">/pkgbl04/inf/prdsys/prodwrk4/var/usc/projs/smm/DATA/TAPOUT</td>
</tr>

<tr>
<td class="org-left">APRM</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/switch/DATAIN</td>
</tr>

<tr>
<td class="org-left">CIB_IC</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/switch/DATACBR</td>
</tr>

<tr>
<td class="org-left">CIB_IC</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/switch/DIRI</td>
</tr>

<tr>
<td class="org-left">CIB_ICR</td>
<td class="org-left">kpr01bchl2</td>
<td class="org-left">/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/apr/interfaces/output</td>
</tr>

<tr>
<td class="org-left">SGW/DISP</td>
<td class="org-left">kpr01bchl3</td>
<td class="org-left">/pkgbl03/inf/prdsys/operaprm/var/usc/LSN/input2</td>
</tr>

<tr>
<td class="org-left">GSM_IR</td>
<td class="org-left">kpr01bchl4</td>
<td class="org-left">/pkgbl04/inf/prdsys/prodwrk4/var/usc/projs/smm/DATA/TAPIN</td>
</tr>

<tr>
<td class="org-left">RAP_IN</td>
<td class="org-left">kpr01bchl4</td>
<td class="org-left">/pkgbl04/inf/prdsys/prodwrk4/var/usc/projs/smm/DATA/RAPIN</td>
</tr>

<tr>
<td class="org-left">RAP_OUT</td>
<td class="org-left">kpr01bchl4</td>
<td class="org-left">/pkgbl04/inf/prdsys/prodwrk4/var/usc/projs/smm/DATA/RAPOUT</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node POSITION="left" ID="sec-2-2" CREATED="1553536041435" MODIFIED="1553536041435" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Pre-Pay and Data Roaming
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
In addition to <b>Post-Pay</b> we also handle <b>Pre-Pay</b> which follows a
different flow using the diameter interface. The <b>Diameter
interface</b> is described as follows:
</p>

<ul class="org-ul">
<li><b>Diameter</b> is a <b>AAA</b> protocol, a type of computer networking
protocol for authentication, authorization and accounting, and
is a successor to <b>RADIUS</b>. <b>Diameter</b> controls communication
between the authenticator (Secure Ticket Authority, STA) and
any network entity requesting authentication. <b>Diameter
Applications</b> extend the base protocol by adding new commands
and/or attributes, such as those for use of the Extensible
Authentication Protocol (<b>EAP</b>).</li>
</ul>
</body>
</html>
</richcontent>
</node>
<node POSITION="left" ID="sec-2-3" CREATED="1553536041436" MODIFIED="1553536041436" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Carrier Code and Names
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
SQL Statement which produced this data:
</p>
<pre class="example">
select distinct carr_name, carr_cd from prm_app.PRM_REP_CARR_INFO
</pre>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">CARRIER_NAME</th>
<th scope="col" class="org-left">CARRIER_CODE</th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">AT&amp;T Mobility (USAAT)</td>
<td class="org-left">USAAT</td>
</tr>

<tr>
<td class="org-left">AT&amp;T Mobility (USACG)</td>
<td class="org-left">USACG</td>
</tr>

<tr>
<td class="org-left">AT&amp;T Mobility (USABS)</td>
<td class="org-left">USABS</td>
</tr>

<tr>
<td class="org-left">Pioneer Cellular (USAPI)</td>
<td class="org-left">USAPI</td>
</tr>

<tr>
<td class="org-left">T-Mobile (USATM)</td>
<td class="org-left">USATM</td>
</tr>

<tr>
<td class="org-left">Nex-Tech Wireless (USA6G)</td>
<td class="org-left">USA6G</td>
</tr>

<tr>
<td class="org-left">AT&amp;T Mobility (USAPB)</td>
<td class="org-left">USAPB</td>
</tr>

<tr>
<td class="org-left">AT&amp;T Mobility (USAMF)</td>
<td class="org-left">USAMF</td>
</tr>

<tr>
<td class="org-left">Sprint (USASG)</td>
<td class="org-left">USASG</td>
</tr>

<tr>
<td class="org-left">T-Mobile (USAW6)</td>
<td class="org-left">USAW6</td>
</tr>

<tr>
<td class="org-left">Sprint (USASP)</td>
<td class="org-left">USASP</td>
</tr>

<tr>
<td class="org-left">Verizon (USAVZ)</td>
<td class="org-left">USAVZ</td>
</tr>

<tr>
<td class="org-left">Vodafone Netherlands (NLDLT)</td>
<td class="org-left">NLDLT</td>
</tr>

<tr>
<td class="org-left">AT&amp;T Mobility (USACC)</td>
<td class="org-left">USACC</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node POSITION="left" ID="sec-2-4" CREATED="1553536041436" MODIFIED="1553536041436" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Usage Time Zones
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Usage Type</b></th>
<th scope="col" class="org-left"><b>TimeZone</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">AAA</td>
<td class="org-left">GMT</td>
</tr>

<tr>
<td class="org-left">PGW/LTE</td>
<td class="org-left">GMT</td>
</tr>

<tr>
<td class="org-left">PMG/PTX</td>
<td class="org-left">GMT</td>
</tr>

<tr>
<td class="org-left">TAS</td>
<td class="org-left">GMT</td>
</tr>

<tr>
<td class="org-left">MOT/ALU</td>
<td class="org-left">EST</td>
</tr>

<tr>
<td class="org-left">VoLTE</td>
<td class="org-left">Switch Location</td>
</tr>

<tr>
<td class="org-left">Voice</td>
<td class="org-left">Switch Location</td>
</tr>

<tr>
<td class="org-left">CIBER</td>
<td class="org-left">Switch Location</td>
</tr>

<tr>
<td class="org-left">GSMD/V/S</td>
<td class="org-left">GMT</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node POSITION="left" ID="sec-2-5" CREATED="1553536041436" MODIFIED="1553536041436" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Duplicate Record Keys
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Columns used to detect if a record is a duplicate.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>MMS</b></th>
<th scope="col" class="org-left"><b>SMS</b></th>
<th scope="col" class="org-left"><b>Content</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">1. Event type ID</td>
<td class="org-left">1. Event type ID</td>
<td class="org-left">1. Event type ID</td>
</tr>

<tr>
<td class="org-left">2. Start time</td>
<td class="org-left">2. Start time</td>
<td class="org-left">2. Start time</td>
</tr>

<tr>
<td class="org-left">3. Resource value</td>
<td class="org-left">3. Resource value</td>
<td class="org-left">3. Resource value</td>
</tr>

<tr>
<td class="org-left">4. Call direction</td>
<td class="org-left">4. Call direction</td>
<td class="org-left">4. Content session ID</td>
</tr>

<tr>
<td class="org-left">5. Called number</td>
<td class="org-left">5. Called number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">6. Calling number</td>
<td class="org-left">6. Calling number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
<tbody>
<tr>
<td class="org-left"><b>Voice</b></td>
<td class="org-left"><b>Data</b></td>
<td class="org-left"><b>LTE</b></td>
</tr>
</tbody>
<tbody>
<tr>
<td class="org-left">1. Event type ID</td>
<td class="org-left">1. Event type ID</td>
<td class="org-left">1. Event type ID</td>
</tr>

<tr>
<td class="org-left">2. Start time</td>
<td class="org-left">2. Start time</td>
<td class="org-left">2. Start time</td>
</tr>

<tr>
<td class="org-left">3. Resource value</td>
<td class="org-left">3. Resource value</td>
<td class="org-left">3. Resource value</td>
</tr>

<tr>
<td class="org-left">4. Call direction</td>
<td class="org-left">4. Call direction</td>
<td class="org-left">4. Call direction</td>
</tr>

<tr>
<td class="org-left">5. Surcharge indicator</td>
<td class="org-left">5. Call source</td>
<td class="org-left">5. Call source</td>
</tr>

<tr>
<td class="org-left">6. Air elapsed time</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">7. Calling number</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node POSITION="left" ID="sec-2-6" CREATED="1553536041436" MODIFIED="1553536041436" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Guide By Criteria
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Data Types</b></th>
<th scope="col" class="org-left"><b>Guide By</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">voice</td>
<td class="org-left">MSID</td>
</tr>

<tr>
<td class="org-left">GSM</td>
<td class="org-left"><b>IMSI</b></td>
</tr>

<tr>
<td class="org-left">SMS</td>
<td class="org-left">MDN</td>
</tr>

<tr>
<td class="org-left">VOLTE/TAS</td>
<td class="org-left">IMSI</td>
</tr>

<tr>
<td class="org-left">PMG/PTX</td>
<td class="org-left">MSID</td>
</tr>

<tr>
<td class="org-left">AAA</td>
<td class="org-left">MSID</td>
</tr>

<tr>
<td class="org-left"><b>PGW/LTE</b></td>
<td class="org-left"><b>MDN/IMSI</b></td>
</tr>

<tr>
<td class="org-left">Vali</td>
<td class="org-left">MDN</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node POSITION="left" ID="sec-2-7" CREATED="1553536041436" MODIFIED="1553536041436" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>US Territories
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
These calls are identified as international but are charged
domestic rates.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-right" />

<col  class="org-right" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-right">Country Code</th>
<th scope="col" class="org-right">Area Code</th>
<th scope="col" class="org-left">ISO Country Code</th>
<th scope="col" class="org-left">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-right">1</td>
<td class="org-right">340</td>
<td class="org-left">VIR</td>
<td class="org-left">United States Virgin Islands</td>
</tr>

<tr>
<td class="org-right">1</td>
<td class="org-right">670</td>
<td class="org-left">MNP</td>
<td class="org-left">Northern Mariana Islands</td>
</tr>

<tr>
<td class="org-right">1</td>
<td class="org-right">671</td>
<td class="org-left">GUM</td>
<td class="org-left">Guam</td>
</tr>

<tr>
<td class="org-right">1</td>
<td class="org-right">684</td>
<td class="org-left">ASM</td>
<td class="org-left">American Samoa</td>
</tr>

<tr>
<td class="org-right">1</td>
<td class="org-right">787/939</td>
<td class="org-left">PRI</td>
<td class="org-left">Puerto Rico</td>
</tr>
</tbody>
</table>


<div class="figure">
<p><img src="Pictures/usage_flow.jpg" alt="usage_flow.jpg" />
</p>
</div>



<div class="figure">
<p><img src="Pictures/roamingPrePay.png" alt="roamingPrePay.png" />
</p>
</div>
</body>
</html>
</richcontent>
</node>
<node POSITION="left" ID="sec-2-8" CREATED="1553536041437" MODIFIED="1553536041437" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Voice Overview
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
One major undertaking in the transition to <b>TOPS</b> is moving most of the voice mediation to the <b>INTEC</b> platform. To help facilitate this move, the current rules system <b>(RBMS)</b> was studied and documented. The following provides a brief overview of the processes used.
</p>
</body>
</html>
</richcontent>
<node ID="sec-2-8-1" CREATED="1553536041437" MODIFIED="1553536041437" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Call Types
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<ol class="org-ol">
<li><b>M-M</b> - Mobile to Mobile</li>
<li><b>M-L</b> - Mobile to Land Line</li>
<li><b>L-M</b> - Land Line to Mobile</li>
<li><b>L-L</b> - Land Line to Land Line</li>
</ol>
<p>
The call records can come in four possible states.
</p>
<ol class="org-ol">
<li>Mobile Terminating (Incoming)</li>
<li>Mobile Originating (Outgoing)</li>
<li><b>NTI ONLY</b>
<ul class="org-ul">
<li><b>Both</b>  \newline <b>(NTI Mobile to Mobile)</b> in which for every voice event, two records are created, a <b>Mobile Originated</b> and <b>Mobile Terminated</b> record. For <b>APLX</b> this is taken care of automatically. In the case of an <b>NTI</b> switch, depending on the call scenario, it is up to the mediation platform to create one if needed.</li>
<li><b>Neither</b> \newline (per example <b>L-L</b> )</li>
</ul></li>
</ol>

<div class="figure">
<p><img src="Pictures/white-charles-harvest_talk.jpg" alt="white-charles-harvest_talk.jpg" />
</p>
</div>
</body>
</html>
</richcontent>
</node>
<node TEXT="Incoming - Mobile Terminated" ID="sec-2-8-2" CREATED="1553536041437" MODIFIED="1553536169871" COLOR="#990000">
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
An <b>Incoming</b> call is a <i>mobile terminated</i> call where one of
our customers receives a call from some caller to a <b>USCC</b>
switch.<br  />
<b>The diagram below shows the data flow for an incoming
call:</b> <br  />
</p>

<div class="figure">
<p><img src="Pictures/incoming.png" alt="incoming.png" />
</p>
</div>
</body>
</html>
</richcontent>
</node>
<node ID="sec-2-8-3" CREATED="1553536041437" MODIFIED="1553536041437" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Outgoing - Mobile Originated
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
An <b>outgoing</b> call is a <i>mobile originating</i> call from a <b>USCC</b> customer in which the following can occur.<br  />
<b>The diagram below shows the data flow for an outgoing call:</b>
<br  />
</p>

<div class="figure">
<p><img src="Pictures/outgoing.png" alt="outgoing.png" />
</p>
</div>
</body>
</html>
</richcontent>
</node>
</node>
<node POSITION="left" ID="sec-7-4" CREATED="1553536041452" MODIFIED="1553536041452" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Usage Tables
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<node ID="sec-7-4-1" CREATED="1553536041452" MODIFIED="1553536041452" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AGREEMENT_RESOURCE
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Trx_Id</td>
<td class="org-left">Number (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">To_Resource_Val</td>
<td class="org-left">Varchar2 (200 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Resrc_Seq_No</td>
<td class="org-left">Number (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Resource_Value</td>
<td class="org-left">Varchar2 (200 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Resource_Type</td>
<td class="org-left">Varchar2 (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Resource_State</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Resource_Scope_Id</td>
<td class="org-left">Varchar2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Resource_Prm_Cd</td>
<td class="org-left">Varchar2 (255 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Resource_Category</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Range_Ind</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Offer_Instance_Id</td>
<td class="org-left">Number (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ins_Trx_Id</td>
<td class="org-left">Number (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">From_Resource_Val</td>
<td class="org-left">Varchar2 (200 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Expiration_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Exp_Issue_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Effective_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Eff_Issue_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Conv_Run_No</td>
<td class="org-left">Number (3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Base_Param_Name</td>
<td class="org-left">Varchar2 (255 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Agreement_No</td>
<td class="org-left">Number (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Agreement_Key</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-4-2" CREATED="1553536041453" MODIFIED="1553536041453" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>CM1_AGREEMENT_PARAM
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
In the PRDCUST database. 
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Agreement_Key</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Agreement_No</td>
<td class="org-left">Number (10)</td>
<td class="org-left">Is Equal To The</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Subscriber Number</td>
</tr>

<tr>
<td class="org-left">Param_Seq_No</td>
<td class="org-left">Number (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Param_Name</td>
<td class="org-left">Varchar2 (255 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Param_Values</td>
<td class="org-left">Varchar2 (4000 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Effective_Date</b></td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Expiration_Date</b></td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Agr_Level</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Source_Agr_No</td>
<td class="org-left">Number (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Trx_Id</td>
<td class="org-left">Number (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ins_Trx_Id</td>
<td class="org-left">Number (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Eff_Issue_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Exp_Issue_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Conv_Run_No</td>
<td class="org-left">Number (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Offer_Instance_Id</td>
<td class="org-left">Number (10)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-4-3" CREATED="1553536041453" MODIFIED="1553536041453" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AC1_CONTROL (-HIST)
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Similar to <b>ac_processing_accounting</b> there are two tables
with the same name but in different databases, <b>PRDAF</b> (Usage)
and <b>PRDCUST</b> (AR).
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left"><b>Identifier</b></td>
<td class="org-left">Number(15,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char(6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>File_Name</b></td>
<td class="org-left">Varchar2(200 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>File_Path</b></td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Seq_No</td>
<td class="org-left">Number(6,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Host_Name</td>
<td class="org-left">Varchar2(50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Data_Group</td>
<td class="org-left">Varchar2(64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Create_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>File_Status</b></td>
<td class="org-left">Varchar2(2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Origin_File_Ident</b></td>
<td class="org-left">Number(15,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Phy_File_Ident</b></td>
<td class="org-left">Number(15,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Cur_Pgm_Name</td>
<td class="org-left">Varchar2(32 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Cur_File_Alias</td>
<td class="org-left">Varchar2(10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Nxt_Pgm_Name</td>
<td class="org-left">Varchar2(32 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Nxt_File_Alias</td>
<td class="org-left">Varchar2(10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Format</td>
<td class="org-left">Varchar2(10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Group</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Type</td>
<td class="org-left">Char(2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Repro_Ind</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Source_Type</td>
<td class="org-left">Char(10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Source_File_Type</td>
<td class="org-left">Char(10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Deleted_Ind</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System_Id</td>
<td class="org-left">Char(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Abp_Var</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Priority</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Wr_Rec_Quantity</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Wr_Time_Quantity</td>
<td class="org-left">Number(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Wr_Money_Quantity</td>
<td class="org-left">Number(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Wr_Euro_Quantity</td>
<td class="org-left">Number(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">In_Rec_Quantity</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">In_Time_Quantity</td>
<td class="org-left">Number(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">In_Money_Quantity</td>
<td class="org-left">Number(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">In_Euro_Quantity</td>
<td class="org-left">Number(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Gn_Rec_Quantity</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Gn_Time_Quantity</td>
<td class="org-left">Number(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Gn_Money_Quantity</td>
<td class="org-left">Number(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Gn_Euro_Quantity</td>
<td class="org-left">Number(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dr_Rec_Quantity</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dr_Time_Quantity</td>
<td class="org-left">Number(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dr_Money_Quantity</td>
<td class="org-left">Number(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dr_Euro_Quantity</td>
<td class="org-left">Number(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Processed_Rec_No</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rejected_Reason_Cd</td>
<td class="org-left">Char(3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Owner_Name</td>
<td class="org-left">Varchar2(50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Table_Alias</td>
<td class="org-left">Number(5,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Nxt_Process_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Nxt_Process_Start_Time</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Cur_Process_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Max_Event_Time</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Logical_File_Ident</td>
<td class="org-left">Number(15,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Table_Issue_Code</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">External_Id</td>
<td class="org-left">Varchar2(32 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dest_Rout_Crtria</td>
<td class="org-left">Varchar2(24 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Status_Category</td>
<td class="org-left">Varchar2(20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Status_Code</td>
<td class="org-left">Varchar2(200 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Code</td>
<td class="org-left">Varchar2(50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Size</td>
<td class="org-left">Number(15,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Recycle_Counter</td>
<td class="org-left">Number(15,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Group_Sequence</td>
<td class="org-left">Number(15,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Out_Req_Quantity</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Bulk_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Store_Mode</td>
<td class="org-left">Char(2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Session_Id</td>
<td class="org-left">Number(15,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Target_File_Path</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Target_Host</td>
<td class="org-left">Varchar2(50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ext_Identifier</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ext_Orig_Ident</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Additional_Attr</td>
<td class="org-left">Varchar2(300 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Group_Size</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Monitor_Data</td>
<td class="org-left">Varchar2(50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Wr_Volume_Quantity</td>
<td class="org-left">Number(15,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">In_Volume_Quantity</td>
<td class="org-left">Number(15,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Gn_Volume_Quantity</td>
<td class="org-left">Number(15,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dr_Volume_Quantity</td>
<td class="org-left">Number(15,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">End_Process_Time</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Fr_Time</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Eng_Priority</td>
<td class="org-left">Number(1,0)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-4-4" CREATED="1553536041454" MODIFIED="1553536041454" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>APE1_RATED_EVENT
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Where all the rateable events are contained. Most data inquires
usually wind up here.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left"><b>Cycle_Code</b></td>
<td class="org-left">Number (4)</td>
<td class="org-left">See Usage Db By Cycle</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">For Complete List.</td>
</tr>

<tr>
<td class="org-left"><b>Cycle_Instance</b></td>
<td class="org-left">Number (2)</td>
<td class="org-left">Cycle Month</td>
</tr>

<tr>
<td class="org-left">Customer_Segment</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Customer_Id</b></td>
<td class="org-left">Number (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_Id</td>
<td class="org-left">Number (18)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Subscriber_Id</b></td>
<td class="org-left">Number (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Start_Time</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Event_Type_Id</b></td>
<td class="org-left">Number (9)</td>
<td class="org-left">The Event Type</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Voice - 62</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Data - 51</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Lte - 69</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Sms - 54</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Mms - 60</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Volte - 69</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left"><i>See Wiki Table</i></td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left"><i>For Complete List</i></td>
</tr>

<tr>
<td class="org-left">Target_Cycle_Code</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Cycle_Year</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Billing_Arrangement</td>
<td class="org-left">Number (18)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Source_Id</td>
<td class="org-left">Number (15)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_State</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">X = Stripped</td>
</tr>

<tr>
<td class="org-left">Event_State_Reason_Code</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rerate_Type</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Original_Event_Id</td>
<td class="org-left">Number (18)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Resource_Value</td>
<td class="org-left">Varchar2 (63 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Resource_Type</b></td>
<td class="org-left">Varchar2 (16 Byte)</td>
<td class="org-left">0 - Mdn</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">19 - Min</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">21 - Outcollects</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">23 - Imsi</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Update_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Version_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Network_Start_Time</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_Status</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_Counters</td>
<td class="org-left">Number (20)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Token_Id</td>
<td class="org-left">Number (20)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_Account</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_Additional_Chg_Amt</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_Airtime_Chg_Amt</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_Basic_Service_Code</td>
<td class="org-left">Varchar2 (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L3_Calling_Country_Code</b></td>
<td class="org-left">Varchar2 (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L3_Call_Category</b></td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">Volte = 'V'</td>
</tr>

<tr>
<td class="org-left"><b>L3_Call_Direction</b></td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">1 = Incoming</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">2 = Outgoing</td>
</tr>

<tr>
<td class="org-left">L3_Call_Source</td>
<td class="org-left">Varchar2 (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L3_Charge_Amount</b></td>
<td class="org-left">Number</td>
<td class="org-left">The Amount Charged</td>
</tr>

<tr>
<td class="org-left">L3_Charge_Code</td>
<td class="org-left">Varchar2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_Chg_Amt_Inc_Free_Allow</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_Customer_Offer_Currency</td>
<td class="org-left">Varchar2 (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_Discount_Amount</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L3_Duration</b></td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L3_Imsi</b></td>
<td class="org-left">Varchar2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L3_Offer_Id</b></td>
<td class="org-left">Number</td>
<td class="org-left">The Price Plan</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">The Event Was</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Rated Against.</td>
</tr>

<tr>
<td class="org-left">L3_Original_Charge_Amount</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_Payment_Category</td>
<td class="org-left">Varchar2 (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_Pay_Channel</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L3_Physical_File_Id</b></td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_Pricing_Item_Id</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_Rounded_Unit</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_Special_Number_Group</td>
<td class="org-left">Varchar2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_Starting_Period</td>
<td class="org-left">Varchar2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_Target_Customer_Id</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_Unapplied_Amount</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_Uom</td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_Volume</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Service_Filter</b></td>
<td class="org-left">Varchar2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Call_Tax_Indicator</td>
<td class="org-left">Varchar2 (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Originating_Cell_Id</td>
<td class="org-left">Varchar2 (16 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Number_Of_Recipients</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Cross_Toll_Period_Ind</td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Charge_Type</td>
<td class="org-left">Varchar2 (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_File_Number</td>
<td class="org-left">Varchar2 (24 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Air_Tax</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Surcharge_Indicator</td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Special_Features_Used</td>
<td class="org-left">Varchar2 (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Original_Toll_Charge</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Called_Number</b></td>
<td class="org-left">Varchar2 (256 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Originating_Category</td>
<td class="org-left">Varchar2 (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Volume_Type</td>
<td class="org-left">Varchar2 (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Toll_Type_Indicator</td>
<td class="org-left">Varchar2 (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Original_Add_Chrg_Amt</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Termination_Reason</td>
<td class="org-left">Varchar2 (8 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Toll_Chrg_Amt_Inc_Alwnce</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Air_Rerate_Ind</td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Network_Flag</td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Called_Place</b></td>
<td class="org-left">Varchar2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Surcharge_Type</td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Special_Number_Type</td>
<td class="org-left">Varchar2 (32 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Period_Name</td>
<td class="org-left">Varchar2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Correlation_Id</td>
<td class="org-left">Varchar2 (14 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Additional_Rate_Offer_Id</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Cross_Period_Ind</td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Price_Plan_Offer_Id</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Toll_Rerate_Ind</td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Serving_Place</td>
<td class="org-left">Varchar2 (26 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Original_Tax</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Toll_Offer_Instance</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Terminating_Cell_Id</td>
<td class="org-left">Varchar2 (16 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Visitor_Indicator</td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Band_Code</b></td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Validity_Time</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Toll_Offer_Id</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Rounded_Toll_Duration</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Carrier_Id</b></td>
<td class="org-left">Varchar2 (16 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Special_Number</td>
<td class="org-left">Varchar2 (32 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Toll_Charge_Amount</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Toll_Duration</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Air_Time_Ind</td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Event_Type_Name</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Record_Sequence_Number</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Serve_Sid</b></td>
<td class="org-left">Varchar2 (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Downlink_Volume</b></td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Calling_Number</b></td>
<td class="org-left">Varchar2 (256 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Call_Completion_Code</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Uplink_Volume</b></td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Dialed_Digits</b></td>
<td class="org-left">Varchar2 (32 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Toll_Rate_Class</td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Eha_Indicator</td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Ring_Time</b></td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Toll_Tax</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Currency_Type</td>
<td class="org-left">Varchar2 (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Calling_State</td>
<td class="org-left">Varchar2 (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Toll_Item_Id</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Customer_Sub_Type</td>
<td class="org-left">Varchar2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Application_Id</b></td>
<td class="org-left">Varchar2 (64 Byte)</td>
<td class="org-left">Used For Brew</td>
</tr>

<tr>
<td class="org-left">L9_Orig_Trans_Id</td>
<td class="org-left">Varchar2 (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Call_Answered_Indicator</b></td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Destination_Category</td>
<td class="org-left">Varchar2 (6 Byte)</td>
<td class="org-left">INTNL = International</td>
</tr>

<tr>
<td class="org-left">L9_Surcharge_Amount</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Destination_State_Code</td>
<td class="org-left">Varchar2 (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Redirect_Number</td>
<td class="org-left">Varchar2 (32 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Toll_Charge_Code</td>
<td class="org-left">Varchar2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Customer_Type</td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Home_Sid</b></td>
<td class="org-left">Varchar2 (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Starting_Call_Toll_Period</td>
<td class="org-left">Varchar2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Called_Country</td>
<td class="org-left">Varchar2 (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Air_Elapsed_Time</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Originating_Address</b></td>
<td class="org-left">Varchar2 (26 Byte)</td>
<td class="org-left">Orig Address From Uff</td>
</tr>

<tr>
<td class="org-left">L9_Additional_Charge_Tax</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Destination_City_Name</td>
<td class="org-left">Varchar2 (30 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Media_Type</td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Toll_Period_Name</td>
<td class="org-left">Varchar2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Call_Type</b></td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">1 = International</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">L= Local (Sms Only)</td>
</tr>

<tr>
<td class="org-left">L9_Rerate_Indicator</td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Nt_Roaming_Ind</td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Offer_Instance</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Daily_Surcharge_Ind</td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Incollect_Indicator</b></td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">If True Then Its</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">An Incollect.</td>
</tr>

<tr>
<td class="org-left">L9_Session_Identifier</td>
<td class="org-left">Varchar2 (128 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Free_Unit</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Ext_Trx_Id</td>
<td class="org-left">Varchar2 (18 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Roaming_Ind</b></td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">Used For Data</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">2 = Roaming</td>
</tr>

<tr>
<td class="org-left">L9_Balance_Exp_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Orig_Additional_Chg_Tax</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Method</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Recharge_Id</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Announcement_Param</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Reason</td>
<td class="org-left">Varchar2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Activity_Amount</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Channel</td>
<td class="org-left">Varchar2 (100 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Blocked_Number_Ind</td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Remaining_Balance_Amt</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Min</b></td>
<td class="org-left">Varchar2 (10 Byte)</td>
<td class="org-left">Msid</td>
</tr>

<tr>
<td class="org-left"><b>L9_Equipment_Id</b></td>
<td class="org-left">Varchar2 (32 Byte)</td>
<td class="org-left">Postpaid = Esn</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Prepaid = 0</td>
</tr>

<tr>
<td class="org-left">L9_Threshold_Amount</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Service_Feature</b></td>
<td class="org-left">Varchar2 (128 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Original_Air_Time_Chg_Amt</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Be</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Charg_Beyond_Cap</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Is_Online</b></td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">Y = <b>Pre-Pay</b></td>
</tr>

<tr>
<td class="org-left">L9_Volume_Per_Type</td>
<td class="org-left">Varchar2 (512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Units_Beyond_Cap</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Volume_Complex</td>
<td class="org-left">Varchar2 (512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_M2m_Ind</b></td>
<td class="org-left">Varchar2 (2 Byte)</td>
<td class="org-left">Mobile To Mobile</td>
</tr>

<tr>
<td class="org-left">L9_Balance_Amount</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Calling_Area_Name</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Toll_Free_Ind</b></td>
<td class="org-left">Varchar2 (1 Byte)</td>
<td class="org-left">Y = Toll Free</td>
</tr>

<tr>
<td class="org-left"><b>L9_Partner_Id</b></td>
<td class="org-left">Varchar2 (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Ext_Ref_Id</td>
<td class="org-left">Varchar2 (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Campaign_Id</td>
<td class="org-left">Varchar2 (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Application_Type</td>
<td class="org-left">Varchar2 (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Application_Description</td>
<td class="org-left">Varchar2 (193 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Charge_Code_Description</td>
<td class="org-left">Varchar2 (193 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_System_Service</td>
<td class="org-left">Varchar2 (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Initiator_Id</td>
<td class="org-left">Varchar2 (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Adj_Reason_Cd</td>
<td class="org-left">Varchar2 (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Initiator_Type</td>
<td class="org-left">Varchar2 (19 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-4-5" CREATED="1553536041455" MODIFIED="1553536041455" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>APE1_ACCUMULATORS
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
The accumulation tables this is what is presented on the bill.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left"><b>Cycle_Code</b></td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Cycle_Instance</b></td>
<td class="org-left">Number(2,0)</td>
<td class="org-left"><i>Cycle Instance = 0</i></td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left"><i>Pre-Paid Subscriber</i></td>
</tr>

<tr>
<td class="org-left">Customer_Segment</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Customer_Id</b></td>
<td class="org-left">Number(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Accum_Type_Id</b></td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Owner_Id</b></td>
<td class="org-left">Number(10,0)</td>
<td class="org-left"><i>Same as Subsciber_id</i></td>
</tr>

<tr>
<td class="org-left">Owner_Type</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Item_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Offer_Instance</td>
<td class="org-left">Number(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dimension_Id</td>
<td class="org-left">Number(5,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Cycle_Year</b></td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char(6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Update_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Version_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Global_Accum_Ind</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Cross_Cycle_Ind</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Accum_Id</b></td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rerate_Type</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Account</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Accum_Charge</b></td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Accum_Chg_Incl_Free_Allw</b></td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Accum_Free_Unit</b></td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Accum_Unit</b></td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Billing_Arrangement</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Currency_Code</b></td>
<td class="org-left">Varchar2(3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">First_Event_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_Balance_Amount</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_Balance_Status</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Last_Event_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Number_Of_Events</b></td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Number_Of_Free_Events</b></td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Number_Of_Rolled_Cycles</b></td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Offer_Id</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Pi_Role</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Pi_Status</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Quota</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Quota_Per_Period</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Remaining_Quota_Per_Period</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Remain_Quota_Per_Month_Period</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rolled_Previous_Cyc_Per_Period</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rolled_Quota_From_Previous_Cyc</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Uom</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Utilized_Quota_Per_Period</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Utilize_Quota_Per_Month_Period</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Billing_Resource_Type</td>
<td class="org-left">Varchar2(16 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Billing_Resource_Id</td>
<td class="org-left">Varchar2(63 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Toll_Tax</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Accum_Chg_Incl_Allw_Cmplx</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Accum_Credit</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Accumulated_Chg_Cmplx</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Overage_Cap</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Accum_Free_Unit_Cmplx</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Number_Of_Events_Cmplx</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Number_Free_Events_Cmplx</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Accum_Unit_Cmplx</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Cap_Exceed</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Number_Of_Credit_Events</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Air_Tax</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Tot_Units_Above_Cap</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Accum_Duration</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Call_Direction</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Roaming_Ind</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Tax_Change_Date</td>
<td class="org-left">Varchar2(25 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Serve_Sid</td>
<td class="org-left">Varchar2(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Eha_Indicator</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Pay_Channel</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Customer_Sub_Type</td>
<td class="org-left">Varchar2(15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Be</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Customer_Type</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Called_Country</td>
<td class="org-left">Varchar2(3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Payment_Category</b></td>
<td class="org-left">Varchar2(4 Byte)</td>
<td class="org-left"><i>Post Or Pre</i></td>
</tr>

<tr>
<td class="org-left">L9_Billing_Arrangement</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Volume_Accumulation</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Offer_Level</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Full_Cap</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Charge_Type</td>
<td class="org-left">Varchar2(3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Prev_Add_Chg_Cmplx2</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Prev_Add_Chg_Cmplx1</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Prev_Add_Chg_Cmplx3</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Prev_Add_Chg_Cmplx</td>
<td class="org-left">Varchar2(4000 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Acc_Usage_Before_Eom</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Acc_Usage_After_Eom</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Msisdn</td>
<td class="org-left">Varchar2(256 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Cap_To_Be_Used</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Charge_Code</td>
<td class="org-left">Varchar2(15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Offer_Type</td>
<td class="org-left">Varchar2(255 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Accum_Chg_Beyo_Cap_Cmplx</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_Ctn</b></td>
<td class="org-left">Varchar2(10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Media_Type</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Utilized_Quota_Cmplx</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_First_Threshold_Sent_Ind</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Remain_Quota_Cmplx</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Used_Quota</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Last_Threshold_Sent</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Charge_Rev_Code</td>
<td class="org-left">Varchar2(2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Is_New_Scale</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Is_First_Notif</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Notified_Ctn</td>
<td class="org-left">Varchar2(32 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Unlimited_Ind</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Proration_Factor</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Curr_Leg</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Num_Of_Period</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Is_Notif_Sent</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Period_Name</td>
<td class="org-left">Varchar2(255 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Volume_Per_Leg</td>
<td class="org-left">Varchar2(4000 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Cycle_Start_Date_Cmplx</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Disable_Notif_Ind</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Notif_Elig</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Is_Second_Notif</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Limit_Quota_Change_Cmplx</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Agr_Level_Offer_Inst</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Last_Notif_Index</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Second_Notif_Thresh</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Offer_Exp_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Second_Threshold</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Accum_Free_Unts_Beyo_Cap</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Offer_Eff_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_First_Threshold</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Second_Threshold_Sent_Ind</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Limit_Quota_Cmplx</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_First_Notif_Thresh</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Remaining_Bucket</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Class_Code</td>
<td class="org-left">Varchar2(12 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Ivr_Ann_Code</td>
<td class="org-left">Varchar2(50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Accum_Add_Tax_Amt</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Accum_Tax_Amt</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Days_Of_Daily_Data</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Calling_Area_Name</td>
<td class="org-left">Varchar2(50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Expiration_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Disclaimer_Sent</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Is_Roam_Data_Speed_Notif</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Geocode</td>
<td class="org-left">Varchar2(10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Is_Total_Data_Speed_Notif</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Roam_Volume_Accumulation</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Roam_Speed_Limit</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Indicator</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Charge_Accumulation</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Pp_Changed_Ind</td>
<td class="org-left">Varchar2(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_First_Level</td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Grp_Level_Offer_Inst</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_Group_Offer_Id</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-4-6" CREATED="1553536041456" MODIFIED="1553536041456" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AGD1_RESOURCES
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Resource_Segment</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Resource_Value</td>
<td class="org-left">Varchar2(63 Byte)</td>
<td class="org-left">Contains</td>
</tr>

<tr>
<td class="org-left"><b>Resource_Type</b></td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">0 - Mdn</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">19 - Min</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">21 - Outcollects</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">23 - Timsi</td>
</tr>

<tr>
<td class="org-left"><b>Effective_Date</b></td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char(6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Update_Id</td>
<td class="org-left">Number(18,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Expiration_Date</b></td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Subscriber_Id</b></td>
<td class="org-left">Number(10,0)</td>
<td class="org-left">The Subscriber</td>
</tr>

<tr>
<td class="org-left">Sub_Status</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Routing_Policy_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Payment_Category</td>
<td class="org-left">Char(4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Customer_Id</b></td>
<td class="org-left">Number(10,0)</td>
<td class="org-left">Customer ID</td>
</tr>

<tr>
<td class="org-left"><b>Bill_Cycle</b></td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">New_Bill_Cycle</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Chg_Cyc_Req_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Large_Cust_Ind</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Resource_Hash_Value</td>
<td class="org-left">Number(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Subscriber_Hash_Value</td>
<td class="org-left">Number(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Load_Ind</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
<ul class="org-ul">
<li>Subscriber Table Status
<ul class="org-ul">
<li>A = Active</li>
<li>C = Canceled</li>
<li>S = Suspended</li>
<li>U = Collection Suspend</li>
<li>L = Collection Canceled</li>
<li>D = Collection Suspend</li>
</ul></li>
</ul>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-4-7" CREATED="1553536041457" MODIFIED="1553536041457" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AC_PHYSICAL_FILES
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Provides information for the physical files that were processed.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left"><b>Identifier</b></td>
<td class="org-left">Number(15,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Sys_Creation_Date</b></td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char(6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>File_Name</b></td>
<td class="org-left">Varchar2(200 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Host_Name</td>
<td class="org-left">Varchar2(50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>File_Path</b></td>
<td class="org-left">Varchar2(512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Serial_Number</td>
<td class="org-left">Varchar2(8 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System_Rcv_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Fsrc_Src_Type</td>
<td class="org-left">Char(10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Fsrc_Type_Id</td>
<td class="org-left">Char(10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rcrdng_Start_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rcrdng_End_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Trlr_Record_Count</b></td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Trlr_Block_Count</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Trlr_L_File_Count</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Pgm_L_File_Count</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Pgm_Tracer_Ind</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dupl_Entry_Ind</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Entry_Status</td>
<td class="org-left">Char(2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Old_Age_Ind</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">End_Of_Tree_Seq</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Balance_Date</b></td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-4-8" CREATED="1553536041457" MODIFIED="1553536041457" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AC_SOURCE
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Source_Type</td>
<td class="org-left">Char(10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>File_Type</b></td>
<td class="org-left">Char(10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Switch_Id</td>
<td class="org-left">Varchar2(32 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char(6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Seq_No</td>
<td class="org-left">Number(6,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Max_File_Seq_No</td>
<td class="org-left">Number(6,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Max_Time</td>
<td class="org-left">Number(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Min_Time</td>
<td class="org-left">Number(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Last_Cycle_Procd</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Next_Cycle_Expect</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Status_Ind</td>
<td class="org-left">Char(2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dupl_Entry_Ind</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ho_From_Time</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ho_From_Seq</td>
<td class="org-left">Number(6,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Days_Bfr_Phy_Cln</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Gap_Permitted</td>
<td class="org-left">Number(6,0)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-4-9" CREATED="1553536041457" MODIFIED="1553536041457" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>APE1_SUBSCRIBER_RERATE
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Customers in this table are scheduled to be re-rated. Then they
should be removed once re-rating is complete.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left"><b>Cycle_Code</b></td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Cycle_Instance</td>
<td class="org-left">Number (2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Customer_Segment</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Customer_Id</b></td>
<td class="org-left">Number (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Subscriber_Id</b></td>
<td class="org-left">Number (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Cycle_Year</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rerate_Source</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Mark_Type</td>
<td class="org-left">Number (1)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Status</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Activity_Source</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Num_Of_Rerate_Tries</td>
<td class="org-left">Number (2)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>

<p>
Once re-rating starts you can check the progress with the
following query:
</p>

<pre class="example">
select * from ape1_rerate_population 
 where cycle_code=2 and cycle_instance=5 
  and cycle_year=2014 and activity_source='R3'
</pre>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-4-10" CREATED="1553536041458" MODIFIED="1553536041458" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>MF1_CIBER_BATCH_SEQ
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
The table used to keep the CIBER Outcollect sequences in sync
with Syniverse. Every once a while we need to update it to keep
in sync.
</p>

<p>
<a href="file:///home/dbalchen/workspace/Outcollects/updateSeq.pl">Sequence Creation Job</a>
</p>

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Home_Sid</b></td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Locked_Sid</td>
<td class="org-left">Number (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Seq_No</td>
<td class="org-left">Number (3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Serve_Sid</b></td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Status_Ind</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-4-11" CREATED="1553536041458" MODIFIED="1553536041458" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>EM1_RECORD
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
The EM1 record database is the database used by <b>AEM</b>, To see the columns within the EM1_RECORD look at the <b>EM1_STREAM_STREAM_MAP@PTE2AEM</b> table.
Click on the link provided below to see an example on how to query this table.
     <a href="file:///home/dbalchen/workspace/CommonPlace/docs/em1_example.sql">EM1_RECORD Example</a>
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-4-12" CREATED="1553536041459" MODIFIED="1553536041459" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PRM_ROM_OUTCOL_EVENTS_AP
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Edr_Id</td>
<td class="org-left">Number (11)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Generated_Rec</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_Start_Datetime</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Bp_Start_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Bp_End_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Carrier_Cd</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Process_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tap_File_Seq</td>
<td class="org-left">Number (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Air_Toll_Ind</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rating_Curr</td>
<td class="org-left">Char (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tap_Trx_Curr</td>
<td class="org-left">Char (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Identifier</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Globalrefnumber</td>
<td class="org-left">Varchar2 (42 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charging_Param</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Uom</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ext_File_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Extract_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Processed_Ind</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge_Units</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Set_Cd</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Jurisdiction</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Code_1</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Tp_1</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Rate_1</td>
<td class="org-left">Number (6,3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Amount_1</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Code_2</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Tp_2</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Rate_2</td>
<td class="org-left">Number (6,3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Amount_2</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Code_3</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Tp_3</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Rate_3</td>
<td class="org-left">Number (6,3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Amount_3</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Code_4</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Tp_4</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Rate_4</td>
<td class="org-left">Number (6,3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Amount_4</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Net_Charge_Lc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Tax_Amount_Lc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Gross_Amt_Lc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Net_Charge_Sdr</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Tax_Amount_Sdr</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Gross_Amt_Sdr</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Cross_Rate</td>
<td class="org-left">Number (11,6)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Service_Type</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Norm_Src_Number</td>
<td class="org-left">Char (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Norm_Dest_Number</td>
<td class="org-left">Char (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dest_Number</td>
<td class="org-left">Char (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call_Direction</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Country_Code</td>
<td class="org-left">Char (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Orig_Province</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Term_Province</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Home_Province</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_End_Datetime</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Net_Rec_Entity_Id</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Net_Loc_Area_Code</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Geo_Serv_Bid</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Geo_Serv_Loc_Desc</td>
<td class="org-left">Varchar2 (30 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Equipment_Id</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Bearer_Serv_Code</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tele_Serv_Code</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Supp_Service</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call_Tp_Level_1</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call_Tp_Level_2</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call_Tp_Level_3</td>
<td class="org-left">Char (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Camel_Serv_Level</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Camel_Serv_Key</td>
<td class="org-left">Varchar2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Camel_Invoc_Fee</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Camel_Dflt_Hndl</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Camel_Dest_Num</td>
<td class="org-left">Char (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Camel_Cse_Info</td>
<td class="org-left">Char (40 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Home_Bid</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Cell_Id</td>
<td class="org-left">Varchar2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Utc_Offset</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rec_Entity_Tp</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Chrg_Id</td>
<td class="org-left">Varchar2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Src_Number</td>
<td class="org-left">Char (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Pdp_Address</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ggsn_Address</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Gprs_Dest_Apn_Ni</td>
<td class="org-left">Varchar2 (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Gprs_Dest_Apn_Oi</td>
<td class="org-left">Varchar2 (38 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Data_Vol_Incoming</td>
<td class="org-left">Varchar2 (12 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Data_Vol_Outgoing</td>
<td class="org-left">Varchar2 (12 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Termination_Cause</td>
<td class="org-left">Varchar2 (8 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Partial_Type_Ind</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Imsi</td>
<td class="org-left">Varchar2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Msisdn</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Disp_File_Seq</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Net_Sgsnid</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Future</td>
<td class="org-left">Varchar2 (100 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Amount_1_Rc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Amount_2_Rc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Amount_3_Rc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Amount_4_Rc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Net_Charge_Rc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Tax_Amount_Rc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Gross_Amt_Rc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Net_Charge_Lc1</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Tax_Amount_Lc1</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Gross_Amt_Lc1</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Au_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Usg_Net_Charge_Lc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Usg_Net_Charge_Rc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Usg_Net_Charge_Sdr</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Acc_Net_Charge_Lc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Acc_Net_Charge_Rc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Acc_Net_Charge_Sdr</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tap_Out_File_Name</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rap_File_Seq</td>
<td class="org-left">Number (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Taxable_Amount1</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Taxable_Amount2</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Taxable_Amount3</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Taxable_Amount4</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tenant_Cd</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Network_Element_Type</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Network_Element_Id</td>
<td class="org-left">Char (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Chr_Prt_Pub_User_Id</td>
<td class="org-left">Char (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Non_Chr_Prt_Pub_User_Id</td>
<td class="org-left">Char (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_Reference</td>
<td class="org-left">Char (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sim_Toolkit_Ind</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Message_Event_Service</td>
<td class="org-left">Char (17 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ods_Insert_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ods_Last_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-4-13" CREATED="1553536041460" MODIFIED="1553536041460" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PRM_ROM_INCOL_EVENTS_AP
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Edr_Id</td>
<td class="org-left">Number (11)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Generated_Rec</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rerate_Cnt</td>
<td class="org-left">Number (3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Record_Type</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tap_In_File_Name</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tap_In_File_Seq_Number</td>
<td class="org-left">Number (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tadig_File_Type</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Record_Position</td>
<td class="org-left">Varchar2 (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge_Type</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge_Parameter</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Uom</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge_Amount</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge_Amount_Rc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge_Amount_Sdr</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Currency_Code</td>
<td class="org-left">Char (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rap_File_Sequence</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Carrier_Cd</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Service_Type</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Normalized_Calling_Number</td>
<td class="org-left">Char (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Normalized_Called_Number</td>
<td class="org-left">Char (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call_Direction</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Country_Code</td>
<td class="org-left">Char (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Serving_Bid</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_Start_Date_Time</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Process_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Bp_Start_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Bp_End_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Local_Currency</td>
<td class="org-left">Char (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rating_Curr</td>
<td class="org-left">Char (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Exchange_Rate</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call_Type_Level_1</td>
<td class="org-left">Char (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call_Type_Level_2</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call_Type_Level_3</td>
<td class="org-left">Varchar2 (11 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Type</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Future_Buff</td>
<td class="org-left">Varchar2 (443 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Au_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Teleservicecode</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Supp_Serv_Cd</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Validation_Sts</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Aprm_Edr_Id</td>
<td class="org-left">Number (20)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Orig_Brok_Filename</td>
<td class="org-left">Varchar2 (24 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Avail_Ts</td>
<td class="org-left">Char (14 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Avail_Ts_Offst</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Transcut_Ts</td>
<td class="org-left">Char (14 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Transcut_Ts_Offst</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tenant_Cd</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Network_Element_Type</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Network_Element_Id</td>
<td class="org-left">Char (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Chr_Prt_Pub_User_Id</td>
<td class="org-left">Char (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Non_Chr_Prt_Pub_User_Id</td>
<td class="org-left">Char (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_Reference</td>
<td class="org-left">Char (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sim_Toolkit_Ind</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Message_Event_Service</td>
<td class="org-left">Char (17 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Mobile_Session_Service</td>
<td class="org-left">Char (17 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Non_Chrg_Party_Num</td>
<td class="org-left">Char (17 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ods_Insert_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ods_Last_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>



<div class="figure">
<p><img src="Pictures/shahn.jpg" alt="shahn.jpg" />
</p>
</div>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-8" CREATED="1553536041490" MODIFIED="1553536041490" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>ARCM Tables
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<node ID="sec-7-8-1" CREATED="1553536041491" MODIFIED="1553536041491" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>SMM1_COLLECT_FILES_HIST
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Ods_Source_Cd</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Period_Key</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Identifier</td>
<td class="org-left">Number (22)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>File_Name</b></td>
<td class="org-left">Varchar2 (200 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Format</td>
<td class="org-left">Varchar2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Source_Id</td>
<td class="org-left">Number (22)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Source_Type</td>
<td class="org-left">Varchar2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Path</td>
<td class="org-left">Varchar2 (512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Status</td>
<td class="org-left">Varchar2 (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Physical_Date</b></td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Size</td>
<td class="org-left">Number (15)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Is_Instance_Id</td>
<td class="org-left">Number (11)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Reject_Reason</td>
<td class="org-left">Varchar2 (512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ods_Insert_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ods_Last_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-8-2" CREATED="1553536041491" MODIFIED="1553536041491" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>SMM1_ARCM_FILE_REPOSITORY
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Ods_Source_Cd</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Name</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Dir</td>
<td class="org-left">Varchar2 (100 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Status</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Type</td>
<td class="org-left">Varchar2 (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sender</td>
<td class="org-left">Varchar2 (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Recipient</td>
<td class="org-left">Varchar2 (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sequence_Num</td>
<td class="org-left">Number (11)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Last_Modified_Timestamp</td>
<td class="org-left">Number (22)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Available_Timestamp</td>
<td class="org-left">Number (22)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Content</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Corresponding_File_Name</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Clearing_House</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Events_Count</td>
<td class="org-left">Number (11)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Total_Value</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Currency</td>
<td class="org-left">Varchar2 (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Ack_Status</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Module_Id</td>
<td class="org-left">Number (11)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ods_Insert_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ods_Last_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-8-3" CREATED="1553536041496" MODIFIED="1553536041496" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PRM_RAPOUT_ERR_MNGR
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Keeps track of all the RAP out errors.
</p>
</body>
</html>
</richcontent>
</node>
</node>
<node ID="sec-7-9" CREATED="1553536041496" MODIFIED="1553536041496" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>APRM Tables
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<node ID="sec-7-9-1" CREATED="1553536041496" MODIFIED="1553536041496" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>CDMA USC_ROAM_EVNTS
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Used for CDMA Incollect/Outcollect Voice and data files.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Air_Chrg_Amt</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Au_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Bp_Start_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Carrier_Cd</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ciber_File_Name_1</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ciber_File_Name_2</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Edr_Id</td>
<td class="org-left">Number (11)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_Type</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Report_Period</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Generated_Rec</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Geo_Code</td>
<td class="org-left">Varchar2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Home_Company</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Home_Sid</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ntwrk_Roam_Ind</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Orig_Bp</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Originating_Id</td>
<td class="org-left">Char (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Other_Company</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Prod_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Serve_Company</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Serve_Sid</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Subscriber_Id</td>
<td class="org-left">Char (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Surcharge_Amount</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Surcharge_Ind</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Terminating_Id</td>
<td class="org-left">Char (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Toll_Chrg</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Toll_Duration</td>
<td class="org-left">Number (11)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Toll_Tp_Ind</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Total_Chrg_Amount</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Total_Tax</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Usage</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Usc_Uom</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Visit_Ind</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Volume_Type</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-9-2" CREATED="1553536041496" MODIFIED="1553536041496" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>(Both) USC_SAP_EXTRACT_V
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
The SAP Extract table is a view of a view <b>IC_ACCUMULATED_USAGE</b> joined with table <b>USC_GL_ACC_LKP</b>. It is this table that is used create a report that is sent to <b>TDS</b> to be loaded into <b>SAP</b>
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Descritption</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Au_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Carrier_Cd</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Other_Partner</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Au_Prod_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Au_Evt_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Au_Prod_Cat_Id</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">IR - Intra Roaming</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">IN - Incollect Roaming</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">RO - Outcollect Roaming</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">IS - TAPIN</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">OS - TAPOUT</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">II - GSM</td>
</tr>

<tr>
<td class="org-left">Au_Bp_Start_Date</td>
<td class="org-left">Date</td>
<td class="org-left">Billing Period Start</td>
</tr>

<tr>
<td class="org-left">Au_Charge</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Gl_Account</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Crdr_Ind</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Cost_Center</td>
<td class="org-left">Char (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Product</td>
<td class="org-left">Char (18 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Code</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Jur_Cd</td>
<td class="org-left">Char (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Line_Order</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-9-3" CREATED="1553536041497" MODIFIED="1553536041497" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>4G IC_ACCUMULATED_USAGE
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
One of the tables that is part of <b>USC_SAP_EXTRACT_V</b> useful for usage totals and file names. This is a view of the <b>PRM_EVENT_DTL_PARAM</b> and <b>IC_ACCUMULATED_CHRG</b> tables.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Carrier_Cd</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Prod_Bdl_Id</td>
<td class="org-left">Number (6)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Prod_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Content_Grp_Cd</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Service_Id</td>
<td class="org-left">Number (20)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Elmnt_Cd</td>
<td class="org-left">Char (8 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rate_Plan_Cd</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Chrg_Direction</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Orig_Bp</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Bp_Start_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rate_Eff_Datetime</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Destination_Cd</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Chrg_Param_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_1_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_1_Set_Cd</td>
<td class="org-left">Char (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_1_Val</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_2_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_2_Set_Cd</td>
<td class="org-left">Char (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_2_Val</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_3_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_3_Set_Cd</td>
<td class="org-left">Char (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_3_Val</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_4_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_4_Set_Cd</td>
<td class="org-left">Char (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_4_Val</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Nr_Param_1_Val</td>
<td class="org-left">Char (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Nr_Param_2_Val</td>
<td class="org-left">Char (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Nr_Param_3_Val</td>
<td class="org-left">Char (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Future_1</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Future_2</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Future_3</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Future_4</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Future_5</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Future_6</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Future_7</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Future_8</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Future_9</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Future_10</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Future_11</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Future_12</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Future_13</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Future_14</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Future_15</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Au_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Jurisdiction</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Prod_Cat_Id</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left"><i>Same as Au_Prod_Cat_Id</i></td>
</tr>

<tr>
<td class="org-left">Agreement_Id</td>
<td class="org-left">Number (6)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Elmnt_Cat_Id</td>
<td class="org-left">Number (2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rate_Class_Set_Cd</td>
<td class="org-left">Char (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rate_Per_Unit_Seq</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">One_Time_Rate_Seq</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Nr_Param_4_Val</td>
<td class="org-left">Char (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_5_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_5_Set_Cd</td>
<td class="org-left">Char (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_5_Val</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_6_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_6_Set_Cd</td>
<td class="org-left">Char (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_6_Val</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_7_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_7_Set_Cd</td>
<td class="org-left">Char (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_7_Val</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_8_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_8_Set_Cd</td>
<td class="org-left">Char (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_8_Val</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_9_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_9_Set_Cd</td>
<td class="org-left">Char (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_9_Val</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_10_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_10_Set_Cd</td>
<td class="org-left">Char (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Qual_Param_10_Val</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Nr_Param_1_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Nr_Param_2_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Nr_Param_3_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Nr_Param_4_Id</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Set_Cd</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Uom</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Num_Of_Events</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_Chrg_Tp</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Org_Chrg_Prm_V</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Chrg_Param_Val</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Net_Acces_Chrg</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Net_Onetm_Chrg</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Net_Usage_Chrg</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Acces_Chrg_Seq</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Content_Rate</td>
<td class="org-left">Number (13,8)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Cp_Access_Chrg</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Cp_Usage_Chrg</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tenant_Cd</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Core_Reserved_1</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Core_Reserved_2</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Core_Reserved_3</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_Direction</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-9-4" CREATED="1553536041497" MODIFIED="1553536041497" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>4G PRM_ROM_INCOL_EVENTS_AP
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Validation_Sts</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Uom</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Transcut_Ts_Offst</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Transcut_Ts</td>
<td class="org-left">Char (14 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tenant_Cd</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Teleservicecode</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Type</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tap_In_File_Seq_Number</td>
<td class="org-left">Number (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tap_In_File_Name</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tadig_File_Type</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Supp_Serv_Cd</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sim_Toolkit_Ind</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Serving_Bid</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Service_Type</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rerate_Cnt</td>
<td class="org-left">Number (3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Record_Type</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Record_Position</td>
<td class="org-left">Varchar2 (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rating_Curr</td>
<td class="org-left">Char (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rap_File_Sequence</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Process_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Orig_Brok_Filename</td>
<td class="org-left">Varchar2 (24 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ods_Last_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ods_Insert_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Normalized_Calling_Number</td>
<td class="org-left">Char (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Normalized_Called_Number</td>
<td class="org-left">Char (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Non_Chrg_Party_Num</td>
<td class="org-left">Char (17 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Non_Chr_Prt_Pub_User_Id</td>
<td class="org-left">Char (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Network_Element_Type</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Network_Element_Id</td>
<td class="org-left">Char (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Mobile_Session_Service</td>
<td class="org-left">Char (17 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Message_Event_Service</td>
<td class="org-left">Char (17 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Local_Currency</td>
<td class="org-left">Char (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Generated_Rec</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Future_Buff</td>
<td class="org-left">Varchar2 (443 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Avail_Ts_Offst</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Avail_Ts</td>
<td class="org-left">Char (14 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Exchange_Rate</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_Start_Date_Time</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_Reference</td>
<td class="org-left">Char (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Edr_Id</td>
<td class="org-left">Number (11)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Currency_Code</td>
<td class="org-left">Char (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Country_Code</td>
<td class="org-left">Char (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Chr_Prt_Pub_User_Id</td>
<td class="org-left">Char (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge_Type</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge_Parameter</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge_Amount_Sdr</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge_Amount_Rc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge_Amount</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Carrier_Cd</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call_Type_Level_3</td>
<td class="org-left">Varchar2 (11 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call_Type_Level_2</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call_Type_Level_1</td>
<td class="org-left">Char (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call_Direction</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Bp_Start_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Bp_End_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Au_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Aprm_Edr_Id</td>
<td class="org-left">Number (20)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-9-5" CREATED="1553536041498" MODIFIED="1553536041498" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>4G PRM_ROM_OUTCOL_EVENTS_AP
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Utc_Offset</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Usg_Net_Charge_Sdr</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Usg_Net_Charge_Rc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Usg_Net_Charge_Lc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Uom</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Tax_Amount_Sdr</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Tax_Amount_Rc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Tax_Amount_Lc1</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Tax_Amount_Lc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Net_Charge_Sdr</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Net_Charge_Rc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Net_Charge_Lc1</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Net_Charge_Lc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Gross_Amt_Sdr</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Gross_Amt_Rc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Gross_Amt_Lc1</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tot_Gross_Amt_Lc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Termination_Cause</td>
<td class="org-left">Varchar2 (8 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Term_Province</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tenant_Cd</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tele_Serv_Code</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Taxable_Amount4</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Taxable_Amount3</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Taxable_Amount2</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Taxable_Amount1</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Tp_4</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Tp_3</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Tp_2</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Tp_1</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Set_Cd</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Rate_4</td>
<td class="org-left">Number (6,3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Rate_3</td>
<td class="org-left">Number (6,3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Rate_2</td>
<td class="org-left">Number (6,3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Rate_1</td>
<td class="org-left">Number (6,3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Jurisdiction</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Code_4</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Code_3</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Code_2</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Code_1</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Amount_4_Rc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Amount_4</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Amount_3_Rc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Amount_3</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Amount_2_Rc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Amount_2</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Amount_1_Rc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tax_Amount_1</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tap_Trx_Curr</td>
<td class="org-left">Char (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tap_Out_File_Name</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tap_File_Seq</td>
<td class="org-left">Number (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Supp_Service</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Src_Number</td>
<td class="org-left">Char (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sim_Toolkit_Ind</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Service_Type</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rec_Entity_Tp</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rating_Curr</td>
<td class="org-left">Char (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rap_File_Seq</td>
<td class="org-left">Number (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Processed_Ind</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Process_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Pdp_Address</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Partial_Type_Ind</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Orig_Province</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ods_Last_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ods_Insert_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Norm_Src_Number</td>
<td class="org-left">Char (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Norm_Dest_Number</td>
<td class="org-left">Char (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Non_Chr_Prt_Pub_User_Id</td>
<td class="org-left">Char (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Network_Element_Type</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Network_Element_Id</td>
<td class="org-left">Char (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Net_Sgsnid</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Net_Rec_Entity_Id</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Net_Loc_Area_Code</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Msisdn</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Message_Event_Service</td>
<td class="org-left">Char (17 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Imsi</td>
<td class="org-left">Varchar2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Home_Province</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Home_Bid</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Gprs_Dest_Apn_Oi</td>
<td class="org-left">Varchar2 (38 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Gprs_Dest_Apn_Ni</td>
<td class="org-left">Varchar2 (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Globalrefnumber</td>
<td class="org-left">Varchar2 (42 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ggsn_Address</td>
<td class="org-left">Varchar2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Geo_Serv_Loc_Desc</td>
<td class="org-left">Varchar2 (30 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Geo_Serv_Bid</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Generated_Rec</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Future</td>
<td class="org-left">Varchar2 (100 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Identifier</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Extract_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Ext_File_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_Start_Datetime</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_Reference</td>
<td class="org-left">Char (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Event_End_Datetime</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Equipment_Id</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Edr_Id</td>
<td class="org-left">Number (11)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Disp_File_Seq</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dest_Number</td>
<td class="org-left">Char (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Data_Vol_Outgoing</td>
<td class="org-left">Varchar2 (12 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Data_Vol_Incoming</td>
<td class="org-left">Varchar2 (12 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Cross_Rate</td>
<td class="org-left">Number (11,6)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Country_Code</td>
<td class="org-left">Char (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Chrg_Id</td>
<td class="org-left">Varchar2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Chr_Prt_Pub_User_Id</td>
<td class="org-left">Char (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charging_Param</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge_Units</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Cell_Id</td>
<td class="org-left">Varchar2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Carrier_Cd</td>
<td class="org-left">Varchar2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Camel_Serv_Level</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Camel_Serv_Key</td>
<td class="org-left">Varchar2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Camel_Invoc_Fee</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Camel_Dflt_Hndl</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Camel_Dest_Num</td>
<td class="org-left">Char (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Camel_Cse_Info</td>
<td class="org-left">Char (40 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call_Tp_Level_3</td>
<td class="org-left">Char (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call_Tp_Level_2</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call_Tp_Level_1</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call_Direction</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Bp_Start_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Bp_End_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Bearer_Serv_Code</td>
<td class="org-left">Char (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Au_Id</td>
<td class="org-left">Number (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Air_Toll_Ind</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Acc_Net_Charge_Sdr</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Acc_Net_Charge_Rc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Acc_Net_Charge_Lc</td>
<td class="org-left">Number (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
</node>
<node ID="sec-7-10" CREATED="1553536041499" MODIFIED="1553536655354" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>CDMA Data Outcollects
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<node ID="sec-7-10-1" CREATED="1553536041499" MODIFIED="1553536041499" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>DATA_OUTCOLLECT
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Event table used for CDMA data Outcollects.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Actual_Data_Volume</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Actual_Usage_Volume</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Amount</td>
<td class="org-left">Number (9,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Bsid</td>
<td class="org-left">Char (12 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Home_Carrier</td>
<td class="org-left">Varchar2 (40 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Home_Sid</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Message_Accounting_Digits</td>
<td class="org-left">Number</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Partner</td>
<td class="org-left">Varchar2 (40 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Process_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Settlement_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-10-2" CREATED="1553536041500" MODIFIED="1553536041500" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>ROAMING_PARTNER
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
A table that contains all the CDMA Data Outcollect roaming partners.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Bsid_Type</td>
<td class="org-left">Char (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Clearinghouse</td>
<td class="org-left">Varchar2 (40 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Partner</td>
<td class="org-left">Varchar2 (40 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Roaming_Type</td>
<td class="org-left">Char (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
</node>
<node ID="sec-7-13" CREATED="1553536041504" MODIFIED="1553536041504" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Roaming Reconciliation Tables
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<node ID="sec-7-13-1" CREATED="1553536041504" MODIFIED="1553536041504" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>FILE_SUMMARY
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Used to hold data for all the roaming files.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">File_Name</td>
<td class="org-left">Not Null Varchar2(255)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Identifier</td>
<td class="org-left">Not Null Number(38)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Type</td>
<td class="org-left">Varchar2(255)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Usage_Type</td>
<td class="org-left">Varchar2(255)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sender</td>
<td class="org-left">Varchar2(255)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Receiver</td>
<td class="org-left">Varchar2(255)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Total_Records_Dch</td>
<td class="org-left">Number(38)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Total_Volume_Dch</td>
<td class="org-left">Number(38)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Total_Charges_Dch</td>
<td class="org-left">Number(38,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Total_Records</td>
<td class="org-left">Number(38)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Total_Volume</td>
<td class="org-left">Number(38)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Total_Charges</td>
<td class="org-left">Number(38,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dropped_Records</td>
<td class="org-left">Number(38)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Duplicates</td>
<td class="org-left">Number(38)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Tc_Send</td>
<td class="org-left">Number(38)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dropped_Tc</td>
<td class="org-left">Number(38)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rejected_Count</td>
<td class="org-left">Number(38)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Rejected_Charges</td>
<td class="org-left">Number(38,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dropped_Aprm</td>
<td class="org-left">Number(10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dropped_Aprm_Charges</td>
<td class="org-left">Number(38,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Aprm_Difference</td>
<td class="org-left">Number(38)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Aprm_Total_Records</td>
<td class="org-left">Number(38)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Aprm_Total_Charges</td>
<td class="org-left">Number(38,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Process_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Name_Dch</td>
<td class="org-left">Varchar2(100)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-13-2" CREATED="1553536041504" MODIFIED="1553536041504" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>APRM
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Carrier_Code</td>
<td class="org-left">Varchar2 (255 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Market_Code</td>
<td class="org-left">Varchar2 (255 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">File_Type</td>
<td class="org-left">Varchar2 (255 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Bp_Start_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Date_Processed</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Clearinghouse</td>
<td class="org-left">Varchar2 (255 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Record_Count</td>
<td class="org-left">Number (38)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Total_Volume</td>
<td class="org-left">Number (38)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Total_Charges</td>
<td class="org-left">Number (38,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Usage_Type</td>
<td class="org-left">Varchar2 (100 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Record_Count_Dch</td>
<td class="org-left">Number (38)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Total_Volume_Dch</td>
<td class="org-left">Number (38)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Total_Charges_Dch</td>
<td class="org-left">Number (38,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Serve_Bid</td>
<td class="org-left">Varchar2 (100 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-13-3" CREATED="1553536041504" MODIFIED="1553536041504" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>REJECTED_RECORDS
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">File_Name</td>
<td class="org-left">Varchar2 (255 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Error_Code</td>
<td class="org-left">Varchar2 (255 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Error_Type</td>
<td class="org-left">Varchar2 (255 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Error_Description</td>
<td class="org-left">Varchar2 (255 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Total_Charge</td>
<td class="org-left">Number (38,2)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
</node>
<node ID="sec-7-6" CREATED="1553536041482" MODIFIED="1553536041482" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>BPT Tables
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
The <b>Business Process Tables</b> are the Tops equivalent to the
reference tables in <b>CARES</b>. The following is the list of all
<b>BPT</b> tables that we are responsible for:
</p>
</body>
</html>
</richcontent>
<node ID="sec-7-6-1" CREATED="1553536041482" MODIFIED="1553536041482" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>ADJ1_OUTCOL_PROVIDER
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
A list of all vendors we have an agreement with for out-collects.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Provider_Id</td>
<td class="org-left">Number(18,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Customer_Id</td>
<td class="org-left">Number(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char(6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Cycle_Code</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Group_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Min_Time_To_Send</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Max_Recs_In_File</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Send_Empty_Notif</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Expiration_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Effective_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Provider_Desc</td>
<td class="org-left">Varchar2(256 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Resource_Type</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-2" CREATED="1553536041482" MODIFIED="1553536041482" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>ADJ9_TIME_ZONE_REF
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Time zone parameters.
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-3" CREATED="1553536041482" MODIFIED="1553536041482" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AGD1_RESOURCES_REF
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Lists <b>TOPS</b> resources used by Turbo charging very important to map <b>SIDS</b> to there offers.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Resource_Segment</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Resource_Value</td>
<td class="org-left">Varchar2(63 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Resource_Type</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Effective_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char(6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Update_Id</td>
<td class="org-left">Number(18,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Expiration_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Subscriber_Id</td>
<td class="org-left">Number(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sub_Status</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Routing_Policy_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Payment_Category</td>
<td class="org-left">Char(4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Customer_Id</td>
<td class="org-left">Number(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Bill_Cycle</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">New_Bill_Cycle</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Chg_Cyc_Req_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Large_Cust_Ind</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Resource_Hash_Value</td>
<td class="org-left">Number(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Subscriber_Hash_Value</td>
<td class="org-left">Number(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-4" CREATED="1553536041484" MODIFIED="1553536041484" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>APE1_SUBSCR_DATA_REF
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
List subscriber reference data. (Customer data)
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Cycle_Code</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Customer_Segment</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Subscriber_Id</td>
<td class="org-left">Number(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char(6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Update_Id</td>
<td class="org-left">Number(18,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Customer_Id</td>
<td class="org-left">Number(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Be</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Currency_Id</td>
<td class="org-left">Char(3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Subscriber_Hash_Value</td>
<td class="org-left">Number(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-5" CREATED="1553536041484" MODIFIED="1553536041484" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>APE1_SUBSCR_OFFERS_REF
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
List subscriber offers. (Customer data)
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Cycle_Code</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Customer_Segment</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Subscriber_Id</td>
<td class="org-left">Number(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Offer_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Offer_Instance</td>
<td class="org-left">Number(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Offer_Eff_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char(6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Update_Id</td>
<td class="org-left">Number(18,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Offer_Exp_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Source_Offer_Agr_Id</td>
<td class="org-left">Number(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Source_Offer_Instance</td>
<td class="org-left">Number(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Eff_Act_Code_Pror</td>
<td class="org-left">Varchar2(25 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Exp_Act_Code_Pror</td>
<td class="org-left">Varchar2(25 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-6" CREATED="1553536041484" MODIFIED="1553536041484" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PRM_REP_CARR_INFO
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Defines the Carrier (TADIG<sup><a id="fnr.7" class="footref" href="#fn.7">7</a></sup>) Code used in IN and OUTCOLLECTS.
The below query shows the company name and carrier code.
</p>

<pre class="example">
SELECT DISTINCT carr_name, carr_cd
  FROM prm_app.PRM_REP_CARR_INFO
ORDER BY carr_name;
</pre>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-7" CREATED="1553536041485" MODIFIED="1553536041485" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>M19_MIN_LR
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Contains the <b>USCC</b> MIN (MSID) block ranges and there <b>SID</b>
code. The Block Ranges are listed in the <b>Technical Data Sheet</b>
from <b>Syniverse</b>. This only contains <b>USCC</b> MINS only. For
foreign carriers see the <b>VISITOR_MIN_LR</b>.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left"><b>Min_Blk</b></td>
<td class="org-left">Number(6,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>From_Line_Range</b></td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>To_Line_Range</b></td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Effective_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char(6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Npa_Type</b></td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">C = Postpaid</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">T = Prepaid</td>
</tr>

<tr>
<td class="org-left"><b>Sids</b></td>
<td class="org-left">Varchar2(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Expiration_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-8" CREATED="1553536041485" MODIFIED="1553536041485" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>VISITOR_MIN_LR
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
This table is created via a program and contains all of our
roaming partners MIN/SID block ranges. It is located on the
<b>BRMPRD</b> database.
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-9" CREATED="1553536041485" MODIFIED="1553536041485" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>MI1_STLMNT_CONTRACT
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
The Settlement Contracts table contains one record for each
contract. A contract is defined as the entity to which a group
of <b>SIDS</b> belongs, whose common attribute is the
clearinghouse-related Net Settlement bank account. This usually
means that all the <b>SIDS</b> that belong to a settlement contract
are part of one operating company.
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-10" CREATED="1553536041485" MODIFIED="1553536041485" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>MF1_OUTCOL_DESTINATION
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
This table includes detailed information on every destination.
A destination represents a target of Out-collect calls (such as
a clearinghouse). The destination of every roamer call is
determined according to the Home <b>SID</b> value of that call.
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-11" CREATED="1553536041486" MODIFIED="1553536041486" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>MF1_OUTCOL_SID_PAIR
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Defines out-collect roaming agreement between <b>SID</b> pair.
Originating category is retrieve from the table that is used
later on for service filter determination. <b>INCOL_SID_PAIR</b>
and <b>SID</b> tables are also used by Acquisition &amp; Formatting.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Serve_Sid</td>
<td class="org-left">Char(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Home_Sid</td>
<td class="org-left">Char(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Effective_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Creation_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sys_Update_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Operator_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Application_Id</td>
<td class="org-left">Char(6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Service_Code</td>
<td class="org-left">Char(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Dl_Update_Stamp</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Expiration_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Outcol_Dest_Cd</td>
<td class="org-left">Char(6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Cre_Daily_Surcg_Ind</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Daily_Surcharge_Amt</td>
<td class="org-left">Number(18,3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Misc_Schg_Ind</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Misc_Schg_Rate</td>
<td class="org-left">Number(18,3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Misc_Schg_Measure_Ind</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Misc_Descriptor</td>
<td class="org-left">Char(2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Misc_Schg_Desc</td>
<td class="org-left">Varchar2(50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Cycle_Code</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Priority</td>
<td class="org-left">Number(5,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Num_Of_Rec_To_Commit</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Partition_Id</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Group_Id</td>
<td class="org-left">Number(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Agreement_Id</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-12" CREATED="1553536041486" MODIFIED="1553536041486" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>MI1_RETURN_RRC
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Used for <b>InCollect</b> <b>CIBER</b> processing. Contains the various
reasons why an <b>InCollect</b> file can be returned.
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-13" CREATED="1553536041486" MODIFIED="1553536041486" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>MI1_REJECT_RRC
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Used for <b>InCollect</b> <b>CIBER</b> processing. Contains the various
reasons why an <b>InCollect</b> file can be rejected.
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-14" CREATED="1553536041486" MODIFIED="1553536041486" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>MI9_NA_CONV
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
This maybe another version of the <b>ADJ9_TIME_ZONE_REF</b>
table, very similar.
</p>
</body>
</html>
</richcontent>
</node>
</node>
<node ID="sec-7-7" CREATED="1553536041487" MODIFIED="1553536041487" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>(BPT) EPC Tables
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
These tables are included in the <b>EPC</b> dump which happens once
or twice a month, no hotfix is needed unless it 
needs to be in
production right away.
</p>
</body>
</html>
</richcontent>
<node ID="sec-7-7-1" CREATED="1553536041487" MODIFIED="1553536041487" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PC9_SID
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
One of the most important reference tables used, contains
all the information for all the <b>SIDS</b> for
all the companies we have a contract with.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Cindex</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Sids</b></td>
<td class="org-left">Varchar2(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Effective_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sid_Desc</td>
<td class="org-left">Varchar2(50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sid_Commercial_Name</td>
<td class="org-left">Varchar2(50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Time_Zone_Code</td>
<td class="org-left">Varchar2(2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Setlmnt_Contract_Cd</td>
<td class="org-left">Varchar2(3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Intracomp_Ind</td>
<td class="org-left">Varchar2(3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sid_State</td>
<td class="org-left">Varchar2(2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sid_Country</td>
<td class="org-left">Varchar2(3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sid_City</td>
<td class="org-left">Varchar2(30 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sid_Location_Cd</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Outcol_Dest_Cd</td>
<td class="org-left">Varchar2(6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Currency_Code</td>
<td class="org-left">Varchar2(2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Band_Code</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Geo_Code</td>
<td class="org-left">Varchar2(9 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Originating_Category</td>
<td class="org-left">Varchar2(6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Expiration_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Incorporate_Ind</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-7-2" CREATED="1553536041488" MODIFIED="1553536041488" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PC9_SID_LIST
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
A description of each <b>SID</b> found in the <b>PC9_SID</b> table.
When the <b>SID</b> table is updated this table needs to be
updated as well.
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-7-3" CREATED="1553536041488" MODIFIED="1553536041488" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PC9_SPECIAL_NUMBER
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Contains a list of all the special numbers, numbers that can
be dropped (no charge), toll or air time free.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Special_Number</td>
<td class="org-left">Varchar2(10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call_Direction</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">1 = Incoming</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">2 = Outgoing</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">5 = Both</td>
</tr>

<tr>
<td class="org-left">Home_Roam_Ind</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">1 = Home</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">2 = Roam</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">3 = Both</td>
</tr>

<tr>
<td class="org-left">Call_Source</td>
<td class="org-left">Varchar2(4 Byte)</td>
<td class="org-left">V = Voice</td>
</tr>

<tr>
<td class="org-left">Effective_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Air_Time_Ind</b></td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">N = Air Time</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Is Free</td>
</tr>

<tr>
<td class="org-left">Toll_Special_Number_Group</td>
<td class="org-left">Varchar2(255 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Drop_Call_Ind</b></td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">Y = This Record</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Will Be Dropped</td>
</tr>

<tr>
<td class="org-left">Special_Number_Type</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Service_Filter</td>
<td class="org-left">Varchar2(15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Toll_Free_Ind</b></td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">Y = No Toll</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Will Be Charged</td>
</tr>

<tr>
<td class="org-left">Bl_Call_Dest_State</td>
<td class="org-left">Varchar2(2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Bl_Call_Dest_City</td>
<td class="org-left">Varchar2(30 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Automatically_Authorized</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Description</td>
<td class="org-left">Varchar2(50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Expiration_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-7-4" CREATED="1553536041489" MODIFIED="1553536041489" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PC9_SERVE_AREA_TO_SID
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Maps the service area to (<i>all maybe to strong a term</i>)
supported <b>SIDS</b>.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Serve_Area</td>
<td class="org-left">Varchar2(50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Sids</b></td>
<td class="org-left">Varchar2(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Effective_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Expiration_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-7-5" CREATED="1553536041489" MODIFIED="1553536041489" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PC9_COUNTRY_CODE
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
List of country code, country description, NANP indicator.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Cindex</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Country_Code</td>
<td class="org-left">Varchar2(3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Description</td>
<td class="org-left">Varchar2(30 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Nanp_Ind</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-7-6" CREATED="1553536041489" MODIFIED="1553536041489" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PC9_INCOL_SID_PAIR
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Defines <b>InCollect</b> roaming agreement between <b>SID</b> pair.
Originating category is retrieve from the table that is used
later on for service filter determination. INCOL_SID_PAIR
and <b>SID</b> tables are also used by Acquisition &amp; Formatting.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Serve_Sid</td>
<td class="org-left">Varchar2(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Home_Sid</td>
<td class="org-left">Varchar2(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Effective_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Originating_Category</td>
<td class="org-left">Varchar2(6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Incol_Not_Valid_Act</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Agr_Peak_Rate</td>
<td class="org-left">Number(18,3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Agr_Off_Peak_Rate</td>
<td class="org-left">Number(18,3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Agr_Schg_Amt</td>
<td class="org-left">Number(18,3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Toll_Agr_Type</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Agr_Toll_Rate</td>
<td class="org-left">Number(18,3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Incol_Tl_Nvalid_Ac</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Daily_Surcharge_Indication</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Expiration_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-7-7" CREATED="1553536041489" MODIFIED="1553536041489" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PC9_CELL_SITE_TO_CELL_ID
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Cell site name to number ID.
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-7-8" CREATED="1553536041489" MODIFIED="1553536041489" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PC9_SERVICE_FILTER
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
This table as well and <b>PC3_SERVICE_FILTER_LIST</b> are used by the <b>RLC</b>.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Be</td>
<td class="org-left">Number(2,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call_Source</td>
<td class="org-left">Varchar2(4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Service_Type</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Originating_Category</td>
<td class="org-left">Varchar2(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Destination_Category</td>
<td class="org-left">Varchar2(5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call_Direction</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Effective_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Service_Filter</td>
<td class="org-left">Varchar2(15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Description</td>
<td class="org-left">Varchar2(30 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Expiration_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-7-9" CREATED="1553536041489" MODIFIED="1553536041489" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PC3_SERVICE_FILTER_LIST
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
This table as well as <b>PC3_SERVICE_FILTER</b> are used by
the <b>RLC</b> to rate the event.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Service_Index</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Service_Filter</td>
<td class="org-left">Varchar2(15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Description</td>
<td class="org-left">Varchar2(50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-7-10" CREATED="1553536041489" MODIFIED="1553536041489" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PC9_DEST_CATEGORY
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Lists all the possible destination categories.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Cindex</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Destination_Category</td>
<td class="org-left">Varchar2(6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Description</td>
<td class="org-left">Varchar2(101 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-7-11" CREATED="1553536041490" MODIFIED="1553536041490" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PC9_NUMBER_ANALYSIS
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Used to analyze telephone prefix's. Mostly used to determine
International calls.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Prefix</td>
<td class="org-left">Varchar2(30 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Station_Type</td>
<td class="org-left">Varchar2(30 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Effective_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Destination_Category</td>
<td class="org-left">Varchar2(6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Automatically_Authorized</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Roaming_Dest_Category</td>
<td class="org-left">Varchar2(6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Drop_Ind</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Country_Code</td>
<td class="org-left">Varchar2(3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Description</td>
<td class="org-left">Varchar2(30 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Network_Call_Type</td>
<td class="org-left">Char(1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Expiration_Date</td>
<td class="org-left">Date</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-7-12" CREATED="1553536041490" MODIFIED="1553536041490" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PC9_ORIG_CATEGORY
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
List all possible originating categories.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Cindex</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Originating_Category</td>
<td class="org-left">Varchar2(6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Description</td>
<td class="org-left">Varchar2(101 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-7-13" CREATED="1553536041490" MODIFIED="1553536041490" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PC9_ROAMING_DEST_CATEGORY
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
List all roaming destination categories.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Cindex</td>
<td class="org-left">Number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Roaming_Dest_Category</td>
<td class="org-left">Varchar2(6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Description</td>
<td class="org-left">Varchar2(101 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-7-14" CREATED="1553536041490" MODIFIED="1553536041490" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PC1_CHARGE_CODE
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Lists and describes the supported charge codes.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Charge_Code_Seq</td>
<td class="org-left">Number(5,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge_Code</td>
<td class="org-left">Varchar2(15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Description</td>
<td class="org-left">Varchar2(4000 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge_Entity</td>
<td class="org-left">Varchar2(60 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Revenue_Type</td>
<td class="org-left">Char(2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-7-15" CREATED="1553536041490" MODIFIED="1553536041490" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PC9_NANP_NPA_LIST
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
The NPA (Area Code) and the country description.
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-7-16" CREATED="1553536041490" MODIFIED="1553536041490" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PC9_LOCAL_TOLL_FREE_AREA
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Lists the relationship between <b>SIDS</b> and NPA ranges where the toll is free.
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-7-17" CREATED="1553536041490" MODIFIED="1553536041490" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PC9_IP_ADDR_LIST
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
This contains the list of all of the pre-paid IP's. When a new IP is going to be used for pre-pay, it needs to be added to this table. Otherwise it will show up as roaming.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column Name</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">cindex</td>
<td class="org-left">number(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">address</td>
<td class="org-left">varchar2(256 byte)</td>
<td class="org-left">i.p address</td>
</tr>

<tr>
<td class="org-left">description</td>
<td class="org-left">varchar2(101 byte)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
</node>
<node ID="sec-7-2" CREATED="1553536041451" MODIFIED="1553536041451" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Usage DB by cycle
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-right" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-right"><b>CycleCode</b></th>
<th scope="col" class="org-left"><b>Database</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-right">2</td>
<td class="org-left">TC1PRD</td>
<td class="org-left">General Cycle close on the 1st</td>
</tr>

<tr>
<td class="org-right">4</td>
<td class="org-left">TC4PRD</td>
<td class="org-left">General Cycle close on the 3rd</td>
</tr>

<tr>
<td class="org-right">6</td>
<td class="org-left">TC4PRD</td>
<td class="org-left">General Cycle close on the 5th</td>
</tr>

<tr>
<td class="org-right">8</td>
<td class="org-left">TC1PRD</td>
<td class="org-left">General Cycle close on the 7th</td>
</tr>

<tr>
<td class="org-right">10</td>
<td class="org-left">TC3PRD</td>
<td class="org-left">General Cycle close on the 9th</td>
</tr>

<tr>
<td class="org-right">12</td>
<td class="org-left">TC2PRD</td>
<td class="org-left">General Cycle close on the 11th</td>
</tr>

<tr>
<td class="org-right">14</td>
<td class="org-left">TC4PRD</td>
<td class="org-left">General Cycle close on the 13th</td>
</tr>

<tr>
<td class="org-right">16</td>
<td class="org-left">TC3PRD</td>
<td class="org-left">General Cycle close on the 15th</td>
</tr>

<tr>
<td class="org-right">18</td>
<td class="org-left">TC2PRD</td>
<td class="org-left">General Cycle close on the 17th</td>
</tr>

<tr>
<td class="org-right">20</td>
<td class="org-left">TC1PRD</td>
<td class="org-left">General Cycle close on the 19th</td>
</tr>

<tr>
<td class="org-right">22</td>
<td class="org-left">TC2PRD</td>
<td class="org-left">General Cycle close on the 21st</td>
</tr>

<tr>
<td class="org-right">24</td>
<td class="org-left">TC3PRD</td>
<td class="org-left">General Cycle close on the 23rd</td>
</tr>

<tr>
<td class="org-right">26</td>
<td class="org-left">TC4PRD</td>
<td class="org-left">General Cycle close on the 25th</td>
</tr>

<tr>
<td class="org-right">28</td>
<td class="org-left">TC3PRD</td>
<td class="org-left">General Cycle close on the 27th</td>
</tr>

<tr>
<td class="org-right">77</td>
<td class="org-left">TC1PRD</td>
<td class="org-left">Dropped events cycle</td>
</tr>

<tr>
<td class="org-right">80</td>
<td class="org-left">TC3PRD</td>
<td class="org-left">Rejected events cycle</td>
</tr>

<tr>
<td class="org-right">99</td>
<td class="org-left">TC2PRD</td>
<td class="org-left">Reserved for OutCollect Cycle close on the 31th</td>
</tr>

<tr>
<td class="org-right">1002</td>
<td class="org-left">TC2PRD</td>
<td class="org-left">Reseller Cycle close on the 1st</td>
</tr>

<tr>
<td class="org-right">1004</td>
<td class="org-left">TC1PRD</td>
<td class="org-left">Reseller Cycle close on the 3rd</td>
</tr>

<tr>
<td class="org-right">1006</td>
<td class="org-left">TC1PRD</td>
<td class="org-left">Reseller Cycle close on the 5th</td>
</tr>

<tr>
<td class="org-right">1008</td>
<td class="org-left">TC3PRD</td>
<td class="org-left">Reseller Cycle close on the 7th</td>
</tr>

<tr>
<td class="org-right">1010</td>
<td class="org-left">TC2PRD</td>
<td class="org-left">Reseller Cycle close on the 9th</td>
</tr>

<tr>
<td class="org-right">1012</td>
<td class="org-left">TC4PRD</td>
<td class="org-left">Reseller Cycle close on the 11th</td>
</tr>

<tr>
<td class="org-right">1014</td>
<td class="org-left">TC1PRD</td>
<td class="org-left">Reseller Cycle close on the 13th</td>
</tr>

<tr>
<td class="org-right">1016</td>
<td class="org-left">TC2PRD</td>
<td class="org-left">Reseller Cycle close on the 15th</td>
</tr>

<tr>
<td class="org-right">1018</td>
<td class="org-left">TC4PRD</td>
<td class="org-left">Reseller Cycle close on the 17th</td>
</tr>

<tr>
<td class="org-right">1020</td>
<td class="org-left">TC3PRD</td>
<td class="org-left">Reseller Cycle close on the 19th</td>
</tr>

<tr>
<td class="org-right">1022</td>
<td class="org-left">TC3PRD</td>
<td class="org-left">Reseller Cycle close on the 21st</td>
</tr>

<tr>
<td class="org-right">1024</td>
<td class="org-left">TC1PRD</td>
<td class="org-left">Reseller Cycle close on the 23rd</td>
</tr>

<tr>
<td class="org-right">1026</td>
<td class="org-left">TC4PRD</td>
<td class="org-left">Reseller Cycle close on the 25th</td>
</tr>

<tr>
<td class="org-right">1028</td>
<td class="org-left">TC2PRD</td>
<td class="org-left">Reseller Cycle close on the 27th</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
</node>
<node POSITION="left" ID="sec-3" CREATED="1553536041438" MODIFIED="1553620741496" COLOR="#0033ff"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Unified File Format (UFF)
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
In <b>TOPs</b> system all <b>CDRs</b>, excluding <b>InCollect/OutCollect CIBER</b>,
will be reformatted into a <i>Unified File Format</i> (<b>UFF</b>). This format
will be a standard <b>Unix/ASCII</b> formatted <b>CSV</b> file using '|'
<b>(pipe)</b> as the delimiter.
</p>
</body>
</html>
</richcontent>
<node ID="sec-3-1" CREATED="1553536041438" MODIFIED="1553536041438" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>UFF File Record Format
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-right" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-right"><b>Field</b></th>
<th scope="col" class="org-left"><b>Field Name</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-right">1</td>
<td class="org-left">Record Type</td>
<td class="org-left">HR - Header Record</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">DR - Data Record</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">TR - Trailer Record</td>
</tr>

<tr>
<td class="org-right">2</td>
<td class="org-left">Service Type</td>
<td class="org-left">Initial record type of Usage Record <b>MOT, PTX, ALU, QIS</b>,</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left"><b>AAA, TPC, APLX, NTI, PMG, PGW</b></td>
</tr>

<tr>
<td class="org-right">3</td>
<td class="org-left">Record sequence Number</td>
<td class="org-left">A unique numeric identifier for the record.</td>
</tr>

<tr>
<td class="org-right">4</td>
<td class="org-left">File Number</td>
<td class="org-left">A unique identifier that shows the original file</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">that the record came in from. <i>(ex. ID044803</i>)</td>
</tr>

<tr>
<td class="org-right">5</td>
<td class="org-left">Record Disposition</td>
<td class="org-left">The disposition shows the destination of the record</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">in the Mediation process.</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">0 = Rated</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">1 = Dropped</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">2 = Error</td>
</tr>

<tr>
<td class="org-right">6</td>
<td class="org-left">Record Code</td>
<td class="org-left">The Drop or Error code. The drop and error codes will be defined</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">using present day <b>AMDOCS</b> codes as a template. (presently a 3</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">digit integer but will bump to 5 for extra growth)</td>
</tr>

<tr>
<td class="org-right">7</td>
<td class="org-left">Source System</td>
<td class="org-left">Switch identifier (See Switch Name and type tab for a complete</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">listing) (Possible Voice values include:</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">madi, scha etc.) (Data values can include aaa1, vali etc.</td>
</tr>

<tr>
<td class="org-right">8</td>
<td class="org-left">Start Date</td>
<td class="org-left">Start date for this event {YYYYMMDD}</td>
</tr>

<tr>
<td class="org-right">9</td>
<td class="org-left">Start Time</td>
<td class="org-left">Start Time for this event {HHMMSSss}</td>
</tr>

<tr>
<td class="org-right">10</td>
<td class="org-left">Start Time Zone</td>
<td class="org-left">Offset in seconds from <b>GMT</b></td>
</tr>

<tr>
<td class="org-right">11</td>
<td class="org-left">Home Sid</td>
<td class="org-left">Home Switch ID</td>
</tr>

<tr>
<td class="org-right">12</td>
<td class="org-left">Serve SID</td>
<td class="org-left">Serving Switch ID</td>
</tr>

<tr>
<td class="org-right">13</td>
<td class="org-left">Originating Cell Trunk</td>
<td class="org-left">Initial cell trunk</td>
</tr>

<tr>
<td class="org-right">14</td>
<td class="org-left">Terminating Cell Trunk</td>
<td class="org-left">Termination Cell trunk</td>
</tr>

<tr>
<td class="org-right">15</td>
<td class="org-left">BSID</td>
<td class="org-left">Broadcast Station ID</td>
</tr>

<tr>
<td class="org-right">16</td>
<td class="org-left">Carrier ID</td>
<td class="org-left">The carrier that handled the events identification symbol.</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Mostly USCC but may contain others especially in</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">data roaming situations.</td>
</tr>

<tr>
<td class="org-right">17</td>
<td class="org-left">Protocol</td>
<td class="org-left"><b>EVDO, LTE, CDMA</b></td>
</tr>

<tr>
<td class="org-right">18</td>
<td class="org-left">Event Type</td>
<td class="org-left"><b>QIS</b> event type used for reporting and drop logic</td>
</tr>

<tr>
<td class="org-right">19</td>
<td class="org-left">Call Direction</td>
<td class="org-left">One of two types:</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left"><b>Mobile Originating (MO)</b> or <b>Mobile Terminating (MT)</b>.</td>
</tr>

<tr>
<td class="org-right">20</td>
<td class="org-left">Originating MSID</td>
<td class="org-left">10-Digit Mobile Identification Number 16 digits for</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">possible future use/Blanks if mobile terminated</td>
</tr>

<tr>
<td class="org-right">21</td>
<td class="org-left">Identity</td>
<td class="org-left">MEID/ESN</td>
</tr>

<tr>
<td class="org-right">22</td>
<td class="org-left">Originating MDN</td>
<td class="org-left">In a Mobile Originating call It's the originating callers</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">phone number.</td>
</tr>

<tr>
<td class="org-right">23</td>
<td class="org-left">Originating Address</td>
<td class="org-left">IP or Email</td>
</tr>

<tr>
<td class="org-right">24</td>
<td class="org-left">Terminating MSID</td>
<td class="org-left">Called MSID this is on Mobile to Mobile records only.</td>
</tr>

<tr>
<td class="org-right">25</td>
<td class="org-left">Terminating Number</td>
<td class="org-left">Normalized number <i>(example 6085551212 instead of 411</i></td>
</tr>

<tr>
<td class="org-right">26</td>
<td class="org-left">Dialed Digits</td>
<td class="org-left">The untranslated dialed number <i>(e.g. 441 instead of 555-1212)</i></td>
</tr>

<tr>
<td class="org-right">27</td>
<td class="org-left">Terminating Address</td>
<td class="org-left">IP Address/Email Name Client IP for <b>PMG</b></td>
</tr>

<tr>
<td class="org-right">28</td>
<td class="org-left">Termination Code</td>
<td class="org-left"><b>SMS.CALL_TERMINATION_CODE</b></td>
</tr>

<tr>
<td class="org-right">29</td>
<td class="org-left">Service Feature</td>
<td class="org-left">MPS Service feature codes</td>
</tr>

<tr>
<td class="org-right">30</td>
<td class="org-left">Call Forwarding Ind</td>
<td class="org-left">If the call has been forwarded than true, false otherwise.</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">0 = False</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">1 = True</td>
</tr>

<tr>
<td class="org-right">31</td>
<td class="org-left">Call Delivery Ind</td>
<td class="org-left">If the call has been through call delivery than true,</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">false otherwise</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">0 = False</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">1 = True</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">2 = CDLX</td>
</tr>

<tr>
<td class="org-right">32</td>
<td class="org-left">Call Waiting Ind</td>
<td class="org-left">If the call has been through call waiting than true,</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">false otherwise</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">0 = False</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">1 = True</td>
</tr>

<tr>
<td class="org-right">33</td>
<td class="org-left">3 way Calling Ind</td>
<td class="org-left">If the call has been through 3 way calling, false otherwise</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">0 = False</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">1 = True</td>
</tr>

<tr>
<td class="org-right">34</td>
<td class="org-left">Call Answered Ind</td>
<td class="org-left">If the call has been answered than true, false otherwise.</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">0 = False</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">1 = True</td>
</tr>

<tr>
<td class="org-right">35</td>
<td class="org-left">Ring Time</td>
<td class="org-left">Total ring time in seconds</td>
</tr>

<tr>
<td class="org-right">36</td>
<td class="org-left">Call Duration</td>
<td class="org-left">Call duration minus ring-time in seconds.</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Includes the duration in seconds of the data session</td>
</tr>

<tr>
<td class="org-right">37</td>
<td class="org-left">Roaming Ind</td>
<td class="org-left">Data roaming indicator 0 = False 1 = True</td>
</tr>

<tr>
<td class="org-right">38</td>
<td class="org-left">Session ID</td>
<td class="org-left">Primary Key for AAA, Transaction ID for</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">PSMS AAA.SESSION_ID &lt;= 64 Chars</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">PSMS.TRANS_ID &lt;= 50 Chars</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">QIS.EVENT_ID &lt;= 50 chars Used to find the charge code</td>
</tr>

<tr>
<td class="org-right">39</td>
<td class="org-left">Session Type</td>
<td class="org-left">For QIS 0 = Charge (only) For PSMS there are two possible values:</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">0 = Charge</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">1 = Adjustment</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">For <b>PTX</b> and <b>SMS</b> we can have the following values:</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left"><b>SMSTXT and SMSEMIL</b></td>
</tr>

<tr>
<td class="org-right">40</td>
<td class="org-left">Bytes In</td>
<td class="org-left">Total of incoming bytes associated</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">this event can also be negative.</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Using this field and the "Bytes Out" field</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">we can derive the total bytes.</td>
</tr>

<tr>
<td class="org-right">41</td>
<td class="org-left">Bytes Out</td>
<td class="org-left">Total of outgoing bytes associated with this event contains</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">a signed byte (+-) Using this field and the "Bytes In" field</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">we can derive the total bytes.</td>
</tr>

<tr>
<td class="org-right">42</td>
<td class="org-left">Application ID</td>
<td class="org-left">QIS = Part ID AAA = AppID PSMS = Short Code</td>
</tr>

<tr>
<td class="org-right">43</td>
<td class="org-left">Application Type</td>
<td class="org-left">QIS = (Download or Subscription) PSMS = (One-Off or Subscription)</td>
</tr>

<tr>
<td class="org-right">44</td>
<td class="org-left">Application Name</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-right">45</td>
<td class="org-left">Purchase Category Code</td>
<td class="org-left">Used by PSMS</td>
</tr>

<tr>
<td class="org-right">46</td>
<td class="org-left">Application Description</td>
<td class="org-left">Will be used for both QIS and PSMS for QIS it will come from the</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">AE field directly on the record for PSMS it will be a</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">combination of the &lt;short code&gt; &lt;description&gt; &lt;content provider&gt;</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">if it is a "Subscription", "Subscription -" is displayed.</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">If it is a one-off, it is not</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">presented in the invoice line item.</td>
</tr>

<tr>
<td class="org-right">47</td>
<td class="org-left">Content Amount</td>
<td class="org-left">Combines Pre-rated usage amount for QIS and PSMS</td>
</tr>

<tr>
<td class="org-right">48</td>
<td class="org-left">Orig_trans_ID</td>
<td class="org-left">Orig Trans ID PSMS.TRANS_ID</td>
</tr>

<tr>
<td class="org-right">49</td>
<td class="org-left">Network Flag</td>
<td class="org-left">Used by QIS to calculate the charge code.</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">0 = not a 1 = is a network application..</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Default is 0</td>
</tr>

<tr>
<td class="org-right">50</td>
<td class="org-left">Femto-cell-ringtime</td>
<td class="org-left">Will not be needed until after <b>TOPS</b> implementation</td>
</tr>

<tr>
<td class="org-right">51</td>
<td class="org-left">Femto-cell-ringpluse</td>
<td class="org-left">Will not be needed until after <b>TOPS</b> implementation</td>
</tr>

<tr>
<td class="org-right">52</td>
<td class="org-left">LTE Handoff</td>
<td class="org-left">This maybe needed after the move to LTE,</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">so is just used as a placeholder</td>
</tr>

<tr>
<td class="org-right">53</td>
<td class="org-left">Market/Sub-market</td>
<td class="org-left">The Market and Sub-market for a customer this can also be blank.</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">This field is populated by using a MSID against the MIN_LR</td>
</tr>

<tr>
<td class="org-right">54</td>
<td class="org-left">Originating IMSI</td>
<td class="org-left">The IMSI assigned to the SIM card originating a LTE or eHRPD</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">data session. This can be a routing parameter</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">for LTE or eHRPD traffic.</td>
</tr>

<tr>
<td class="org-right">55</td>
<td class="org-left">Adjustment Reason Code</td>
<td class="org-left">The Adjustment Reason Code for a PSMS adjustment</td>
</tr>

<tr>
<td class="org-right">56</td>
<td class="org-left">External Reference ID</td>
<td class="org-left">The External Reference ID for a PSMS record</td>
</tr>

<tr>
<td class="org-right">57</td>
<td class="org-left">Partner ID</td>
<td class="org-left">The Partner ID for PSMS record</td>
</tr>

<tr>
<td class="org-right">58</td>
<td class="org-left">Campaign ID</td>
<td class="org-left">The Campaign ID for a PSMS record</td>
</tr>

<tr>
<td class="org-right">59</td>
<td class="org-left">Initiator Type</td>
<td class="org-left">The Initiator Type for PSMS record</td>
</tr>

<tr>
<td class="org-right">60</td>
<td class="org-left">Initiator ID</td>
<td class="org-left">The Initiator ID for PSMS record</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-3-2" CREATED="1553536041440" MODIFIED="1553536041440" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Header
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-right" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-right"><b>Field</b></th>
<th scope="col" class="org-left"><b>Field Name</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-right">1</td>
<td class="org-left">Record Type</td>
<td class="org-left">The record type for Header is HR</td>
<td class="org-left">4 character alpha-numeric</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-right">2</td>
<td class="org-left">File Number</td>
<td class="org-left">file Identifier A unique identifier</td>
<td class="org-left">alpha-numeric &lt;= 24 chars and</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">that shows the original file that</td>
<td class="org-left">have the pattern IDxxxxxxx..</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">the record name in from. (ex. ID044803)</td>
<td class="org-left">Where xxxx is a number that's</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">no greater then 16 char</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-right">3</td>
<td class="org-left">Source System</td>
<td class="org-left">Switch identifier (See Switch Name</td>
<td class="org-left">alpha-numeric &lt;= 16 characters</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">and type tab for a complete listing)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">(Possible Voice values include: madi,</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">scha etc.) (Data values can include</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">aaa1, vali etc.</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-right">4</td>
<td class="org-left">Start Date</td>
<td class="org-left">Start date of file creation {YYYYMMDD}</td>
<td class="org-left">Event Date YYYYMMDD</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">1900 &lt;= YYYY &lt;=9999</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">01 &lt;= MM &lt;= 12</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">01 &lt;= DD &lt;= 31</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-right">5</td>
<td class="org-left">Start Time</td>
<td class="org-left">Start Time for file creation {HHMMSSss}</td>
<td class="org-left">Switch Time HHMMSSss</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">00 &lt;= HH &lt;= 23</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">00 &lt;= MM &lt;= 59</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">00 &lt;= SS &lt;= 59</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">00 &lt;= ss &lt;= 59</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-3-3" CREATED="1553536041441" MODIFIED="1553620741484" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Trailer
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-right" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-right"><b>Field</b></th>
<th scope="col" class="org-left"><b>Field Name</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
<th scope="col" class="org-left"><b>Data Type</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-right">1</td>
<td class="org-left">Record Type</td>
<td class="org-left">The record type for Trailer is TR</td>
<td class="org-left">4 character alpha-numeric</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-right">2</td>
<td class="org-left">File Number</td>
<td class="org-left">File Identifier A unique identifier</td>
<td class="org-left">alpha-numeric &lt;= 24 chars and have the</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">that shows the original file that</td>
<td class="org-left">pattern IDxxxxxxx.. Where xxxx is</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">the record came in from. (ex. ID044803)</td>
<td class="org-left">a number that's no greater then 16 char</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-right">3</td>
<td class="org-left">Source System</td>
<td class="org-left">Switch identifier (See Switch Name</td>
<td class="org-left">alpha-numeric &lt;= 16 chars</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">and type tab for a complete listing)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">(Data values can include aaa1, vali etc.</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-right">4</td>
<td class="org-left">End Date</td>
<td class="org-left">End date of file creation {YYYYMMDD}</td>
<td class="org-left">Event Date YYYYMMDD</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">1900 &lt;= YYYY &lt;=9999</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">01 &lt;= MM &lt;= 12</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">01 &lt;= DD &lt;= 31</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-right">5</td>
<td class="org-left">End Time</td>
<td class="org-left">End Time of file creation {HHMMSSss}</td>
<td class="org-left">Switch Time HHMMSSss</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">00 &lt;= HH &lt;= 23</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">00 &lt;= MM &lt;= 59</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">00 &lt;= SS &lt;= 59</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">00 &lt;= ss &lt;= 59</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-right">6</td>
<td class="org-left">Total Records</td>
<td class="org-left">Total number of records in this file</td>
<td class="org-left">numeric &lt;= 100000000</td>
</tr>

<tr>
<td class="org-right">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">(Including Header and trailers)</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-3-4" CREATED="1553536041441" MODIFIED="1553536041441" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Service Feature Codes
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Description</b></th>
<th scope="col" class="org-left"><b>Code</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">(NTI Only) - Automatic Roaming</td>
<td class="org-left">ARM</td>
</tr>

<tr>
<td class="org-left">Call Delivery Interconnect</td>
<td class="org-left">CDLX</td>
</tr>

<tr>
<td class="org-left">Call Forward Immediate</td>
<td class="org-left">CFW</td>
</tr>

<tr>
<td class="org-left">Call Forward Busy</td>
<td class="org-left">CFB</td>
</tr>

<tr>
<td class="org-left">Call Forward No Answer Transfer</td>
<td class="org-left">CFWTRN</td>
</tr>

<tr>
<td class="org-left">(NTI Only) - Calls to/from hotline</td>
<td class="org-left">HT</td>
</tr>

<tr>
<td class="org-left">(NTI Only) -Inter system hand-off</td>
<td class="org-left">ISH</td>
</tr>

<tr>
<td class="org-left">Operator assisted call</td>
<td class="org-left">OPA</td>
</tr>

<tr>
<td class="org-left">(NTI Only) - Vertical feature flag</td>
<td class="org-left">VFF</td>
</tr>

<tr>
<td class="org-left">Voice-mail delivery</td>
<td class="org-left">VMD</td>
</tr>

<tr>
<td class="org-left">Voice-mail retrieval</td>
<td class="org-left">VMR</td>
</tr>

<tr>
<td class="org-left">Caller ID Restriction (ID block)</td>
<td class="org-left">CIR</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-3-5" CREATED="1553536041441" MODIFIED="1553536041441" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p><a href="docs/Drop%20Reason%20Codes.pdf">Drop Reason Codes</a>
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
</node>
</node>
<node POSITION="left" ID="sec-4" CREATED="1553536041442" MODIFIED="1553620745067" COLOR="#0033ff"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>CIBER File Format
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>
<node ID="sec-4-1-1" CREATED="1553536041442" MODIFIED="1553536041442" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>CIBER 01 Record
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-right" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Field</b></th>
<th scope="col" class="org-right"><b>Position</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Record Type</td>
<td class="org-right">1-2</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Batch Creation Date</td>
<td class="org-right">3-8</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Batch Sequence Number</td>
<td class="org-right">9-11</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sending Carrier SID/BID</td>
<td class="org-right">12-16</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Receiving Carrier SID/BID</td>
<td class="org-right">17-21</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CIBER Record Release Number</td>
<td class="org-right">22-23</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Original/Return Indicator</td>
<td class="org-right">24-24</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Currency Type</td>
<td class="org-right">25-26</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Settlement Period</td>
<td class="org-right">27-32</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Clearinghouse ID</td>
<td class="org-right">33-33</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CIBER Batch Reject Reason Code</td>
<td class="org-right">34-35</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Batch Contents</td>
<td class="org-right">36-36</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Local Carrier Reserved</td>
<td class="org-right">37-56</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">57-200</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-4-1-2" CREATED="1553536041442" MODIFIED="1553536041442" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>CIBER 22 Record
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-right" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>FIELD NAME</b></th>
<th scope="col" class="org-right"><b>POSITION</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Record Type</td>
<td class="org-right">1-2</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Return Code</td>
<td class="org-right">3-3</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CIBER Record Return Reason Code</td>
<td class="org-right">4-5</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Invalid Field Identifier</td>
<td class="org-right">6-8</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Home Carrier SID/BID</td>
<td class="org-right">9-13</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MSID Indicator</td>
<td class="org-right">14-14</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>MSID</b></td>
<td class="org-right">15-29</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MSISDN/MDN Length</td>
<td class="org-right">30-31</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>MSISDN/MDN</b></td>
<td class="org-right">32-46</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>ESN/UIMID/IMEI/MEID Indicator</b></td>
<td class="org-right">47-47</td>
<td class="org-left">0 = NA</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-right">&#xa0;</td>
<td class="org-left">1 = ESN</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-right">&#xa0;</td>
<td class="org-left">2 = IMEI</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-right">&#xa0;</td>
<td class="org-left">3 = MEID</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-right">&#xa0;</td>
<td class="org-left">4 = pESN</td>
</tr>

<tr>
<td class="org-left"><b>ESN/UIMID/IMEI/MEID</b></td>
<td class="org-right">48-66</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Serving Carrier SID/BID</b></td>
<td class="org-right">67-71</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Total Charges and Taxes</b></td>
<td class="org-right">72-81</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">82-82</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Total State/Province Taxes</b></td>
<td class="org-right">83-92</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">93-93</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Total Local/Other Taxes</b></td>
<td class="org-right">94-103</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">104-104</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Call Date</b></td>
<td class="org-right">105-110</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Call Direction</b></td>
<td class="org-right">111-111</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call Completion Indicator</td>
<td class="org-right">112-112</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call Termination Indicator</td>
<td class="org-right">113-113</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Caller ID Length</td>
<td class="org-right">114-115</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Caller ID</td>
<td class="org-right">116-130</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Called Number Length</td>
<td class="org-right">131-132</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Called Number Digits</b></td>
<td class="org-right">133-147</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Location Routing Number Length Indicator</td>
<td class="org-right">148-149</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Location Routing Number</td>
<td class="org-right">150-164</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TLDN Length</td>
<td class="org-right">165-166</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TLDN</td>
<td class="org-right">167-181</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Currency Type</td>
<td class="org-right">182-183</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">184-185</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Original Batch Sequence Number</td>
<td class="org-right">186-188</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Initial Cell Site</td>
<td class="org-right">189-199</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Time Zone Indicator</td>
<td class="org-right">200-201</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Daylight Savings Indicator</td>
<td class="org-right">202-202</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Message Accounting Digits</td>
<td class="org-right">203-212</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Air Connect Time</td>
<td class="org-right">213-218</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Air Chargeable Time</td>
<td class="org-right">219-224</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Air Elapsed Time</td>
<td class="org-right">225-230</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Air Rate Period</td>
<td class="org-right">231-232</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Air Multi-Rate Period</td>
<td class="org-right">233-233</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Air Charge</b></td>
<td class="org-right">234-243</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">244-244</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Other Charge No. 1 Indicator</td>
<td class="org-right">245-246</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Other Charge No. 1</b></td>
<td class="org-right">247-256</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">257-257</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">258-270</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Printed Call</td>
<td class="org-right">271-285</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Fraud Indicator</td>
<td class="org-right">286-287</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Fraud Sub-Indicator</td>
<td class="org-right">288-288</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Special Features Used</b></td>
<td class="org-right">289-293</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Called Place</b></td>
<td class="org-right">294-303</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Called State/Province</b></td>
<td class="org-right">304-305</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Called Country</b></td>
<td class="org-right">306-308</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Serving Place</b></td>
<td class="org-right">309-318</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Serving State/Province</b></td>
<td class="org-right">319-320</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Serving Country</b></td>
<td class="org-right">321-323</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Toll Connect Time</td>
<td class="org-right">324-329</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Toll Chargeable Time</td>
<td class="org-right">330-335</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Toll Elapsed Time</td>
<td class="org-right">336-341</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Toll Tariff Descriptor</td>
<td class="org-right">342-343</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Toll Rate Period</td>
<td class="org-right">344-345</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Toll Multi-Rate Period</td>
<td class="org-right">346-346</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Toll Rate Class</td>
<td class="org-right">347-347</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Toll Rating Point Length Indicator</td>
<td class="org-right">348-349</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Toll Rating Point</td>
<td class="org-right">350-359</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Toll Charge</b></td>
<td class="org-right">360-369</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">370-370</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Toll State/Province Taxes</b></td>
<td class="org-right">371-380</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">381-381</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Toll Local Taxes</b></td>
<td class="org-right">382-391</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">392-392</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Toll Network Carrier ID</td>
<td class="org-right">393-397</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Local Carrier Reserved</td>
<td class="org-right">398-472</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">473-547</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-4-1-3" CREATED="1553536041443" MODIFIED="1553620745064" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>CIBER 32 Record
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-right" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Field</b></th>
<th scope="col" class="org-right"><b>Position</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Record Type</td>
<td class="org-right">1-2</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Return Code</td>
<td class="org-right">3-3</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CIBER Record Return Reason Code</td>
<td class="org-right">4-5</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Invalid Field Identifier</td>
<td class="org-right">6-8</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Home Carrier SID/BID</td>
<td class="org-right">9-13</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MSID Indicator</td>
<td class="org-right">14-14</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MSID</td>
<td class="org-right">15-29</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MSISDN/MDN Length</td>
<td class="org-right">30-31</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MSISDN/MDN</td>
<td class="org-right">32-46</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ESN/UIMID/IMEI/MEID Indicator</td>
<td class="org-right">47-47</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ESN/UIMID/IMEI/MEID</td>
<td class="org-right">48-66</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Serving Carrier SID/BID</td>
<td class="org-right">67-71</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Total Charges and Taxes</td>
<td class="org-right">72-81</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">82-82</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Total State/Province Taxes</td>
<td class="org-right">83-92</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">93-93</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Total Local Taxes</td>
<td class="org-right">94-103</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">104-104</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call Date</td>
<td class="org-right">105-110</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call Direction</td>
<td class="org-right">111-111</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call Completion Indicator</td>
<td class="org-right">112-112</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Call Termination Indicator</td>
<td class="org-right">113-113</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Caller ID Length</td>
<td class="org-right">114-115</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Caller ID</td>
<td class="org-right">116-130</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Called Number Length</td>
<td class="org-right">131-132</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Called Number Digits</td>
<td class="org-right">133-147</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Location Routing Number Length Indicator</td>
<td class="org-right">148-149</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Location Routing Number</td>
<td class="org-right">150-164</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TLDN Length</td>
<td class="org-right">165-166</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TLDN</td>
<td class="org-right">167-181</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Currency Type</td>
<td class="org-right">182-183</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">184-185</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Original Batch Sequence Number</td>
<td class="org-right">186-188</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Initial Cell Site</td>
<td class="org-right">189-199</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Time Zone Indicator</td>
<td class="org-right">200-201</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Daylight Savings Indicator</td>
<td class="org-right">202-202</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Message Accounting Digits</td>
<td class="org-right">203-212</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 1 Indicator</td>
<td class="org-right">213-214</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 1 Connect Time</td>
<td class="org-right">215-220</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 1 Chargeable Time</td>
<td class="org-right">221-226</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 1 Elapsed Time</td>
<td class="org-right">227-232</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 1 Rate Period</td>
<td class="org-right">233-234</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 1 Multi-Rate Period</td>
<td class="org-right">235-235</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 1 Tax/Surcharge Indicator</td>
<td class="org-right">236-236</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 1</td>
<td class="org-right">237-246</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">247-247</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 2 Indicator</td>
<td class="org-right">248-249</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 2 Connect Time</td>
<td class="org-right">250-255</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 2 Chargeable Time</td>
<td class="org-right">256-261</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 2 Elapsed TIme</td>
<td class="org-right">262-267</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 2 Rate Period</td>
<td class="org-right">268-269</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 2 Multi-Rate Period</td>
<td class="org-right">270-270</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 2 Tax/Surcharge Indicator</td>
<td class="org-right">271-271</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 2</td>
<td class="org-right">272-281</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">282-282</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 3 Indicator</td>
<td class="org-right">283-284</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 3 Connect Time</td>
<td class="org-right">285-290</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 3 Chargeable Time</td>
<td class="org-right">291-296</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 3 Elapsed Time</td>
<td class="org-right">297-302</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 3 Rate Period</td>
<td class="org-right">303-304</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 3 Multi-Rate Period</td>
<td class="org-right">305-305</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 3 Tax/Surcharge Indicator</td>
<td class="org-right">306-306</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 3</td>
<td class="org-right">307-316</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">317-317</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 4 Indicator</td>
<td class="org-right">318-319</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 4 Connect Time</td>
<td class="org-right">320-325</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 4 Chargeable Time</td>
<td class="org-right">326-331</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 4 Elapsed Time</td>
<td class="org-right">332-337</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 4 Rate Period</td>
<td class="org-right">338-339</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 4 Multi-Rate Period</td>
<td class="org-right">340-340</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 4 Tax/Surcharge Indicator</td>
<td class="org-right">341-341</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Charge No. 4</td>
<td class="org-right">342-351</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">352-352</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Blank Fill Serving Place</td>
<td class="org-right">353-362</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Serving State/Province</td>
<td class="org-right">363-364</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Serving Country</td>
<td class="org-right">365-367</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Special Features Used</td>
<td class="org-right">368-372</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Other Charge No. 1 Indicator</td>
<td class="org-right">373-374</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Other Charge No. 1</td>
<td class="org-right">375-384</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">385-385</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">386-398</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Printed Call</td>
<td class="org-right">399-413</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Fraud Indicator</td>
<td class="org-right">414-415</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Fraud Sub-Indicator</td>
<td class="org-right">416-416</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Features Used After Handoff Indicator</td>
<td class="org-right">417-417</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Local Carrier Reserved</td>
<td class="org-right">418-492</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">493-567</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-4-1-4" CREATED="1553536041444" MODIFIED="1553536041444" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>CIBER 52 Record
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-right" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>FIELD</b></th>
<th scope="col" class="org-right"><b>POSITION</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Return Code</td>
<td class="org-right">3-3</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CIBER Record Return Reason Code</td>
<td class="org-right">4-5</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Invalid Field Identifier</td>
<td class="org-right">6-8</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Home Carrier SID/BID</td>
<td class="org-right">9-13</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MSID Indicator</td>
<td class="org-right">14-14</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>MSID</b></td>
<td class="org-right">15-29</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MSISDN/MDN Length</td>
<td class="org-right">30-31</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MSISDN/MDN</td>
<td class="org-right">32-46</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ESN/UIMID/IMEI/MEID Indicator</td>
<td class="org-right">47-47</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ESN/UIMID/IMEI/MEID</td>
<td class="org-right">48-66</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Serving Carrier SID/BID</td>
<td class="org-right">67-71</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Total Charges and Taxes</b></td>
<td class="org-right">72-81</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">82-82</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Total State/Province Taxes</b></td>
<td class="org-right">83-92</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">93-93</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Total Local Taxes</b></td>
<td class="org-right">94-103</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">104-104</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>OCC Charge/Start Date</b></td>
<td class="org-right">105-110</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Connect Time</td>
<td class="org-right">111-116</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OCC End Date</td>
<td class="org-right">117-122</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OCC Interval Indicator</td>
<td class="org-right">124-133</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>OCC Charge</b></td>
<td class="org-right">134-134</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">135-159</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OCC Description Currency Type</td>
<td class="org-right">160-161</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">123-123</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Original Batch Sequence Number</td>
<td class="org-right">164-166</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Initial Cell Site</td>
<td class="org-right">167-177</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Time Zone Indicator</td>
<td class="org-right">178-179</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Daylight Savings Indicator</td>
<td class="org-right">180-180</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Message Accounting Digits</td>
<td class="org-right">181-190</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Record Use Indicator</td>
<td class="org-right">191-191</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Serving Place</td>
<td class="org-right">192-201</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Serving State/Province</td>
<td class="org-right">202-203</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Serving Country</td>
<td class="org-right">204-206</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Other Charge No. 1 Indicator</td>
<td class="org-right">207-208</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Other Charge No. 1</td>
<td class="org-right">209-218</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">219-219</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">220-232</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Fraud Indicator</td>
<td class="org-right">233-234</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Fraud Sub-Indicator</td>
<td class="org-right">235-235</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Record Create Date</td>
<td class="org-right">236-241</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">220-232</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Fraud Indicator</td>
<td class="org-right">233-234</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Fraud Sub-Indicator</td>
<td class="org-right">235-235</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Record Create Date</td>
<td class="org-right">236-241</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-4-1-5" CREATED="1553536041445" MODIFIED="1553536041445" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>CIBER 98 Record
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-right" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>FIELD</b></th>
<th scope="col" class="org-right"><b>POSITION</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Record Type</td>
<td class="org-right">1-2</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Batch Creation Date</td>
<td class="org-right">3-8</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Batch Sequence Number</td>
<td class="org-right">9-11</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Sending Carrier SID/BID</td>
<td class="org-right">12-16</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Receiving Carrier SID/BID</td>
<td class="org-right">17-21</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Total Number Records in Batch</b></td>
<td class="org-right">22-25</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Batch Total Charges &amp; Taxes</b></td>
<td class="org-right">26-37</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Settlement Period</td>
<td class="org-right">38-43</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Clearinghouse ID</td>
<td class="org-right">44-44</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">45-49</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Original Total Number of Records</td>
<td class="org-right">50-53</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>Original Total Charges &amp; Taxes</b></td>
<td class="org-right">54-65</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">66-73</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Currency Type</td>
<td class="org-right">74-75</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">Local Carrier Reserved</td>
<td class="org-right">76-95</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">System Reserved Filler</td>
<td class="org-right">96-200</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
</node>
</node>
</map>
