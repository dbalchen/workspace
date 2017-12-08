<map version="freeplane 1.3.0">
<!--To view this file, download free mind mapping software Freeplane from http://freeplane.sourceforge.net -->
<attribute_registry SHOW_ATTRIBUTES="selected"/>
<node TEXT="Notes" ID="ID_1224027211" CREATED="1468275705048" MODIFIED="1470337133214" COLOR="#000000" TEXT_SHORTENED="true">
<font NAME="SansSerif" SIZE="20"/>
<hook NAME="MapStyle" zoom="0.4">
    <properties show_icon_for_attributes="false" show_note_icons="true" show_notes_in_map="false"/>

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
<node POSITION="right" ID="sec-1" CREATED="1468275705052" MODIFIED="1468275705052" COLOR="#0033ff"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Statement of Principals
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
<ul class="org-ul">
<li><i>Mathematics is a language with no ambiguity.</i></li>
<li><i>A successful man made system will closely resembles some natural system.</i></li>
<li><i>A Powerpoint presentation is like smoking a cigar, only the
person doing it likes it.</i></li>
<li><i>Probability from a point.</i></li>
</ul>

<pre class="example">
-  $a(i) = 1-$ \Large $\frac{i}{n}$ \normalsize where $0 &lt;= i &lt; n$ and $n &gt; 0$
</pre>
</body>
</html>
</richcontent>
</node>
<node TEXT="Usage Overview" POSITION="left" ID="sec-2" CREATED="1468275705062" MODIFIED="1468535253314" COLOR="#0033ff" TEXT_SHORTENED="true">
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>
<richcontent TYPE="NOTE">

<html>
  <head>
    
  </head>
  <body>
    <p>
      An event that gets rated in the system is called usage and is why we have a billing system in the first place. We tend to think of usage in two types, <b>Voice</b>&#160;and <b>Data</b>.
    </p>
    <p>
      
    </p>
    <p>
      <b>Voice</b>
    </p>
    <ol class="org-ol">
      <li>
        <b>Alcatel Lucent (APLX)</b>&#160;- The <b>Alcatel Lucent APLX</b>&#160;switch record are found mostly in the Maine market. This switch produces both <i>Mobile Originating and Mobile Terminated</i>&#160;records.
      </li>
      <li>
        <b>Nortel (NTI)</b>&#160;- The <b>NORTEL NTI</b>&#160;switch record is the most common voice record format and since an NTI record contains both the <i>originating and terminating features</i>&#160;certain call types may result in a record being generated.
      </li>
      <li>
        <b>GSM Roaming</b>&#160;- Voice and data recotrds from our customers who are roaming in Europe and other <b>GSM</b>&#160;countries.
      </li>
      <li>
        <b>CIBER</b>&#160;- For <i>InCollect and OutCollect</i>&#160;processing we do not convert to <b>UFF</b>, instead the <b>CIBER</b>&#160;record format is used.
      </li>
    </ol>
    <p>
      <b>Data </b>
    </p>
    <p>
      
    </p>
    <p>
      The following switch types are first converted into the <b>UFF</b>&#160;CDR format:<br/>
    </p>
    <ol class="org-ol">
      <li>
        <b>SMSC Server</b>&#160;- Both <b>Motorola</b>&#160;and <b>Acatel-Lucent SMS</b>&#160; records that can be either a <i>Mobile Originating or Terminating</i>&#160; record type.
      </li>
      <li>
        <b>AAA Server</b>&#160;- Produces one record for each complete data session.

        <ul class="org-ul">
          <li>
            <b>PGW</b>&#160;- P-Gateway <b>LTE</b>&#160;data usage
          </li>
          <li>
            <b>ECS</b>&#160;- ECS <b>3G and lower</b>&#160;data usage.
          </li>
          <li>
            <b>AAA</b>&#160;- Raw AAA usage found on the CallDump only.
          </li>
          <li>
            <b>TAS</b>&#160;- <i>Volte</i>&#160;Voice over <b>LTE</b>.
          </li>
        </ul>
      </li>
      <li>
        <b>VALI</b>&#160;- <i>Premium SMS (Valista)</i>&#160;pre-rated records one record per event.
      </li>
      <li>
        <b>MMSC</b>&#160;- Used for both pictures and picture messaging text only (treated as an <b>SMS</b>&#160;message in the system). Produces both <i>Mobile Originating and Terminating</i>&#160;records with a possible one to many relationships (multiple recipients).<br/>
      </li>
    </ol>
    <div class="figure">
      <p>
        <img src="Pictures/usage_flow.jpg" alt="Usage Flow"/>
        
      </p>
    </div>
  </body>
</html>
</richcontent>
<hook URI="Pictures/usage_flow.jpg" SIZE="1.0" NAME="ExternalObject"/>
<node TEXT="Voice Overview" ID="sec-2-1" CREATED="1468275705062" MODIFIED="1468534460067" COLOR="#00b439">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
  <head>
    
  </head>
  <body>
    <p>
      One major undertaking in the transition to <b>TOPS</b>&#160;is moving most of the voice mediation to the <b>INTEC</b>&#160;platform. To help facilitate this move, the current rules system <b>(RBMS)</b>&#160;was studied and documented. The following provides a brief overview of the processes used.
    </p>
    <p>
      
    </p>
  </body>
</html>
</richcontent>
<node ID="sec-2-1-1" CREATED="1468275705062" MODIFIED="1468275705062" COLOR="#990000"><richcontent TYPE="NODE">

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
<li><b>Both</b> \\ <b>(NTI Mobile to Mobile)</b> in which for every voice event, two records
are created, a <b>Mobile Originated</b> and <b>Mobile Terminated</b> record.
For <b>APLX</b> this is taken care of automatically. In the case of an
<b>NTI</b> switch, depending on the call scenario, it is up to the
mediation platform to create one if needed.</li>
<li><b>Neither</b> \\ (per example <b>L-L</b> )</li>
</ul></li>
</ol>
</body>
</html>
</richcontent>
</node>
<node ID="sec-2-1-2" CREATED="1468275705062" MODIFIED="1468275705062" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Incoming - Mobile Terminated
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
An <b>Incoming</b> call is a <i>mobile terminated</i> call where one of our customers receives a call from some caller to a <b>USCC</b> switch.<br  />
<b>The diagram below shows the data flow for an incoming call:</b>\\ <br  />
</p>

<div class="figure">
<p><img src="Pictures/incoming.png" alt="incoming.png" />
</p>
</div>
</body>
</html>
</richcontent>
</node>
<node ID="sec-2-1-3" CREATED="1468275705062" MODIFIED="1468275705062" COLOR="#990000"><richcontent TYPE="NODE">

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
An <b>outgoing</b> call is a <i>mobile originating</i> call from a <b>USCC</b>
customer in which the following can occur. <br  />
<b>The diagram below shows the data flow for an outgoing call:</b> \\ <br  />
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
<node TEXT="Pre-Pay and Data Roaming" ID="sec-2-3" CREATED="1468275705066" MODIFIED="1468437592809" COLOR="#00b439">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
In addition to <b>Post-Pay</b> we also handle <b>Pre-Pay</b> which follows a different flow using the diameter interface. The <b>Diameter interface</b> is described as follows:
</p>
<ul class="org-ul">
<li><b>Diameter</b> is a <b>AAA</b> protocol, a type of computer networking
protocol for authentication, authorization and accounting, and is
a successor to <b>RADIUS</b>. <b>Diameter</b> controls communication
between the authenticator (Secure Ticket Authority, STA) and any
network entity requesting authentication. <b>Diameter Applications</b>
extend the base protocol by adding new commands and/or
attributes, such as those for use of the Extensible
Authentication Protocol (<b>EAP</b>).</li>
</ul>

<div class="figure">
<p><img src="Pictures/roamingPrePay.png" alt="roamingPrePay.png" />
</p>
</div>
</body>
</html>
</richcontent>
</node>
<node TEXT="Usage Time Zones" ID="sec-2-5" CREATED="1468275705066" MODIFIED="1468534376211" COLOR="#00b439">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
  <head>
    
  </head>
  <body>
    <table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">
      <colgroup>
      <col class="org-left"/>
      <col class="org-left"/>
      </colgroup>
      

      <tr>
        <th scope="col" class="org-left">
          <b>Usage Type</b>
        </th>
        <th scope="col" class="org-left">
          <b>TimeZone</b>
        </th>
      </tr>
      <tr>
        <td class="org-left">
          AAA
        </td>
        <td class="org-left">
          GMT
        </td>
      </tr>
      <tr>
        <td class="org-left">
          PGW/LTE
        </td>
        <td class="org-left">
          GMT
        </td>
      </tr>
      <tr>
        <td class="org-left">
          PMG/PTX
        </td>
        <td class="org-left">
          GMT
        </td>
      </tr>
      <tr>
        <td class="org-left">
          TAS
        </td>
        <td class="org-left">
          GMT
        </td>
      </tr>
      <tr>
        <td class="org-left">
          MOT/ALU
        </td>
        <td class="org-left">
          EST
        </td>
      </tr>
      <tr>
        <td class="org-left">
          Voice
        </td>
        <td class="org-left">
          Switch Location
        </td>
      </tr>
      <tr>
        <td class="org-left">
          CIBER
        </td>
        <td class="org-left">
          Switch Location
        </td>
      </tr>
      <tr>
        <td class="org-left">
          GSMD/V/S
        </td>
        <td class="org-left">
          GMT
        </td>
      </tr>
    </table>
  </body>
</html>
</richcontent>
<richcontent TYPE="DETAILS" HIDDEN="true">

<html>
  

  <head>

  </head>
  <body>
  </body>
</html>
</richcontent>
</node>
<node TEXT="Duplicate Record Keys" LOCALIZED_STYLE_REF="AutomaticLayout.level,2" ID="ID_1428891700" CREATED="1468610974079" MODIFIED="1468612252792"><richcontent TYPE="NOTE">

<html>
  <head>
    
  </head>
  <body>
    <ul>
      <li>
        MMS

        <ol>
          <li>
            Event type ID
          </li>
          <li>
            Start time
          </li>
          <li>
            Resource value
          </li>
          <li>
            Call direction
          </li>
          <li>
            Called number
          </li>
          <li>
            Calling number
          </li>
        </ol>
      </li>
    </ul>
    <ul>
      <li>
        SMS

        <ol>
          <li>
            Event type ID
          </li>
          <li>
            Start time
          </li>
          <li>
            Resource value
          </li>
          <li>
            Call direction
          </li>
          <li>
            Called number
          </li>
          <li>
            Calling number
          </li>
        </ol>
      </li>
    </ul>
    <ul>
      <li>
        Content

        <ol>
          <li>
            Event type ID
          </li>
          <li>
            Start time
          </li>
          <li>
            Resource value
          </li>
          <li>
            Content session ID
          </li>
        </ol>
      </li>
    </ul>
    <ul>
      <li>
        Voice

        <ol>
          <li>
            Event type ID
          </li>
          <li>
            Start time
          </li>
          <li>
            Resource value
          </li>
          <li>
            Call direction
          </li>
          <li>
            Surcharge indicator
          </li>
          <li>
            Air elapsed time
          </li>
          <li>
            Calling number
          </li>
        </ol>
      </li>
    </ul>
    <ul>
      <li>
        Data

        <ol>
          <li>
            Event type ID
          </li>
          <li>
            Start time
          </li>
          <li>
            Resource value
          </li>
          <li>
            Call direction
          </li>
          <li>
            Call source
          </li>
        </ol>
      </li>
    </ul>
    <p>
      &#160;
    </p>
    <ul>
      <li>
        LTE

        <ol>
          <li>
            Event type ID
          </li>
          <li>
            Start time
          </li>
          <li>
            Resource value
          </li>
          <li>
            Call direction
          </li>
          <li>
            Call source
          </li>
        </ol>
      </li>
    </ul>
    <p>
      
    </p>
  </body>
</html>
</richcontent>
</node>
<node TEXT="Guide By Criteria" ID="sec-2-4" CREATED="1468275705066" MODIFIED="1471982026928" COLOR="#00b439">
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
<node ID="sec-5-2" CREATED="1468275705082" MODIFIED="1468275705082" COLOR="#00b439"><richcontent TYPE="NODE">

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
These calls are identified as international but are charged domestic rates.
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
</body>
</html>
</richcontent>
</node>
</node>
<node POSITION="left" ID="sec-6" CREATED="1468275705083" MODIFIED="1470337133211" COLOR="#0033ff"><richcontent TYPE="NODE">

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
will be reformatted into a <i>Unified File Format</i> (<b>UFF</b>). This
format will be a standard <b>Unix/ASCII</b> formatted <b>CSV</b> file using
'|' <b>(pipe)</b> as the delimiter. 
</p>
</body>
</html>
</richcontent>
<node ID="sec-6-1" CREATED="1468275705084" MODIFIED="1468275705084" COLOR="#00b439"><richcontent TYPE="NODE">

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
<td class="org-left">Start TimeZone</td>
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
<node ID="sec-6-2" CREATED="1468275705085" MODIFIED="1468275705085" COLOR="#00b439"><richcontent TYPE="NODE">

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
<td class="org-left">Switch identifier  (See Switch Name</td>
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
<node ID="sec-6-3" CREATED="1468275705085" MODIFIED="1468275705085" COLOR="#00b439"><richcontent TYPE="NODE">

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
<td class="org-left">Switch identifier  (See Switch Name</td>
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
<node ID="sec-6-4" CREATED="1468275705085" MODIFIED="1468275705085" COLOR="#00b439"><richcontent TYPE="NODE">

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
<td class="org-left">(NTI Only)  - Automatic Roaming</td>
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
<node ID="sec-6-5" CREATED="1468275705085" MODIFIED="1468275705085" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Drop Reason Codes
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
<i>See the Drop Reasons Code spreadsheet</i>
</p>
</body>
</html>
</richcontent>
</node>
</node>
<node POSITION="right" ID="sec-5" CREATED="1468275705079" MODIFIED="1468275705079" COLOR="#0033ff"><richcontent TYPE="NODE">

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
<node ID="sec-5-1" CREATED="1468275705079" MODIFIED="1468275705079" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Ciber Record Types
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
The <b>Ciber</b> standard defines the following record Types:
</p>
<ul class="org-ul">
<li><b>01</b> Header</li>
<li><b>22</b> Voice (main Record type)</li>
<li><b>32</b> Data</li>
<li><b>52</b> One time charge</li>
<li><b>98</b> Trailer</li>
</ul>
</body>
</html>
</richcontent>
<node ID="sec-5-1-1" CREATED="1468275705079" MODIFIED="1468275705079" COLOR="#990000"><richcontent TYPE="NODE">

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
<node ID="sec-5-1-2" CREATED="1468275705079" MODIFIED="1468275705079" COLOR="#990000"><richcontent TYPE="NODE">

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
<node ID="sec-5-1-3" CREATED="1468275705081" MODIFIED="1468275705081" COLOR="#990000"><richcontent TYPE="NODE">

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
<node ID="sec-5-1-4" CREATED="1468275705081" MODIFIED="1468275705081" COLOR="#990000"><richcontent TYPE="NODE">

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
<node ID="sec-5-1-5" CREATED="1468275705082" MODIFIED="1468275705082" COLOR="#990000"><richcontent TYPE="NODE">

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
<node ID="sec-5-3" CREATED="1468275705083" MODIFIED="1468275705083" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Interfaces
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<node ID="sec-5-3-1" CREATED="1468275705083" MODIFIED="1468275705083" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Roamex/Fraudex
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
<div class="figure">
<p><img src="Pictures/NDC.png" alt="NDC.png" />
</p>
</div>
<ul class="org-ul">
<li><b>Business Process -</b> Mediation</li>
<li><b>Type -</b> Batch</li>
<li><b>Category -</b> Batch Redesign</li>
<li><b>Service -</b>   On all <b>Nortel</b> switches switch records are
copied to <b>mad1rom1</b>. Then through out the day <b>Syniverse</b>
comes in and finds all the roaming records and runs it
against there <b>Fraudx</b> application to find evidence of
fraud.</li>
<li><b>Thoughts and other random musings</b> \\ For the most part
the process is a black box and everything is handled by
<b>Syniverse</b>. The file that is sent is raw switch data and at this time
only <b>NTI (Nortel)</b> is supported. For all NDC processes the source,
compilation and processing occur on the NDC machines where
the base language is C.</li>
<li><b>Questions</b>
<ul class="org-ul">
<li class="off"><code>[&#xa0;]</code> What are the names of the NDC machines.</li>
<li class="off"><code>[&#xa0;]</code> Where is the source code kept.</li>
</ul></li>
<li><b>Contacts</b>
<ul class="org-ul">
<li>Kyle Matte</li>
<li>Roberto Amezcua</li>
</ul></li>
</ul>
</body>
</html>
</richcontent>
</node>
<node ID="sec-5-3-2" CREATED="1468275705083" MODIFIED="1468275705083" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>OutCollects
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
<div class="figure">
<p><img src="Pictures/outcoll.png" alt="outcoll.png" />
</p>
</div>
<ul class="org-ul">
<li><b>Business Process -</b> Mediation</li>
<li><b>Type -</b> Batch</li>
<li><b>Category -</b> Batch Redesign</li>
<li><b>Service -</b>  Send OutCollect data to <b>Syniverse</b>.</li>
<li><b>Process Flow</b> 
<ol class="org-ol">
<li>Switch records are passed through the billing system and any
record that does not belong to a customer gets placed into a file.</li>
<li>Twice a day the <i>Ciber_Create</i> job is run which takes these
files and converts them to CIBER records.</li>
<li>Five times a day <b>NDC</b> starts a job which sends these files to
<b>Syniverse</b>.</li>
<li>It also when it looks for CIBER files coming back from
<b>Syniverse</b> of our customers who are roaming on other networks.</li>
</ol></li>
<li><b>Thoughts and other random musings</b> \\ A pretty simple batch
interface it is here where we can use the new batch standards to
make sure the transfer is complete.</li>
<li><b>Contacts</b>
<ul class="org-ul">
<li>Kyle Matte</li>
<li>Roberto Amezcua</li>
</ul></li>
</ul>
</body>
</html>
</richcontent>
</node>
</node>
<node ID="sec-5-4" CREATED="1468275705083" MODIFIED="1512506560114" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>CIBERNET - Specification/Reference
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
<a href="https://www.one1clear.net/mxp/Login.asp">https://www.one1clear.net/mxp/Login.asp</a>
</p>
<ul class="org-ul">
<li>Mobile-X Code: USA-MPS-0001</li>
<li>Login: Skeup/SyFAGh</li>
</ul>
<pre class="example">
&lt;\\chil-data1\Share\Common\TOPS\outcollects&gt;
</pre>
</body>
</html>
</richcontent>
</node>
</node>
<node TEXT="Databases" POSITION="right" ID="sec-7" CREATED="1468275705086" MODIFIED="1470688595419" COLOR="#0033ff" TEXT_SHORTENED="true">
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>
<node TEXT="Production Database - Login/Password" LOCALIZED_STYLE_REF="AutomaticLayout.level,2" ID="ID_1901847810" CREATED="1470235332581" MODIFIED="1470235479701"><richcontent TYPE="NOTE">

<html>
  <head>
    
  </head>
  <body>
    <table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">
      <colgroup>
      <col class="org-left"/>
      <col class="org-left"/>
      <col class="org-left"/>
      <col class="org-left"/>
      </colgroup>
      

      <tr>
        <th scope="col" class="org-left">
          <b>USERNAME</b>
        </th>
        <th scope="col" class="org-left">
          <b>PASSWORD</b>
        </th>
        <th scope="col" class="org-left">
          <b>DB_INSTANCE</b>
        </th>
        <th scope="col" class="org-left">
          <b>Description</b>
        </th>
      </tr>
      <tr>
        <td class="org-left">
          PRDAFC
        </td>
        <td class="org-left">
          con8af8
        </td>
        <td class="org-left">
          PRDAF
        </td>
        <td class="org-left">
          Reference Tables
        </td>
      </tr>
      <tr>
        <td class="org-left">
          PRDCUSTC
        </td>
        <td class="org-left">
          con8cst8
        </td>
        <td class="org-left">
          PRDCUST
        </td>
        <td class="org-left">
          Customer
        </td>
      </tr>
      <tr>
        <td class="org-left">
          PRDRPLC
        </td>
        <td class="org-left">
          con8rpl8
        </td>
        <td class="org-left">
          PRDRPL
        </td>
        <td class="org-left">
          Replenishment Manager
        </td>
      </tr>
      <tr>
        <td class="org-left">
          PRDOPRC
        </td>
        <td class="org-left">
          con8opr8
        </td>
        <td class="org-left">
          PRDCUST
        </td>
        <td class="org-left">
          Operations
        </td>
      </tr>
      <tr>
        <td class="org-left">
          PRDUSG1C
        </td>
        <td class="org-left">
          con8usg18
        </td>
        <td class="org-left">
          PRDUSG1
        </td>
        <td class="org-left">
          Usage
        </td>
      </tr>
      <tr>
        <td class="org-left">
          PRDUSG2C
        </td>
        <td class="org-left">
          con8usg28
        </td>
        <td class="org-left">
          PRDUSG2
        </td>
        <td class="org-left">
          Usage
        </td>
      </tr>
      <tr>
        <td class="org-left">
          PRDUSG3C
        </td>
        <td class="org-left">
          con8usg38
        </td>
        <td class="org-left">
          PRDUSG3
        </td>
        <td class="org-left">
          Usage
        </td>
      </tr>
      <tr>
        <td class="org-left">
          PRDUSG4C
        </td>
        <td class="org-left">
          con8usg48
        </td>
        <td class="org-left">
          PRDUSG4
        </td>
        <td class="org-left">
          Usage
        </td>
      </tr>
      <tr>
        <td class="org-left">
          prdappc
        </td>
        <td class="org-left">
          Con5app5
        </td>
        <td class="org-left">
          PRDAPRM
        </td>
        <td class="org-left">
          Aprm
        </td>
      </tr>
    </table>
  </body>
</html>
</richcontent>
</node>
<node TEXT="Support Databases - Login/Password" LOCALIZED_STYLE_REF="AutomaticLayout.level,2" ID="ID_237697149" CREATED="1468275705119" MODIFIED="1470235494187">
<font NAME="SansSerif" BOLD="true"/>
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

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>USERNAME</b></th>
<th scope="col" class="org-left"><b>PASSWORD</b></th>
<th scope="col" class="org-left"><b>DB_INSTANCE</b></th>
<th scope="col" class="org-left"><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">PRDAFC</td>
<td class="org-left">PRDAFC</td>
<td class="org-left">SUPAF</td>
<td class="org-left">Reference Tables</td>
</tr>

<tr>
<td class="org-left">PRDCUSTC</td>
<td class="org-left">PRDCUSTC</td>
<td class="org-left">SUPCUST</td>
<td class="org-left">Customer</td>
</tr>

<tr>
<td class="org-left">PRDRPLC</td>
<td class="org-left">PRDRPLC</td>
<td class="org-left">SUPRPL</td>
<td class="org-left">Replenishment Manager</td>
</tr>

<tr>
<td class="org-left">PRDUSG1C</td>
<td class="org-left">PRDUSG1C</td>
<td class="org-left">SUPUSG1</td>
<td class="org-left">Usage</td>
</tr>

<tr>
<td class="org-left">PRDUSG2C</td>
<td class="org-left">PRDUSG2C</td>
<td class="org-left">SUPUSG2</td>
<td class="org-left">Usage</td>
</tr>

<tr>
<td class="org-left">PRDUSG3C</td>
<td class="org-left">PRDUSG3C</td>
<td class="org-left">SUPUSG3</td>
<td class="org-left">Usage</td>
</tr>

<tr>
<td class="org-left">PRDUSG4C</td>
<td class="org-left">PRDUSG4C</td>
<td class="org-left">SUPUSG4</td>
<td class="org-left">Usage</td>
</tr>

<tr>
<td class="org-left">PRDSELC</td>
<td class="org-left">PRDSELC</td>
<td class="org-left">SUPAPRM</td>
<td class="org-left">APRM</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node TEXT="Usage DB by cycle" ID="sec-7-1" CREATED="1468275705086" MODIFIED="1468609561700" COLOR="#00b439">
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
<td class="org-left">PRDUSG1</td>
<td class="org-left">General Cycle close on the 1st</td>
</tr>

<tr>
<td class="org-right">4</td>
<td class="org-left">PRDUSG4</td>
<td class="org-left">General Cycle close on the 3rd</td>
</tr>

<tr>
<td class="org-right">6</td>
<td class="org-left">PRDUSG4</td>
<td class="org-left">General Cycle close on the 5th</td>
</tr>

<tr>
<td class="org-right">8</td>
<td class="org-left">PRDUSG1</td>
<td class="org-left">General Cycle close on the 7th</td>
</tr>

<tr>
<td class="org-right">10</td>
<td class="org-left">PRDUSG3</td>
<td class="org-left">General Cycle close on the 9th</td>
</tr>

<tr>
<td class="org-right">12</td>
<td class="org-left">PRDUSG2</td>
<td class="org-left">General Cycle close on the 11th</td>
</tr>

<tr>
<td class="org-right">14</td>
<td class="org-left">PRDUSG4</td>
<td class="org-left">General Cycle close on the 13th</td>
</tr>

<tr>
<td class="org-right">16</td>
<td class="org-left">PRDUSG3</td>
<td class="org-left">General Cycle close on the 15th</td>
</tr>

<tr>
<td class="org-right">18</td>
<td class="org-left">PRDUSG2</td>
<td class="org-left">General Cycle close on the 17th</td>
</tr>

<tr>
<td class="org-right">20</td>
<td class="org-left">PRDUSG1</td>
<td class="org-left">General Cycle close on the 19th</td>
</tr>

<tr>
<td class="org-right">22</td>
<td class="org-left">PRDUSG2</td>
<td class="org-left">General Cycle close on the 21st</td>
</tr>

<tr>
<td class="org-right">24</td>
<td class="org-left">PRDUSG3</td>
<td class="org-left">General Cycle close on the 23rd</td>
</tr>

<tr>
<td class="org-right">26</td>
<td class="org-left">PRDUSG4</td>
<td class="org-left">General Cycle close on the 25th</td>
</tr>

<tr>
<td class="org-right">28</td>
<td class="org-left">PRDUSG3</td>
<td class="org-left">General Cycle close on the 27th</td>
</tr>

<tr>
<td class="org-right">77</td>
<td class="org-left">PRDUSG1</td>
<td class="org-left">Dropped events cycle</td>
</tr>

<tr>
<td class="org-right">80</td>
<td class="org-left">PRDUSG3</td>
<td class="org-left">Rejected events cycle</td>
</tr>

<tr>
<td class="org-right">99</td>
<td class="org-left">PRDUSG2</td>
<td class="org-left">Reserved for OutCollect Cycle close on the 31th</td>
</tr>

<tr>
<td class="org-right">1002</td>
<td class="org-left">PRDUSG2</td>
<td class="org-left">Reseller Cycle close on the 1st</td>
</tr>

<tr>
<td class="org-right">1004</td>
<td class="org-left">PRDUSG1</td>
<td class="org-left">Reseller Cycle close on the 3rd</td>
</tr>

<tr>
<td class="org-right">1006</td>
<td class="org-left">PRDUSG1</td>
<td class="org-left">Reseller Cycle close on the 5th</td>
</tr>

<tr>
<td class="org-right">1008</td>
<td class="org-left">PRDUSG3</td>
<td class="org-left">Reseller Cycle close on the 7th</td>
</tr>

<tr>
<td class="org-right">1010</td>
<td class="org-left">PRDUSG2</td>
<td class="org-left">Reseller Cycle close on the 9th</td>
</tr>

<tr>
<td class="org-right">1012</td>
<td class="org-left">PRDUSG4</td>
<td class="org-left">Reseller Cycle close on the 11th</td>
</tr>

<tr>
<td class="org-right">1014</td>
<td class="org-left">PRDUSG1</td>
<td class="org-left">Reseller Cycle close on the 13th</td>
</tr>

<tr>
<td class="org-right">1016</td>
<td class="org-left">PRDUSG2</td>
<td class="org-left">Reseller Cycle close on the 15th</td>
</tr>

<tr>
<td class="org-right">1018</td>
<td class="org-left">PRDUSG4</td>
<td class="org-left">Reseller Cycle close on the 17th</td>
</tr>

<tr>
<td class="org-right">1020</td>
<td class="org-left">PRDUSG3</td>
<td class="org-left">Reseller Cycle close on the 19th</td>
</tr>

<tr>
<td class="org-right">1022</td>
<td class="org-left">PRDUSG3</td>
<td class="org-left">Reseller Cycle close on the 21st</td>
</tr>

<tr>
<td class="org-right">1024</td>
<td class="org-left">PRDUSG1</td>
<td class="org-left">Reseller Cycle close on the 23rd</td>
</tr>

<tr>
<td class="org-right">1026</td>
<td class="org-left">PRDUSG4</td>
<td class="org-left">Reseller Cycle close on the 25th</td>
</tr>

<tr>
<td class="org-right">1028</td>
<td class="org-left">PRDUSG2</td>
<td class="org-left">Reseller Cycle close on the 27th</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node TEXT="DB Preparation" ID="sec-7-2" CREATED="1468275705086" MODIFIED="1468610308846" COLOR="#00b439">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
For each DB instance, except ODS and SIT, You need to alter the session before you can use it.\\ For example  for usage 1 type
</p>
<pre class="example">
ALTER SESSION SET CURRENT_SCHEMA=PRDUSG1C
</pre>
<p>
\newpage
</p>
</body>
</html>
</richcontent>
</node>
<node TEXT="Production Database Tables" ID="sec-7-4" CREATED="1468275705087" MODIFIED="1512505985228" COLOR="#00b439">
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
<th scope="col" class="org-left"><b>Table Name</b></th>
<th scope="col" class="org-left">Database*</th>
<th scope="col" class="org-left">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left"><b>AC1_CONTROL</b></td>
<td class="org-left">PRDCUST</td>
<td class="org-left">Check both PRDCUST</td>
</tr>

<tr>
<td class="org-left"><b>AC1_CONTROL_HIST</b></td>
<td class="org-left">PRDAF</td>
<td class="org-left">and PRDAF</td>
</tr>

<tr>
<td class="org-left">SERVICE_AGREEMENT</td>
<td class="org-left">PRDCUST</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CSM_OFFER</td>
<td class="org-left">PRDCUST</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SUBSCRIBER</td>
<td class="org-left">PRDCUST</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>CM1_AGREEMENT_PARAM</b></td>
<td class="org-left">PRDCUST</td>
<td class="org-left">Used for data</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">cap issues.</td>
</tr>

<tr>
<td class="org-left"><b>APE1_RATED_EVENT</b></td>
<td class="org-left">PRDUSG(1-4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APE1_REJECTED_EVENT</td>
<td class="org-left">PRDUSG(1-4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>APE1_ACCUMULATORS</b></td>
<td class="org-left">PRDUSG(1-4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>AC_PHYSICAL_FILES</b></td>
<td class="org-left">PRDUSG(1-4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>AC_SOURCE</b></td>
<td class="org-left">PRDCUST</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>AGD1_RESOURCES</b></td>
<td class="org-left">PRDAF</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ADJ1_CYCLE_STATE</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APR1_NOTIFICATIONS_CTL</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AUH1_CTRL</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APE1_SUBSCRIBER_RERATE</td>
<td class="org-left">PRDUSG(1-4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APE1_SUBSCR_DATA</td>
<td class="org-left">PRDUSG(1-4)</td>
<td class="org-left"><i>See the BPT</i></td>
</tr>

<tr>
<td class="org-left"><b>APE1_SUBSCR_OFFERS</b></td>
<td class="org-left">PRDUSG(1-4)</td>
<td class="org-left"><i>for the definition</i></td>
</tr>

<tr>
<td class="org-left">APE1_SUBSCR_PARAMS</td>
<td class="org-left">PRDUSG(1-4)</td>
<td class="org-left"><i>of these tables</i></td>
</tr>

<tr>
<td class="org-left">APE1_CUST_CYCLE_HISTORY</td>
<td class="org-left">PRDUSG(1-4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APE3_EPCEXT_OFFER_DETAILS</td>
<td class="org-left">PRDCUST</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
<node ID="sec-7-4-1" CREATED="1468275705087" MODIFIED="1468275705087" COLOR="#990000"><richcontent TYPE="NODE">

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
In the PRDCUST database used for data cap and overage protection investigations.
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Name</th>
<th scope="col" class="org-left">Data Type</th>
<th scope="col" class="org-left">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">AGREEMENT_KEY</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AGREEMENT_NO</td>
<td class="org-left">NUMBER (10)</td>
<td class="org-left">Is equal to the</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">subscriber number</td>
</tr>

<tr>
<td class="org-left">PARAM_SEQ_NO</td>
<td class="org-left">NUMBER (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PARAM_NAME</td>
<td class="org-left">VARCHAR2 (255 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PARAM_VALUES</td>
<td class="org-left">VARCHAR2 (4000 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EFFECTIVE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EXPIRATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AGR_LEVEL</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SOURCE_AGR_NO</td>
<td class="org-left">NUMBER (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TRX_ID</td>
<td class="org-left">NUMBER (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">INS_TRX_ID</td>
<td class="org-left">NUMBER (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EFF_ISSUE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EXP_ISSUE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CONV_RUN_NO</td>
<td class="org-left">NUMBER (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OFFER_INSTANCE_ID</td>
<td class="org-left">NUMBER (10)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-4-2" CREATED="1468275705087" MODIFIED="1468275705087" COLOR="#990000"><richcontent TYPE="NODE">

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
Similar to <b>ac_processing_accounting</b> there are two tables with the same name but in different databases, <b>PRDAF</b> (Usage) and <b>PRDCUST</b> (AR). 
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
<td class="org-left"><b>IDENTIFIER</b></td>
<td class="org-left">NUMBER(15,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR(6 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>FILE_NAME</b></td>
<td class="org-left">VARCHAR2(200 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>FILE_PATH</b></td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FILE_SEQ_NO</td>
<td class="org-left">NUMBER(6,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">HOST_NAME</td>
<td class="org-left">VARCHAR2(50 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DATA_GROUP</td>
<td class="org-left">VARCHAR2(64 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FILE_CREATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>FILE_STATUS</b></td>
<td class="org-left">VARCHAR2(2 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>ORIGIN_FILE_IDENT</b></td>
<td class="org-left">NUMBER(15,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>PHY_FILE_IDENT</b></td>
<td class="org-left">NUMBER(15,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CUR_PGM_NAME</td>
<td class="org-left">VARCHAR2(32 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CUR_FILE_ALIAS</td>
<td class="org-left">VARCHAR2(10 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">NXT_PGM_NAME</td>
<td class="org-left">VARCHAR2(32 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">NXT_FILE_ALIAS</td>
<td class="org-left">VARCHAR2(10 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FILE_FORMAT</td>
<td class="org-left">VARCHAR2(10 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FILE_GROUP</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FILE_TYPE</td>
<td class="org-left">CHAR(2 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REPRO_IND</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SOURCE_TYPE</td>
<td class="org-left">CHAR(10 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SOURCE_FILE_TYPE</td>
<td class="org-left">CHAR(10 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FILE_DELETED_IND</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYSTEM_ID</td>
<td class="org-left">CHAR(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ABP_VAR</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PRIORITY</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">WR_REC_QUANTITY</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">WR_TIME_QUANTITY</td>
<td class="org-left">NUMBER(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">WR_MONEY_QUANTITY</td>
<td class="org-left">NUMBER(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">WR_EURO_QUANTITY</td>
<td class="org-left">NUMBER(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">IN_REC_QUANTITY</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">IN_TIME_QUANTITY</td>
<td class="org-left">NUMBER(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">IN_MONEY_QUANTITY</td>
<td class="org-left">NUMBER(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">IN_EURO_QUANTITY</td>
<td class="org-left">NUMBER(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">GN_REC_QUANTITY</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">GN_TIME_QUANTITY</td>
<td class="org-left">NUMBER(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">GN_MONEY_QUANTITY</td>
<td class="org-left">NUMBER(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">GN_EURO_QUANTITY</td>
<td class="org-left">NUMBER(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DR_REC_QUANTITY</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DR_TIME_QUANTITY</td>
<td class="org-left">NUMBER(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DR_MONEY_QUANTITY</td>
<td class="org-left">NUMBER(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DR_EURO_QUANTITY</td>
<td class="org-left">NUMBER(13,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PROCESSED_REC_NO</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REJECTED_REASON_CD</td>
<td class="org-left">CHAR(3 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OWNER_NAME</td>
<td class="org-left">VARCHAR2(50 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TABLE_ALIAS</td>
<td class="org-left">NUMBER(5,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">NXT_PROCESS_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">NXT_PROCESS_START_TIME</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CUR_PROCESS_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MAX_EVENT_TIME</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">LOGICAL_FILE_IDENT</td>
<td class="org-left">NUMBER(15,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TABLE_ISSUE_CODE</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EXTERNAL_ID</td>
<td class="org-left">VARCHAR2(32 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DEST_ROUT_CRTRIA</td>
<td class="org-left">VARCHAR2(24 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">STATUS_CATEGORY</td>
<td class="org-left">VARCHAR2(20 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">STATUS_CODE</td>
<td class="org-left">VARCHAR2(200 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_CODE</td>
<td class="org-left">VARCHAR2(50 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FILE_SIZE</td>
<td class="org-left">NUMBER(15,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">RECYCLE_COUNTER</td>
<td class="org-left">NUMBER(15,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">GROUP_SEQUENCE</td>
<td class="org-left">NUMBER(15,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OUT_REQ_QUANTITY</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BULK_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">STORE_MODE</td>
<td class="org-left">CHAR(2 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SESSION_ID</td>
<td class="org-left">NUMBER(15,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TARGET_FILE_PATH</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TARGET_HOST</td>
<td class="org-left">VARCHAR2(50 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EXT_IDENTIFIER</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EXT_ORIG_IDENT</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ADDITIONAL_ATTR</td>
<td class="org-left">VARCHAR2(300 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">GROUP_SIZE</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MONITOR_DATA</td>
<td class="org-left">VARCHAR2(50 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">WR_VOLUME_QUANTITY</td>
<td class="org-left">NUMBER(15,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">IN_VOLUME_QUANTITY</td>
<td class="org-left">NUMBER(15,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">GN_VOLUME_QUANTITY</td>
<td class="org-left">NUMBER(15,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DR_VOLUME_QUANTITY</td>
<td class="org-left">NUMBER(15,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">END_PROCESS_TIME</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FR_TIME</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ENG_PRIORITY</td>
<td class="org-left">NUMBER(1,0)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-4-3" CREATED="1468275705088" MODIFIED="1468275705088" COLOR="#990000"><richcontent TYPE="NODE">

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
<td class="org-left"><b>CYCLE_CODE</b></td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">See usage DB by Cycle</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">for complete list.</td>
</tr>

<tr>
<td class="org-left"><b>CYCLE_INSTANCE</b></td>
<td class="org-left">NUMBER (2)</td>
<td class="org-left">cycle month</td>
</tr>

<tr>
<td class="org-left">CUSTOMER_SEGMENT</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>CUSTOMER_ID</b></td>
<td class="org-left">NUMBER (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EVENT_ID</td>
<td class="org-left">NUMBER (18)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>SUBSCRIBER_ID</b></td>
<td class="org-left">NUMBER (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">START_TIME</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>EVENT_TYPE_ID</b></td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">The event type</td>
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
<td class="org-left">LTE - 69</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">SMS - 54</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">MMS - 60</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Volte - 69</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left"><i>See wiki table</i></td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left"><i>for complete list</i></td>
</tr>

<tr>
<td class="org-left">TARGET_CYCLE_CODE</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CYCLE_YEAR</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BILLING_ARRANGEMENT</td>
<td class="org-left">NUMBER (18)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SOURCE_ID</td>
<td class="org-left">NUMBER (15)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EVENT_STATE</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">X = Stripped</td>
</tr>

<tr>
<td class="org-left">EVENT_STATE_REASON_CODE</td>
<td class="org-left">CHAR (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">RERATE_TYPE</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ORIGINAL_EVENT_ID</td>
<td class="org-left">NUMBER (18)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">RESOURCE_VALUE</td>
<td class="org-left">VARCHAR2 (63 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>RESOURCE_TYPE</b></td>
<td class="org-left">VARCHAR2 (16 Byte)</td>
<td class="org-left">0  - MDN</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">19 - MIN</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">21 - OutCollects</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">23 - imsi</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">UPDATE_ID</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">VERSION_ID</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">NETWORK_START_TIME</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EVENT_STATUS</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EVENT_COUNTERS</td>
<td class="org-left">NUMBER (20)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TOKEN_ID</td>
<td class="org-left">NUMBER (20)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_ACCOUNT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_ADDITIONAL_CHG_AMT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_AIRTIME_CHG_AMT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_BASIC_SERVICE_CODE</td>
<td class="org-left">VARCHAR2 (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L3_CALLING_COUNTRY_CODE</b></td>
<td class="org-left">VARCHAR2 (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L3_CALL_CATEGORY</b></td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">Volte = 'V'</td>
</tr>

<tr>
<td class="org-left"><b>L3_CALL_DIRECTION</b></td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">1 = incoming</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">2 = outgoing</td>
</tr>

<tr>
<td class="org-left">L3_CALL_SOURCE</td>
<td class="org-left">VARCHAR2 (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L3_CHARGE_AMOUNT</b></td>
<td class="org-left">NUMBER</td>
<td class="org-left">The amount charged</td>
</tr>

<tr>
<td class="org-left">L3_CHARGE_CODE</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_CHG_AMT_INC_FREE_ALLOW</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_CUSTOMER_OFFER_CURRENCY</td>
<td class="org-left">VARCHAR2 (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_DISCOUNT_AMOUNT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L3_DURATION</b></td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L3_IMSI</b></td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L3_OFFER_ID</b></td>
<td class="org-left">NUMBER</td>
<td class="org-left">The price plan</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">the event was</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">rated against.</td>
</tr>

<tr>
<td class="org-left">L3_ORIGINAL_CHARGE_AMOUNT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_PAYMENT_CATEGORY</td>
<td class="org-left">VARCHAR2 (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_PAY_CHANNEL</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L3_PHYSICAL_FILE_ID</b></td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_PRICING_ITEM_ID</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_ROUNDED_UNIT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_SPECIAL_NUMBER_GROUP</td>
<td class="org-left">VARCHAR2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_STARTING_PERIOD</td>
<td class="org-left">VARCHAR2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_TARGET_CUSTOMER_ID</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_UNAPPLIED_AMOUNT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_UOM</td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_VOLUME</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>SERVICE_FILTER</b></td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CALL_TAX_INDICATOR</td>
<td class="org-left">VARCHAR2 (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ORIGINATING_CELL_ID</td>
<td class="org-left">VARCHAR2 (16 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_NUMBER_OF_RECIPIENTS</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CROSS_TOLL_PERIOD_IND</td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CHARGE_TYPE</td>
<td class="org-left">VARCHAR2 (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_FILE_NUMBER</td>
<td class="org-left">VARCHAR2 (24 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_AIR_TAX</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_SURCHARGE_INDICATOR</td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_SPECIAL_FEATURES_USED</td>
<td class="org-left">VARCHAR2 (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ORIGINAL_TOLL_CHARGE</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_CALLED_NUMBER</b></td>
<td class="org-left">VARCHAR2 (256 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ORIGINATING_CATEGORY</td>
<td class="org-left">VARCHAR2 (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_VOLUME_TYPE</td>
<td class="org-left">VARCHAR2 (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_TOLL_TYPE_INDICATOR</td>
<td class="org-left">VARCHAR2 (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ORIGINAL_ADD_CHRG_AMT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_TERMINATION_REASON</td>
<td class="org-left">VARCHAR2 (8 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_TOLL_CHRG_AMT_INC_ALWNCE</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_AIR_RERATE_IND</td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_NETWORK_FLAG</td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_CALLED_PLACE</b></td>
<td class="org-left">VARCHAR2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_SURCHARGE_TYPE</td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_SPECIAL_NUMBER_TYPE</td>
<td class="org-left">VARCHAR2 (32 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_PERIOD_NAME</td>
<td class="org-left">VARCHAR2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CORRELATION_ID</td>
<td class="org-left">VARCHAR2 (14 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ADDITIONAL_RATE_OFFER_ID</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CROSS_PERIOD_IND</td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_PRICE_PLAN_OFFER_ID</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_TOLL_RERATE_IND</td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_SERVING_PLACE</td>
<td class="org-left">VARCHAR2 (26 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ORIGINAL_TAX</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_TOLL_OFFER_INSTANCE</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_TERMINATING_CELL_ID</td>
<td class="org-left">VARCHAR2 (16 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_VISITOR_INDICATOR</td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_BAND_CODE</b></td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_VALIDITY_TIME</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_TOLL_OFFER_ID</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ROUNDED_TOLL_DURATION</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_CARRIER_ID</b></td>
<td class="org-left">VARCHAR2 (16 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_SPECIAL_NUMBER</td>
<td class="org-left">VARCHAR2 (32 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_TOLL_CHARGE_AMOUNT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_TOLL_DURATION</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_AIR_TIME_IND</td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_EVENT_TYPE_NAME</td>
<td class="org-left">VARCHAR2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_RECORD_SEQUENCE_NUMBER</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_SERVE_SID</b></td>
<td class="org-left">VARCHAR2 (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_DOWNLINK_VOLUME</b></td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_CALLING_NUMBER</b></td>
<td class="org-left">VARCHAR2 (256 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CALL_COMPLETION_CODE</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_UPLINK_VOLUME</b></td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_DIALED_DIGITS</b></td>
<td class="org-left">VARCHAR2 (32 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_TOLL_RATE_CLASS</td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_EHA_INDICATOR</td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_RING_TIME</b></td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_TOLL_TAX</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CURRENCY_TYPE</td>
<td class="org-left">VARCHAR2 (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CALLING_STATE</td>
<td class="org-left">VARCHAR2 (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_TOLL_ITEM_ID</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CUSTOMER_SUB_TYPE</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_APPLICATION_ID</b></td>
<td class="org-left">VARCHAR2 (64 Byte)</td>
<td class="org-left">Used for Brew</td>
</tr>

<tr>
<td class="org-left">L9_ORIG_TRANS_ID</td>
<td class="org-left">VARCHAR2 (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_CALL_ANSWERED_INDICATOR</b></td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_DESTINATION_CATEGORY</td>
<td class="org-left">VARCHAR2 (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_SURCHARGE_AMOUNT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_DESTINATION_STATE_CODE</td>
<td class="org-left">VARCHAR2 (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_REDIRECT_NUMBER</td>
<td class="org-left">VARCHAR2 (32 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_TOLL_CHARGE_CODE</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CUSTOMER_TYPE</td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_HOME_SID</b></td>
<td class="org-left">VARCHAR2 (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_STARTING_CALL_TOLL_PERIOD</td>
<td class="org-left">VARCHAR2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CALLED_COUNTRY</td>
<td class="org-left">VARCHAR2 (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_AIR_ELAPSED_TIME</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_ORIGINATING_ADDRESS</b></td>
<td class="org-left">VARCHAR2 (26 Byte)</td>
<td class="org-left">Orig Address from UFF</td>
</tr>

<tr>
<td class="org-left">L9_ADDITIONAL_CHARGE_TAX</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_DESTINATION_CITY_NAME</td>
<td class="org-left">VARCHAR2 (30 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_MEDIA_TYPE</td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_TOLL_PERIOD_NAME</td>
<td class="org-left">VARCHAR2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_CALL_TYPE</b></td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">1 = International</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">L= Local (SMS Only)</td>
</tr>

<tr>
<td class="org-left">L9_RERATE_INDICATOR</td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_NT_ROAMING_IND</td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_OFFER_INSTANCE</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_DAILY_SURCHARGE_IND</td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_INCOLLECT_INDICATOR</b></td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">If true then its</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">an InCollect.</td>
</tr>

<tr>
<td class="org-left">L9_SESSION_IDENTIFIER</td>
<td class="org-left">VARCHAR2 (128 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_FREE_UNIT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_EXT_TRX_ID</td>
<td class="org-left">VARCHAR2 (18 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_ROAMING_IND</b></td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">Used for Data</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">2 = Roaming</td>
</tr>

<tr>
<td class="org-left">L9_BALANCE_EXP_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ORIG_ADDITIONAL_CHG_TAX</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_METHOD</td>
<td class="org-left">VARCHAR2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_RECHARGE_ID</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ANNOUNCEMENT_PARAM</td>
<td class="org-left">VARCHAR2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_REASON</td>
<td class="org-left">VARCHAR2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ACTIVITY_AMOUNT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CHANNEL</td>
<td class="org-left">VARCHAR2 (100 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_BLOCKED_NUMBER_IND</td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_REMAINING_BALANCE_AMT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_MIN</b></td>
<td class="org-left">VARCHAR2 (10 Byte)</td>
<td class="org-left">MSID</td>
</tr>

<tr>
<td class="org-left"><b>L9_EQUIPMENT_ID</b></td>
<td class="org-left">VARCHAR2 (32 Byte)</td>
<td class="org-left">PostPaid = ESN</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">PrePaid = 0</td>
</tr>

<tr>
<td class="org-left">L9_THRESHOLD_AMOUNT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_SERVICE_FEATURE</b></td>
<td class="org-left">VARCHAR2 (128 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ORIGINAL_AIR_TIME_CHG_AMT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_BE</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CHARG_BEYOND_CAP</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_IS_ONLINE</b></td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">Y = <b>Pre-Pay</b></td>
</tr>

<tr>
<td class="org-left">L9_VOLUME_PER_TYPE</td>
<td class="org-left">VARCHAR2 (512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_UNITS_BEYOND_CAP</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_VOLUME_COMPLEX</td>
<td class="org-left">VARCHAR2 (512 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_M2M_IND</b></td>
<td class="org-left">VARCHAR2 (2 Byte)</td>
<td class="org-left">Mobile to Mobile</td>
</tr>

<tr>
<td class="org-left">L9_BALANCE_AMOUNT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CALLING_AREA_NAME</td>
<td class="org-left">VARCHAR2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_TOLL_FREE_IND</b></td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">Y = Toll Free</td>
</tr>

<tr>
<td class="org-left"><b>L9_PARTNER_ID</b></td>
<td class="org-left">VARCHAR2 (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_EXT_REF_ID</td>
<td class="org-left">VARCHAR2 (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CAMPAIGN_ID</td>
<td class="org-left">VARCHAR2 (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_APPLICATION_TYPE</td>
<td class="org-left">VARCHAR2 (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_APPLICATION_DESCRIPTION</td>
<td class="org-left">VARCHAR2 (193 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CHARGE_CODE_DESCRIPTION</td>
<td class="org-left">VARCHAR2 (193 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_SYSTEM_SERVICE</td>
<td class="org-left">VARCHAR2 (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_INITIATOR_ID</td>
<td class="org-left">VARCHAR2 (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ADJ_REASON_CD</td>
<td class="org-left">VARCHAR2 (64 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_INITIATOR_TYPE</td>
<td class="org-left">VARCHAR2 (19 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-4-4" CREATED="1468275705089" MODIFIED="1468275705089" COLOR="#990000"><richcontent TYPE="NODE">

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
<th scope="col" class="org-left">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left"><b>CYCLE_CODE</b></td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>CYCLE_INSTANCE</b></td>
<td class="org-left">NUMBER(2,0)</td>
<td class="org-left">Cycle Instance = 0</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Pre-Paid Subscriber</td>
</tr>

<tr>
<td class="org-left">CUSTOMER_SEGMENT</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>CUSTOMER_ID</b></td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>ACCUM_TYPE_ID</b></td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OWNER_ID</td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OWNER_TYPE</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ITEM_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OFFER_INSTANCE</td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DIMENSION_ID</td>
<td class="org-left">NUMBER(5,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>CYCLE_YEAR</b></td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR(6 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">UPDATE_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">VERSION_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">GLOBAL_ACCUM_IND</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CROSS_CYCLE_IND</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>ACCUM_ID</b></td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">RERATE_TYPE</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ACCOUNT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>ACCUM_CHARGE</b></td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>ACCUM_CHG_INCL_FREE_ALLW</b></td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>ACCUM_FREE_UNIT</b></td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>ACCUM_UNIT</b></td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BILLING_ARRANGEMENT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>CURRENCY_CODE</b></td>
<td class="org-left">VARCHAR2(3 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FIRST_EVENT_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_BALANCE_AMOUNT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_BALANCE_STATUS</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">LAST_EVENT_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>NUMBER_OF_EVENTS</b></td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>NUMBER_OF_FREE_EVENTS</b></td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>NUMBER_OF_ROLLED_CYCLES</b></td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OFFER_ID</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PI_ROLE</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PI_STATUS</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">QUOTA</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">QUOTA_PER_PERIOD</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REMAINING_QUOTA_PER_PERIOD</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REMAIN_QUOTA_PER_MONTH_PERIOD</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ROLLED_PREVIOUS_CYC_PER_PERIOD</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ROLLED_QUOTA_FROM_PREVIOUS_CYC</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">UOM</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">UTILIZED_QUOTA_PER_PERIOD</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">UTILIZE_QUOTA_PER_MONTH_PERIOD</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BILLING_RESOURCE_TYPE</td>
<td class="org-left">VARCHAR2(16 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BILLING_RESOURCE_ID</td>
<td class="org-left">VARCHAR2(63 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TOLL_TAX</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ACCUM_CHG_INCL_ALLW_CMPLX</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ACCUM_CREDIT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ACCUMULATED_CHG_CMPLX</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_OVERAGE_CAP</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ACCUM_FREE_UNIT_CMPLX</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_NUMBER_OF_EVENTS_CMPLX</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_NUMBER_FREE_EVENTS_CMPLX</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ACCUM_UNIT_CMPLX</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CAP_EXCEED</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_NUMBER_OF_CREDIT_EVENTS</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AIR_TAX</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_TOT_UNITS_ABOVE_CAP</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ACCUM_DURATION</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CALL_DIRECTION</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ROAMING_IND</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_TAX_CHANGE_DATE</td>
<td class="org-left">VARCHAR2(25 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_SERVE_SID</td>
<td class="org-left">VARCHAR2(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_EHA_INDICATOR</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_PAY_CHANNEL</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CUSTOMER_SUB_TYPE</td>
<td class="org-left">VARCHAR2(15 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_BE</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CUSTOMER_TYPE</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CALLED_COUNTRY</td>
<td class="org-left">VARCHAR2(3 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_PAYMENT_CATEGORY</b></td>
<td class="org-left">VARCHAR2(4 BYTE)</td>
<td class="org-left">POST or PRE</td>
</tr>

<tr>
<td class="org-left">L9_BILLING_ARRANGEMENT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_VOLUME_ACCUMULATION</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_OFFER_LEVEL</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_FULL_CAP</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CHARGE_TYPE</td>
<td class="org-left">VARCHAR2(3 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_PREV_ADD_CHG_CMPLX2</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_PREV_ADD_CHG_CMPLX1</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_PREV_ADD_CHG_CMPLX3</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_PREV_ADD_CHG_CMPLX</td>
<td class="org-left">VARCHAR2(4000 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ACC_USAGE_BEFORE_EOM</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ACC_USAGE_AFTER_EOM</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_MSISDN</td>
<td class="org-left">VARCHAR2(256 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CAP_TO_BE_USED</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CHARGE_CODE</td>
<td class="org-left">VARCHAR2(15 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_OFFER_TYPE</td>
<td class="org-left">VARCHAR2(255 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ACCUM_CHG_BEYO_CAP_CMPLX</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_CTN</b></td>
<td class="org-left">VARCHAR2(10 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_MEDIA_TYPE</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_UTILIZED_QUOTA_CMPLX</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_FIRST_THRESHOLD_SENT_IND</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_REMAIN_QUOTA_CMPLX</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_USED_QUOTA</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_LAST_THRESHOLD_SENT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CHARGE_REV_CODE</td>
<td class="org-left">VARCHAR2(2 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_IS_NEW_SCALE</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_IS_FIRST_NOTIF</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_NOTIFIED_CTN</td>
<td class="org-left">VARCHAR2(32 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_UNLIMITED_IND</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PRORATION_FACTOR</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CURR_LEG</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_NUM_OF_PERIOD</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_IS_NOTIF_SENT</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_PERIOD_NAME</td>
<td class="org-left">VARCHAR2(255 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_VOLUME_PER_LEG</td>
<td class="org-left">VARCHAR2(4000 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CYCLE_START_DATE_CMPLX</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DISABLE_NOTIF_IND</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_NOTIF_ELIG</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_IS_SECOND_NOTIF</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_LIMIT_QUOTA_CHANGE_CMPLX</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AGR_LEVEL_OFFER_INST</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_LAST_NOTIF_INDEX</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_SECOND_NOTIF_THRESH</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OFFER_EXP_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_SECOND_THRESHOLD</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ACCUM_FREE_UNTS_BEYO_CAP</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OFFER_EFF_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_FIRST_THRESHOLD</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_SECOND_THRESHOLD_SENT_IND</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_LIMIT_QUOTA_CMPLX</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_FIRST_NOTIF_THRESH</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_REMAINING_BUCKET</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CLASS_CODE</td>
<td class="org-left">VARCHAR2(12 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_IVR_ANN_CODE</td>
<td class="org-left">VARCHAR2(50 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ACCUM_ADD_TAX_AMT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ACCUM_TAX_AMT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_DAYS_OF_DAILY_DATA</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CALLING_AREA_NAME</td>
<td class="org-left">VARCHAR2(50 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EXPIRATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_DISCLAIMER_SENT</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_IS_ROAM_DATA_SPEED_NOTIF</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_GEOCODE</td>
<td class="org-left">VARCHAR2(10 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_IS_TOTAL_DATA_SPEED_NOTIF</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ROAM_VOLUME_ACCUMULATION</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ROAM_SPEED_LIMIT</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_INDICATOR</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CHARGE_ACCUMULATION</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_PP_CHANGED_IND</td>
<td class="org-left">VARCHAR2(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_FIRST_LEVEL</td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_GRP_LEVEL_OFFER_INST</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_GROUP_OFFER_ID</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-4-5" CREATED="1468275705090" MODIFIED="1468275705090" COLOR="#990000"><richcontent TYPE="NODE">

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
<th scope="col" class="org-left">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">RESOURCE_SEGMENT</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">RESOURCE_VALUE</td>
<td class="org-left">VARCHAR2(63 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>RESOURCE_TYPE</b></td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">0 - MDN</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">19 - MIN</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">21 - OutCollects</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">23 - TIMSI</td>
</tr>

<tr>
<td class="org-left">EFFECTIVE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR(6 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">UPDATE_ID</td>
<td class="org-left">NUMBER(18,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EXPIRATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>SUBSCRIBER_ID</b></td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SUB_STATUS</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ROUTING_POLICY_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PAYMENT_CATEGORY</td>
<td class="org-left">CHAR(4 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>CUSTOMER_ID</b></td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BILL_CYCLE</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">NEW_BILL_CYCLE</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CHG_CYC_REQ_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">LARGE_CUST_IND</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">RESOURCE_HASH_VALUE</td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SUBSCRIBER_HASH_VALUE</td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">LOAD_IND</td>
<td class="org-left">CHAR(1 BYTE)</td>
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
<node ID="sec-7-4-6" CREATED="1468275705098" MODIFIED="1468275705098" COLOR="#990000"><richcontent TYPE="NODE">

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
Provides information for the physical files that were processed 
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
<td class="org-left"><b>IDENTIFIER</b></td>
<td class="org-left">NUMBER(15,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR(6 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>FILE_NAME</b></td>
<td class="org-left">VARCHAR2(200 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">HOST_NAME</td>
<td class="org-left">VARCHAR2(50 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>FILE_PATH</b></td>
<td class="org-left">VARCHAR2(512 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SERIAL_NUMBER</td>
<td class="org-left">VARCHAR2(8 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYSTEM_RCV_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FSRC_SRC_TYPE</td>
<td class="org-left">CHAR(10 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FSRC_TYPE_ID</td>
<td class="org-left">CHAR(10 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">RCRDNG_START_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">RCRDNG_END_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>TRLR_RECORD_COUNT</b></td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TRLR_BLOCK_COUNT</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TRLR_L_FILE_COUNT</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PGM_L_FILE_COUNT</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PGM_TRACER_IND</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DUPL_ENTRY_IND</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ENTRY_STATUS</td>
<td class="org-left">CHAR(2 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OLD_AGE_IND</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">END_OF_TREE_SEQ</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>BALANCE_DATE</b></td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-4-7" CREATED="1468275705098" MODIFIED="1468275705098" COLOR="#990000"><richcontent TYPE="NODE">

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
<th scope="col" class="org-left">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">SOURCE_TYPE</td>
<td class="org-left">CHAR(10 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>FILE_TYPE</b></td>
<td class="org-left">CHAR(10 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SWITCH_ID</td>
<td class="org-left">VARCHAR2(32 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR(6 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FILE_SEQ_NO</td>
<td class="org-left">NUMBER(6,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MAX_FILE_SEQ_NO</td>
<td class="org-left">NUMBER(6,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MAX_TIME</td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MIN_TIME</td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">LAST_CYCLE_PROCD</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">NEXT_CYCLE_EXPECT</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">STATUS_IND</td>
<td class="org-left">CHAR(2 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DUPL_ENTRY_IND</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">HO_FROM_TIME</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">HO_FROM_SEQ</td>
<td class="org-left">NUMBER(6,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DAYS_BFR_PHY_CLN</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">GAP_PERMITTED</td>
<td class="org-left">NUMBER(6,0)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-4-8" CREATED="1468275705098" MODIFIED="1468275705098" COLOR="#990000"><richcontent TYPE="NODE">

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
Customers in this table are scheduled to be re-rated. Then they should be removed once re-rating is complete.
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
<td class="org-left"><b>CYCLE_CODE</b></td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CYCLE_INSTANCE</td>
<td class="org-left">NUMBER (2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CUSTOMER_SEGMENT</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>CUSTOMER_ID</b></td>
<td class="org-left">NUMBER (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>SUBSCRIBER_ID</b></td>
<td class="org-left">NUMBER (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CYCLE_YEAR</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">RERATE_SOURCE</td>
<td class="org-left">VARCHAR2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MARK_TYPE</td>
<td class="org-left">NUMBER (1)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">STATUS</td>
<td class="org-left">CHAR (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ACTIVITY_SOURCE</td>
<td class="org-left">VARCHAR2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">NUM_OF_RERATE_TRIES</td>
<td class="org-left">NUMBER (2)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
<p>
Once re-rating starts you can check the progress with the following query:
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
<node ID="sec-7-4-9" CREATED="1468275705102" MODIFIED="1468275705102" COLOR="#990000"><richcontent TYPE="NODE">

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
The table used to keep the CIBER Outcollect sequences in sync with Syniverse. Every once a while we need to update it to keep in sync. 
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
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>HOME_SID</b></td>
<td class="org-left">CHAR (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">LOCKED_SID</td>
<td class="org-left">NUMBER (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SEQ_NO</td>
<td class="org-left">NUMBER (3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>SERVE_SID</b></td>
<td class="org-left">CHAR (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">STATUS_IND</td>
<td class="org-left">CHAR (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-4-10" CREATED="1468275705104" MODIFIED="1468275705104" COLOR="#990000"><richcontent TYPE="NODE">

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
The EM1 record database is the database used by <b>AEM</b> and it has so many columns that you cannot use a <i>select *</i> to query. Instead click on the link provided below and use that as a template.
<a href="file:///home/dbalchen/workspace/CommonPlace/docs/em1_example.sql">EM1_RECORD Example</a>
</p>
</body>
</html>
</richcontent>
</node>
</node>
<node ID="sec-10-6" CREATED="1468275705125" MODIFIED="1470688606564" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR Tables
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<node ID="sec-10-6-1" CREATED="1468275705125" MODIFIED="1468275705125" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR1_ACCOUNT
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
<td class="org-left"><b>ACCOUNT_ID</b></td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">The Financial ID</td>
</tr>

<tr>
<td class="org-left">ACCOUNT_STATUS</td>
<td class="org-left">VARCHAR2 (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ACCOUNT_TIMESTAMP</td>
<td class="org-left">NUMBER (19)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ACCT_BAL_POLICY</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>AR_ACCOUNT_SUB_TYPE</b></td>
<td class="org-left">CHAR (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>AR_ACCOUNT_TYPE</b></td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>AR_BALANCE</b></td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AR_EXCEPTION_ACC_IND</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BALANCE_UPD_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BE</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CANDIDATE_FILE_EXTRACT_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CM_ACCOUNT_NUMBER</td>
<td class="org-left">VARCHAR2 (12 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">COLL_IND_UPD_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">COLLECTION_INDICATOR</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CURRENCY</td>
<td class="org-left">CHAR (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>CUSTOMER_NO</b></td>
<td class="org-left">NUMBER (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DEPOSIT_BALANCE</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DISPUTE_BALANCE</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DOCUMENT_TYPE</td>
<td class="org-left">CHAR (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_AGREEMENT_ID</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_BOD_BALANCE</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_CREDIT_LIMIT_IND</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_NEW_INVOICE_IND</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_SEND_BALANCE</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>L9_GEO_CODE</b></td>
<td class="org-left">VARCHAR2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">LAST_ACTIVITY_STATUS_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">LPC_WAVING_IND</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PARTITION_ID</td>
<td class="org-left">NUMBER (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PENDING_CREDIT_BALANCE</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">UNAPPLIED_AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">WRITE_OFF_STATUS</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-10-6-2" CREATED="1468275705125" MODIFIED="1468275705125" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR1_INVOICE
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
<td class="org-left"><b>ACCOUNT_ID</b></td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AR_INVOICE_NUMBER</td>
<td class="org-left">VARCHAR2 (60 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BILL_SEQ_NO</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BILLING_ARRANGEMENT_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BILLING_INVOICE_NUMBER</td>
<td class="org-left">VARCHAR2 (180 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CREDIT_AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CREDIT_NET_AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CREDIT_TAX_AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>CYCLE_CODE</b></td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>CYCLE_MONTH</b></td>
<td class="org-left">NUMBER (2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CYCLE_YEAR</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DISCOUNT_AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DISCOUNT_NET_AMT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DISCOUNT_TAX_AMT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FINALISE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FINALISE_TRANS_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">INVOICE_AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">INVOICE_BALANCE</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">INVOICE_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">INVOICE_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">INVOICE_STATUS</td>
<td class="org-left">VARCHAR2 (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">INVOICE_STATUS_CHANGE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">INVOICE_TYPE</td>
<td class="org-left">VARCHAR2 (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L3_CRD_EXTRACT_IND</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PARTITION_ID</td>
<td class="org-left">NUMBER (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PERIOD_KEY</td>
<td class="org-left">NUMBER (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REVERSAL_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REVERSAL_TRANS_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SUB_BILL_SEQ_NO</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TAX_AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TRANSACTION_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-10-6-3" CREATED="1468275705126" MODIFIED="1468275705126" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR1_CHARGE_CODE
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
</node>
<node ID="sec-10-6-4" CREATED="1468275705126" MODIFIED="1468275705126" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR1_CHARGE_GROUP
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
</node>
<node ID="sec-10-6-5" CREATED="1468275705126" MODIFIED="1468275705126" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR1_CUSTOMER_CREDIT
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
<td class="org-left">ACCOUNT_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BALANCE_IMPACT_CODE</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BE</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BILL_SEQ_NO</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BILLING_ARRANGEMENT_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BILLING_CHARGE_SEQ_NO</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CHARGE_CODE</td>
<td class="org-left">VARCHAR2 (25 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CHG_REVENUE_CODE</td>
<td class="org-left">CHAR (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CR_ATTRIB_NAME</td>
<td class="org-left">VARCHAR2 (30 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CREDIT_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CREDIT_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CREDIT_LEVEL_CODE</td>
<td class="org-left">CHAR (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CREDIT_REASON</td>
<td class="org-left">VARCHAR2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FINALISE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FINALISE_TRANS_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">INVOICE_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">INVOICE_REVERSAL_NUMBER</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CANCEL_IND</td>
<td class="org-left">VARCHAR2 (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_DF_ACTIVITY</td>
<td class="org-left">VARCHAR2 (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_DF_INDICATOR</td>
<td class="org-left">VARCHAR2 (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_DF_PERIOD</td>
<td class="org-left">VARCHAR2 (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_EVENT_ID</td>
<td class="org-left">NUMBER (18)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_IS_DISCOUNT</td>
<td class="org-left">VARCHAR2 (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_LINE_COUNT</td>
<td class="org-left">NUMBER (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_LOCATION</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_LT_AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ORIG_CHARGE_TYPE</td>
<td class="org-left">VARCHAR2 (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ORIG_CHG_SEQ_NO</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_REV_LOCATION</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_REV_SALES_CHANNEL</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_SALES_CHANNEL</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ST_AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PARTITION_ID</td>
<td class="org-left">NUMBER (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PERIOD_KEY</td>
<td class="org-left">NUMBER (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">RESTRICTED_CHARGE_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">RESTRICTED_INVOICE_NUMBER</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REVERSAL_BILL_SEQ_NO</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REVERSAL_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REVERSAL_REASON</td>
<td class="org-left">VARCHAR2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REVERSAL_SUB_BILL_SEQ_NO</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REVERSAL_TRANS_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SUB_BILL_SEQ_NO</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TAX_AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TRANSACTION_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">WRITE_OFF_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-10-6-6" CREATED="1468275705126" MODIFIED="1470688606564" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR1_TAX_ITEM
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
</node>
<node ID="sec-10-6-7" CREATED="1468275705126" MODIFIED="1468275705126" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR1_REFUND_REQUEST
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
<td class="org-left">ACCOUNT_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ACTIVITY_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_METHOD</td>
<td class="org-left">VARCHAR2 (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CREDIT_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CRITERIA_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DEBIT_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EXTRACT_TO_AP_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_BUY_BACK_PREPAID</td>
<td class="org-left">VARCHAR2 (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CITY</td>
<td class="org-left">VARCHAR2 (35 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CUSTOMER_NAME</td>
<td class="org-left">VARCHAR2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_LOCATION</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_MERCHANT_REFERENCE_CODE</td>
<td class="org-left">NUMBER (8)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_POSTAL_CODE</td>
<td class="org-left">VARCHAR2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_REGION</td>
<td class="org-left">VARCHAR2 (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_REQUEST_ID</td>
<td class="org-left">VARCHAR2 (26 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_REV_LOCATION</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_REV_SALES_CHANNEL</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_SALES_CHANNEL</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_STREET</td>
<td class="org-left">VARCHAR2 (35 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MANUAL_REFUND_IND</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PARTITION_ID</td>
<td class="org-left">NUMBER (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REFUND_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REFUND_METHOD</td>
<td class="org-left">VARCHAR2 (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REFUND_REASON</td>
<td class="org-left">VARCHAR2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REFUND_STATUS</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REVERSAL_CREDIT_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REVERSAL_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REVERSAL_REASON</td>
<td class="org-left">VARCHAR2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REVERSAL_TRANS_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TRANSACTION_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-10-6-8" CREATED="1468275705127" MODIFIED="1468275705127" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR1_DEPOSIT_REQUEST
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
<td class="org-left">ACCOUNT_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CANCEL_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CANCEL_REASON</td>
<td class="org-left">VARCHAR2 (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CANCELLED_AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DEBIT_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DEPOSIT_DESIGNATION</td>
<td class="org-left">VARCHAR2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DEPOSIT_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DUE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EXTERNAL_DEPOSIT_ID</td>
<td class="org-left">VARCHAR2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">GROUP_ID</td>
<td class="org-left">VARCHAR2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">INTEREST_AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_AP_ID</td>
<td class="org-left">VARCHAR2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_EXT_CHG_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_LOCATION</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_SALES_CHANNEL</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PAID_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PARENT_DEPOSIT_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PARTITION_ID</td>
<td class="org-left">NUMBER (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PYMT_TRIGGERED</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">RELEASE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">RELEASE_METHOD</td>
<td class="org-left">VARCHAR2 (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">RELEASE_REASON</td>
<td class="org-left">VARCHAR2 (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">RELEASED_AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REQUEST_AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REQUEST_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REQUEST_REASON</td>
<td class="org-left">VARCHAR2 (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REVERSAL_TRANS_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TRANSACTION_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-10-6-9" CREATED="1468275705127" MODIFIED="1468275705127" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR1_PAYMENT
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
<td class="org-left">ACCOUNT_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ACTIVITY_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ACTIVITY_INDICATOR</td>
<td class="org-left">CHAR (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BILL_SEQ_NO</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CONVERSION_RATE</td>
<td class="org-left">NUMBER (11,9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CREDIT_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_DEP_REL</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_LOCATION</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_SALES_CHANNEL</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ORIGINAL_AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ORIGINAL_CONVERTED_AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PARTITION_ID</td>
<td class="org-left">NUMBER (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PAYMENT_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PERIOD_KEY</td>
<td class="org-left">NUMBER (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PYMDT_PARTITION_ID</td>
<td class="org-left">NUMBER (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PYMDT_PERIOD_KEY</td>
<td class="org-left">NUMBER (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REVERSAL_TRANS_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SUB_BILL_SEQ_NO</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TRANSACTION_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-10-6-10" CREATED="1468275705127" MODIFIED="1468275705127" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR1_PAYMENT_DETAILS
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
<td class="org-left">ACCOUNT_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BANK_ACCOUNT_NUMBER</td>
<td class="org-left">VARCHAR2 (255 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BANK_BRANCH_NUMBER</td>
<td class="org-left">VARCHAR2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BANK_CODE</td>
<td class="org-left">VARCHAR2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BATCH_LINE_NUMBER</td>
<td class="org-left">NUMBER (6)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BATCH_NUMBER</td>
<td class="org-left">NUMBER (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BILLING_ARRANGEMENT</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BILLING_INVOICE_NUMBER</td>
<td class="org-left">VARCHAR2 (180 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CC_AUTHORISATION_CODE</td>
<td class="org-left">VARCHAR2 (8 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CC_EXPIRY_DATE</td>
<td class="org-left">VARCHAR2 (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CHECK_DRAWER_NAME</td>
<td class="org-left">VARCHAR2 (30 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CHECK_NO</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CONFIRMATION_NO</td>
<td class="org-left">VARCHAR2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CREDIT_CARD_NUMBER</td>
<td class="org-left">VARCHAR2 (255 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CURRENCY</td>
<td class="org-left">CHAR (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DEPOSIT_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DEPOSIT_DESIGNATION</td>
<td class="org-left">VARCHAR2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DIRECT_DEBIT_VOUCHER</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FILE_GENERATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FILE_SEQ_NO</td>
<td class="org-left">NUMBER (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FILE_SOURCE_ID</td>
<td class="org-left">VARCHAR2 (8 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FILE_SOURCE_TYPE</td>
<td class="org-left">VARCHAR2 (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_AUTHORIZATION_CODE</td>
<td class="org-left">VARCHAR2 (7 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_CTN</td>
<td class="org-left">NUMBER (10)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_EXT_PYM_ID</td>
<td class="org-left">VARCHAR2 (32 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_LOCATION</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_MERCHANT_ID</td>
<td class="org-left">VARCHAR2 (30 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_MERCHANT_REFERENCE_CODE</td>
<td class="org-left">NUMBER (8)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ORIG_ACCOUNT</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ORIG_CHECK_AMT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ORIGINATOR</td>
<td class="org-left">VARCHAR2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_ORIGINATOR_LOCATION</td>
<td class="org-left">VARCHAR2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_PAYMENT_RECURRANCE</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_REQUEST_ID</td>
<td class="org-left">VARCHAR2 (26 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_SALES_CHANNEL</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MEMO_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PARTITION_ID</td>
<td class="org-left">NUMBER (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PAYMENT_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PAYMENT_METHOD</td>
<td class="org-left">CHAR (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PAYMENT_SOURCE_ID</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PAYMENT_SOURCE_TYPE</td>
<td class="org-left">VARCHAR2 (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PAYMENT_SUB_METHOD</td>
<td class="org-left">VARCHAR2 (3 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PAYMENT_TYPE</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PERIOD_KEY</td>
<td class="org-left">NUMBER (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">RECALL_NUMBER</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REJECTION_CODE</td>
<td class="org-left">VARCHAR2 (4 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REVERSAL_REASON</td>
<td class="org-left">VARCHAR2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SUBSCRIBER_NUMBER</td>
<td class="org-left">VARCHAR2 (11 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TRANSACTION_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-10-6-11" CREATED="1468275705128" MODIFIED="1468275705128" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR1_PAYMENT_ACTIVITY
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
Used in the <b>Paid and Prepaid</b> reports.
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
<td class="org-left">ACCOUNT_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ACTIVITY_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ACTIVITY_TYPE</td>
<td class="org-left">CHAR (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AMOUNT</td>
<td class="org-left">NUMBER (18,2)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BILL_SEQ_NO</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CREDIT_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FUNDS_TRANSFER_IND</td>
<td class="org-left">VARCHAR2 (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FUNDS_TRANSFER_REASON</td>
<td class="org-left">VARCHAR2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_BATCH_LINE_NUMBER</td>
<td class="org-left">NUMBER (7)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_BATCH_NUMBER</td>
<td class="org-left">NUMBER (6)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_FILE_NAME</td>
<td class="org-left">VARCHAR2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_LOCATION</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">L9_SALES_CHANNEL</td>
<td class="org-left">VARCHAR2 (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MEMO_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PARENT_CREDIT</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PARTITION_ID</td>
<td class="org-left">NUMBER (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PAYMENT_ACTIVITY_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PAYMENT_PERIOD_KEY</td>
<td class="org-left">NUMBER (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PERIOD_KEY</td>
<td class="org-left">NUMBER (5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REASON_CODE</td>
<td class="org-left">VARCHAR2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REVERSAL_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REVERSAL_REASON</td>
<td class="org-left">VARCHAR2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REVERSAL_TRANS_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SUB_BILL_SEQ_NO</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TRANSACTION_ID</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TRANSFER_ACCOUNT</td>
<td class="org-left">NUMBER (12)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-10-8" CREATED="1468275705128" MODIFIED="1468275705128" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>GL Tables
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<node ID="sec-10-8-1" CREATED="1468275705128" MODIFIED="1468275705128" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>ar1_gl_detailed_data_info_v
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
</node>
<node ID="sec-10-8-2" CREATED="1468275705128" MODIFIED="1468275705128" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>ar1_gl_data_info_v
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
</node>
<node ID="sec-10-8-3" CREATED="1468275705129" MODIFIED="1468275705129" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>ar1_transaction_log
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
</node>
<node ID="sec-10-8-4" CREATED="1468275705129" MODIFIED="1468275705129" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>ar1-JGL-control
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
</node>
</node>
</node>
<node ID="sec-7-5" CREATED="1468275705104" MODIFIED="1468275705104" COLOR="#00b439"><richcontent TYPE="NODE">

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
reference tables in <b>CARES</b>. The following is the list of all <b>BPT</b>
tables that we are responsible for:
</p>
</body>
</html>
</richcontent>
<node ID="sec-7-5-1" CREATED="1468275705104" MODIFIED="1468275705104" COLOR="#990000"><richcontent TYPE="NODE">

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
<td class="org-left">PROVIDER_ID</td>
<td class="org-left">NUMBER(18,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CUSTOMER_ID</td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR(6 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CYCLE_CODE</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">GROUP_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MIN_TIME_TO_SEND</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MAX_RECS_IN_FILE</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SEND_EMPTY_NOTIF</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EXPIRATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EFFECTIVE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PROVIDER_DESC</td>
<td class="org-left">VARCHAR2(256 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">RESOURCE_TYPE</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-5-2" CREATED="1468275705106" MODIFIED="1468275705106" COLOR="#990000"><richcontent TYPE="NODE">

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
<node ID="sec-7-5-3" CREATED="1468275705106" MODIFIED="1468275705106" COLOR="#990000"><richcontent TYPE="NODE">

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
<td class="org-left">RESOURCE_SEGMENT</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">RESOURCE_VALUE</td>
<td class="org-left">VARCHAR2(63 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">RESOURCE_TYPE</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EFFECTIVE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR(6 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">UPDATE_ID</td>
<td class="org-left">NUMBER(18,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EXPIRATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SUBSCRIBER_ID</td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SUB_STATUS</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ROUTING_POLICY_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PAYMENT_CATEGORY</td>
<td class="org-left">CHAR(4 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CUSTOMER_ID</td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BILL_CYCLE</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">NEW_BILL_CYCLE</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CHG_CYC_REQ_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">LARGE_CUST_IND</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">RESOURCE_HASH_VALUE</td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SUBSCRIBER_HASH_VALUE</td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-5-4" CREATED="1468275705106" MODIFIED="1468275705106" COLOR="#990000"><richcontent TYPE="NODE">

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
<td class="org-left">CYCLE_CODE</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CUSTOMER_SEGMENT</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SUBSCRIBER_ID</td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR(6 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">UPDATE_ID</td>
<td class="org-left">NUMBER(18,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CUSTOMER_ID</td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BE</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CURRENCY_ID</td>
<td class="org-left">CHAR(3 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SUBSCRIBER_HASH_VALUE</td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-5-5" CREATED="1468275705107" MODIFIED="1468275705107" COLOR="#990000"><richcontent TYPE="NODE">

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
<td class="org-left">CYCLE_CODE</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CUSTOMER_SEGMENT</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SUBSCRIBER_ID</td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OFFER_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OFFER_INSTANCE</td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OFFER_EFF_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR(6 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">UPDATE_ID</td>
<td class="org-left">NUMBER(18,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OFFER_EXP_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SOURCE_OFFER_AGR_ID</td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SOURCE_OFFER_INSTANCE</td>
<td class="org-left">NUMBER(10,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EFF_ACT_CODE_PROR</td>
<td class="org-left">VARCHAR2(25 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EXP_ACT_CODE_PROR</td>
<td class="org-left">VARCHAR2(25 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-5-6" CREATED="1468275705107" MODIFIED="1468275705107" COLOR="#990000"><richcontent TYPE="NODE">

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
Contains the <b>USCC</b> MIN (MSID) block ranges and there <b>SID</b> code. The Block Ranges are listed in the <b>Technical Data Sheet</b> from <b>Syniverse</b>. This only contains <b>USCC</b> MINS only. For foreign carriers see the <b>VISITOR_MIN_LR</b>.
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
<td class="org-left"><b>MIN_BLK</b></td>
<td class="org-left">NUMBER(6,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>FROM_LINE_RANGE</b></td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>TO_LINE_RANGE</b></td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EFFECTIVE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR(6 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>NPA_TYPE</b></td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">C = Postpaid</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">T = Prepaid</td>
</tr>

<tr>
<td class="org-left"><b>SIDS</b></td>
<td class="org-left">VARCHAR2(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EXPIRATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-5-7" CREATED="1468275705107" MODIFIED="1468275705107" COLOR="#990000"><richcontent TYPE="NODE">

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
This table is created via  a program and contains all of our roaming partners MIN/SID block ranges. It is located on the <b>BRMPRD</b> database.
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-5-8" CREATED="1468275705108" MODIFIED="1468275705108" COLOR="#990000"><richcontent TYPE="NODE">

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
contract. A contract is defined as the entity to which a group of
<b>SIDS</b> belongs, whose common attribute is the clearinghouse-related
Net Settlement bank account. This usually means that all the <b>SIDS</b>
that belong to a settlement contract are part of one operating
company.
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-5-9" CREATED="1468275705108" MODIFIED="1468275705108" COLOR="#990000"><richcontent TYPE="NODE">

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
This table includes detailed information on every destination. A
destination represents a target of Out-collect calls (such as a
clearinghouse). The destination of every roamer call is determined
according to the Home <b>SID</b> value of that call.
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-5-10" CREATED="1468275705108" MODIFIED="1468275705108" COLOR="#990000"><richcontent TYPE="NODE">

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
Defines out-collect roaming agreement between <b>SID</b> pair. Originating
category is retrieve from the table that is used later on for
service filter determination. <b>INCOL_SID_PAIR</b> and <b>SID</b> tables are also
used by Acquisition &amp; Formatting.
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
<td class="org-left">SERVE_SID</td>
<td class="org-left">CHAR(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">HOME_SID</td>
<td class="org-left">CHAR(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EFFECTIVE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR(6 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EXPIRATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OUTCOL_DEST_CD</td>
<td class="org-left">CHAR(6 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CRE_DAILY_SURCG_IND</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DAILY_SURCHARGE_AMT</td>
<td class="org-left">NUMBER(18,3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MISC_SCHG_IND</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MISC_SCHG_RATE</td>
<td class="org-left">NUMBER(18,3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MISC_SCHG_MEASURE_IND</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MISC_DESCRIPTOR</td>
<td class="org-left">CHAR(2 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">MISC_SCHG_DESC</td>
<td class="org-left">VARCHAR2(50 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CYCLE_CODE</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PRIORITY</td>
<td class="org-left">NUMBER(5,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">NUM_OF_REC_TO_COMMIT</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PARTITION_ID</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">GROUP_ID</td>
<td class="org-left">NUMBER(4,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AGREEMENT_ID</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-5-11" CREATED="1468275705109" MODIFIED="1468275705109" COLOR="#990000"><richcontent TYPE="NODE">

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
<node ID="sec-7-5-12" CREATED="1468275705111" MODIFIED="1468275705111" COLOR="#990000"><richcontent TYPE="NODE">

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
<node ID="sec-7-5-13" CREATED="1468275705111" MODIFIED="1468275705111" COLOR="#990000"><richcontent TYPE="NODE">

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
This maybe another version of the <b>ADJ9_TIME_ZONE_REF</b> table,
very similar.
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6" CREATED="1468275705111" MODIFIED="1468275705111" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>EPC Tables
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
These tables are included in the <b>EPC</b> dump which happens once or twice a month, no hotfix is needed unless needs to be in production right away.
</p>
</body>
</html>
</richcontent>
<node ID="sec-7-6-1" CREATED="1468275705112" MODIFIED="1512506204809" COLOR="#990000"><richcontent TYPE="NODE">

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
      One of the most important reference tables used, contains all the information for all the <b>SIDS</b><sup><a id="fnr.4" class="footref" href="#fn.4">4</a></sup>&#160;for all the companies we have a contract with.
    </p>
    <table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">
      <colgroup>
      <col class="org-left"/>
      <col class="org-left"/>
      <col class="org-left"/>
      </colgroup>
      

      <tr>
        <th scope="col" class="org-left">
          <b>Column Name</b>
        </th>
        <th scope="col" class="org-left">
          <b>Data Type</b>
        </th>
        <th scope="col" class="org-left">
          <b>Description</b>
        </th>
      </tr>
      <tr>
        <td class="org-left">
          CINDEX
        </td>
        <td class="org-left">
          NUMBER(9,0)
        </td>
        <td class="org-left">
          
        </td>
      </tr>
      <tr>
        <td class="org-left">
          <b>SIDS</b>
        </td>
        <td class="org-left">
          VARCHAR2(5 BYTE)
        </td>
        <td class="org-left">
          &#160;
        </td>
      </tr>
      <tr>
        <td class="org-left">
          EFFECTIVE_DATE
        </td>
        <td class="org-left">
          DATE
        </td>
        <td class="org-left">
          &#160;
        </td>
      </tr>
      <tr>
        <td class="org-left">
          SID_DESC
        </td>
        <td class="org-left">
          VARCHAR2(50 BYTE)
        </td>
        <td class="org-left">
          &#160;
        </td>
      </tr>
      <tr>
        <td class="org-left">
          SID_COMMERCIAL_NAME
        </td>
        <td class="org-left">
          VARCHAR2(50 BYTE)
        </td>
        <td class="org-left">
          &#160;
        </td>
      </tr>
      <tr>
        <td class="org-left">
          TIME_ZONE_CODE
        </td>
        <td class="org-left">
          VARCHAR2(2 BYTE)
        </td>
        <td class="org-left">
          &#160;
        </td>
      </tr>
      <tr>
        <td class="org-left">
          SETLMNT_CONTRACT_CD
        </td>
        <td class="org-left">
          VARCHAR2(3 BYTE)
        </td>
        <td class="org-left">
          &#160;
        </td>
      </tr>
      <tr>
        <td class="org-left">
          INTRACOMP_IND
        </td>
        <td class="org-left">
          VARCHAR2(3 BYTE)
        </td>
        <td class="org-left">
          &#160;
        </td>
      </tr>
      <tr>
        <td class="org-left">
          SID_STATE
        </td>
        <td class="org-left">
          VARCHAR2(2 BYTE)
        </td>
        <td class="org-left">
          &#160;
        </td>
      </tr>
      <tr>
        <td class="org-left">
          SID_COUNTRY
        </td>
        <td class="org-left">
          VARCHAR2(3 BYTE)
        </td>
        <td class="org-left">
          &#160;
        </td>
      </tr>
      <tr>
        <td class="org-left">
          SID_CITY
        </td>
        <td class="org-left">
          VARCHAR2(30 BYTE)
        </td>
        <td class="org-left">
          &#160;
        </td>
      </tr>
      <tr>
        <td class="org-left">
          SID_LOCATION_CD
        </td>
        <td class="org-left">
          CHAR(1 BYTE)
        </td>
        <td class="org-left">
          &#160;
        </td>
      </tr>
      <tr>
        <td class="org-left">
          OUTCOL_DEST_CD
        </td>
        <td class="org-left">
          VARCHAR2(6 BYTE)
        </td>
        <td class="org-left">
          &#160;
        </td>
      </tr>
      <tr>
        <td class="org-left">
          CURRENCY_CODE
        </td>
        <td class="org-left">
          VARCHAR2(2 BYTE)
        </td>
        <td class="org-left">
          &#160;
        </td>
      </tr>
      <tr>
        <td class="org-left">
          BAND_CODE
        </td>
        <td class="org-left">
          CHAR(1 BYTE)
        </td>
        <td class="org-left">
          &#160;
        </td>
      </tr>
      <tr>
        <td class="org-left">
          GEO_CODE
        </td>
        <td class="org-left">
          VARCHAR2(9 BYTE)
        </td>
        <td class="org-left">
          &#160;
        </td>
      </tr>
      <tr>
        <td class="org-left">
          ORIGINATING_CATEGORY
        </td>
        <td class="org-left">
          VARCHAR2(6 BYTE)
        </td>
        <td class="org-left">
          &#160;
        </td>
      </tr>
      <tr>
        <td class="org-left">
          EXPIRATION_DATE
        </td>
        <td class="org-left">
          DATE
        </td>
        <td class="org-left">
          &#160;
        </td>
      </tr>
      <tr>
        <td class="org-left">
          INCORPORATE_IND
        </td>
        <td class="org-left">
          CHAR(1 BYTE)
        </td>
        <td class="org-left">
          &#160;
        </td>
      </tr>
    </table>
  </body>
</html>

</richcontent>
</node>
<node ID="sec-7-6-2" CREATED="1468275705113" MODIFIED="1468275705113" COLOR="#990000"><richcontent TYPE="NODE">

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
A description of each <b>SID</b> found in the <b>PC9_SID</b> table. When the
<b>SID</b> table is updated this table needs to be updated as well. 
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-3" CREATED="1468275705113" MODIFIED="1468275705113" COLOR="#990000"><richcontent TYPE="NODE">

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
Contains a list of all the special numbers, numbers that can be
dropped (no charge), toll or air time free.
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
<td class="org-left">SPECIAL_NUMBER</td>
<td class="org-left">VARCHAR2(10 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CALL_DIRECTION</td>
<td class="org-left">CHAR(1 BYTE)</td>
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
<td class="org-left">5 = both</td>
</tr>

<tr>
<td class="org-left">HOME_ROAM_IND</td>
<td class="org-left">CHAR(1 BYTE)</td>
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
<td class="org-left">CALL_SOURCE</td>
<td class="org-left">VARCHAR2(4 BYTE)</td>
<td class="org-left">V = Voice</td>
</tr>

<tr>
<td class="org-left">EFFECTIVE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>AIR_TIME_IND</b></td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">N = Air Time</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">is free</td>
</tr>

<tr>
<td class="org-left">TOLL_SPECIAL_NUMBER_GROUP</td>
<td class="org-left">VARCHAR2(255 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>DROP_CALL_IND</b></td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">Y = This record</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Will be dropped</td>
</tr>

<tr>
<td class="org-left">SPECIAL_NUMBER_TYPE</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SERVICE_FILTER</td>
<td class="org-left">VARCHAR2(15 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>TOLL_FREE_IND</b></td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">Y = No Toll</td>
</tr>

<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">will be charged</td>
</tr>

<tr>
<td class="org-left">BL_CALL_DEST_STATE</td>
<td class="org-left">VARCHAR2(2 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BL_CALL_DEST_CITY</td>
<td class="org-left">VARCHAR2(30 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AUTOMATICALLY_AUTHORIZED</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DESCRIPTION</td>
<td class="org-left">VARCHAR2(50 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EXPIRATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-4" CREATED="1468275705113" MODIFIED="1468275705113" COLOR="#990000"><richcontent TYPE="NODE">

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
Maps the service area to (<i>all maybe to strong a term</i>)  supported <b>SIDS</b>.
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
<td class="org-left">SERVE_AREA</td>
<td class="org-left">VARCHAR2(50 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left"><b>SIDS</b></td>
<td class="org-left">VARCHAR2(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EFFECTIVE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EXPIRATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-5" CREATED="1468275705113" MODIFIED="1468275705113" COLOR="#990000"><richcontent TYPE="NODE">

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
<td class="org-left">CINDEX</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">COUNTRY_CODE</td>
<td class="org-left">VARCHAR2(3 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DESCRIPTION</td>
<td class="org-left">VARCHAR2(30 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">NANP_IND</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-6" CREATED="1468275705113" MODIFIED="1468275705113" COLOR="#990000"><richcontent TYPE="NODE">

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
Defines <b>InCollect</b> roaming agreement between <b>SID</b> pair. Originating
category is retrieve from the table that is used later on for
service filter determination. INCOL_SID_PAIR and <b>SID</b> tables are also
used by Acquisition &amp; Formatting.
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
<td class="org-left">SERVE_SID</td>
<td class="org-left">VARCHAR2(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">HOME_SID</td>
<td class="org-left">VARCHAR2(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EFFECTIVE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ORIGINATING_CATEGORY</td>
<td class="org-left">VARCHAR2(6 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">INCOL_NOT_VALID_ACT</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AGR_PEAK_RATE</td>
<td class="org-left">NUMBER(18,3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AGR_OFF_PEAK_RATE</td>
<td class="org-left">NUMBER(18,3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AGR_SCHG_AMT</td>
<td class="org-left">NUMBER(18,3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TOLL_AGR_TYPE</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AGR_TOLL_RATE</td>
<td class="org-left">NUMBER(18,3)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">INCOL_TL_NVALID_AC</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DAILY_SURCHARGE_INDICATION</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EXPIRATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-7" CREATED="1468275705114" MODIFIED="1468275705114" COLOR="#990000"><richcontent TYPE="NODE">

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
<node ID="sec-7-6-8" CREATED="1468275705114" MODIFIED="1468275705114" COLOR="#990000"><richcontent TYPE="NODE">

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
<td class="org-left">BE</td>
<td class="org-left">NUMBER(2,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CALL_SOURCE</td>
<td class="org-left">VARCHAR2(4 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SERVICE_TYPE</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ORIGINATING_CATEGORY</td>
<td class="org-left">VARCHAR2(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DESTINATION_CATEGORY</td>
<td class="org-left">VARCHAR2(5 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CALL_DIRECTION</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EFFECTIVE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SERVICE_FILTER</td>
<td class="org-left">VARCHAR2(15 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DESCRIPTION</td>
<td class="org-left">VARCHAR2(30 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EXPIRATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-9" CREATED="1468275705115" MODIFIED="1468275705115" COLOR="#990000"><richcontent TYPE="NODE">

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
This table as well and <b>PC3_SERVICE_FILTER</b> are used by the <b>RLC</b>.
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
<td class="org-left">SERVICE_INDEX</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SERVICE_FILTER</td>
<td class="org-left">VARCHAR2(15 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DESCRIPTION</td>
<td class="org-left">VARCHAR2(50 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node TEXT="PC9_DEST_CATEGORY" ID="sec-7-6-10" CREATED="1468275705115" MODIFIED="1512506069505" COLOR="#990000">
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
<td class="org-left">CINDEX</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DESTINATION_CATEGORY</td>
<td class="org-left">VARCHAR2(6 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DESCRIPTION</td>
<td class="org-left">VARCHAR2(101 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-11" CREATED="1468275705116" MODIFIED="1468275705116" COLOR="#990000"><richcontent TYPE="NODE">

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
<td class="org-left">PREFIX</td>
<td class="org-left">VARCHAR2(30 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">STATION_TYPE</td>
<td class="org-left">VARCHAR2(30 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EFFECTIVE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DESTINATION_CATEGORY</td>
<td class="org-left">VARCHAR2(6 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AUTOMATICALLY_AUTHORIZED</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ROAMING_DEST_CATEGORY</td>
<td class="org-left">VARCHAR2(6 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DROP_IND</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">COUNTRY_CODE</td>
<td class="org-left">VARCHAR2(3 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DESCRIPTION</td>
<td class="org-left">VARCHAR2(30 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">NETWORK_CALL_TYPE</td>
<td class="org-left">CHAR(1 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EXPIRATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-12" CREATED="1468275705116" MODIFIED="1468275705116" COLOR="#990000"><richcontent TYPE="NODE">

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
<td class="org-left">CINDEX</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ORIGINATING_CATEGORY</td>
<td class="org-left">VARCHAR2(6 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DESCRIPTION</td>
<td class="org-left">VARCHAR2(101 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-13" CREATED="1468275705116" MODIFIED="1468275705116" COLOR="#990000"><richcontent TYPE="NODE">

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
<td class="org-left">CINDEX</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ROAMING_DEST_CATEGORY</td>
<td class="org-left">VARCHAR2(6 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DESCRIPTION</td>
<td class="org-left">VARCHAR2(101 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-14" CREATED="1468275705116" MODIFIED="1468275705116" COLOR="#990000"><richcontent TYPE="NODE">

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
<td class="org-left">CHARGE_CODE_SEQ</td>
<td class="org-left">NUMBER(5,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CHARGE_CODE</td>
<td class="org-left">VARCHAR2(15 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DESCRIPTION</td>
<td class="org-left">VARCHAR2(4000 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CHARGE_ENTITY</td>
<td class="org-left">VARCHAR2(60 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">REVENUE_TYPE</td>
<td class="org-left">CHAR(2 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-15" CREATED="1468275705118" MODIFIED="1468275705118" COLOR="#990000"><richcontent TYPE="NODE">

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
<node ID="sec-7-6-16" CREATED="1468275705118" MODIFIED="1468275705118" COLOR="#990000"><richcontent TYPE="NODE">

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
Lists the relationship between <b>SIDS</b> and NPA ranges where the toll
is free.
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-6-17" CREATED="1468275705118" MODIFIED="1468275705118" COLOR="#990000"><richcontent TYPE="NODE">

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
This needs to updated periodically.
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
<td class="org-left">CINDEX</td>
<td class="org-left">NUMBER(9,0)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ADDRESS</td>
<td class="org-left">VARCHAR2(256 BYTE)</td>
<td class="org-left">I.P Address</td>
</tr>

<tr>
<td class="org-left">DESCRIPTION</td>
<td class="org-left">VARCHAR2(101 BYTE)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-8" CREATED="1468275705118" MODIFIED="1468275705118" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>SID Updates
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
SID'S or Switch IDentifiers is a unique 5 digit number that correlates to switch. It is with the <b>SID</b> that <b>TOPS</b> defines the all mediation and rating logic and is the first enrichment step on a call record.
</p>
</body>
</html>
</richcontent>
<node ID="sec-7-8-1" CREATED="1468275705119" MODIFIED="1468275705119" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>BPT Tables and Process
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
When a <b>SID</b> is added or changes there is a possibility that the following tables need to be changed:
</p>
<ol class="org-ol">
<li>PC9_SID</li>
<li>PC9_SID_LIST</li>
<li>PC9_SERVE_AREA_TO_SID</li>
<li>AGD1_RESOURCES_REF</li>
<li>MI1_STLMNT_CONTRACT</li>
<li>MF1_OUTCOL_SID_PAIR</li>
<li>PC9_INCOL_SID_PAIR</li>
<li>APE1_SUBSCR_DATA_REF</li>
<li>APE1_SUBSCR_OFFERS_REF</li>
</ol>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-8-2" CREATED="1468275705119" MODIFIED="1468275705119" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>New SID Contract Rates
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
All <b>SIDS</b> changes start with the <b>SID</b> table and depending on what needs to be done there determines what needs to be done to the other 7 tables.
For example if it is a brand new <b>SID</b> all 8 tables need to be updated with the most complicated part setting up InCollect and OutCollect processing for a <b>SIDS</b> contract. The following explains in details on what needs to be done:
</p>

<ol class="org-ol">
<li>Find the entry in the <b>PC9_INCOL_SID_PAIR</b> where the <b>SERVE SID</b> is the contract number and the <b>HOME SID</b> = '175' <i>(USCC contract number)</i>.
<ol class="org-ol">
<li>Expire the date for when you want the new rate to take affect.</li>
<li>Use the above row as a template for an insert statement.</li>
<li>*For outcollecs do the same as above except use SERVE SID = '175'*</li>
</ol></li>

<li>Create an Insert statement for the  <b>PC9_INCOL_SID_PAIR</b> with the new rates.</li>

<li>For the OutCollect side find all <b>SIDS</b> that that have the <b>Settlement Contract Code</b>, <i>(In this example we trying to find all <b>SIDS</b> with settlement contract code = 287)</i></li>
</ol>
<pre class="example">
SELECT SIDS FROM PC9_SID WHERE SETLMNT_CONTRACT_CD = '287';
</pre>
<ol class="org-ol">
<li>For each <b>SID</b> found add '175' to the end and use that as the resource value for the table <b>AGD1_RESOURCES_REF</b> then create an insert if it don't exists.</li>
</ol>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column</b></th>
<th scope="col" class="org-left"><b>Value</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left"><b>RESOURCE_SEGMENT</b></td>
<td class="org-left"><b>ResourceSegmentCalc_Sh</b></td>
</tr>

<tr>
<td class="org-left"><b>RESOURCE_VALUE</b></td>
<td class="org-left">SID + '175'</td>
</tr>

<tr>
<td class="org-left"><b>RESOURCE_TYPE</b></td>
<td class="org-left">21 (for OutCollect)</td>
</tr>

<tr>
<td class="org-left"><b>SUBSCRIBER_ID</b></td>
<td class="org-left">sequential number <i>(1, 2, 3,&#x2026;)</i></td>
</tr>

<tr>
<td class="org-left"><b>SUB_STATUS</b></td>
<td class="org-left">A (default)</td>
</tr>

<tr>
<td class="org-left"><b>ROUTING_POLICY_ID</b></td>
<td class="org-left">0 (for Postpaid)</td>
</tr>

<tr>
<td class="org-left"><b>PAYMENT_CATEGORY</b></td>
<td class="org-left">POST (default)</td>
</tr>

<tr>
<td class="org-left"><b>CUSTOMER_ID</b></td>
<td class="org-left">1 + SID</td>
</tr>

<tr>
<td class="org-left"><b>BILL_CYCLE</b></td>
<td class="org-left">99</td>
</tr>

<tr>
<td class="org-left"><b>LARGE_CUST_IND</b></td>
<td class="org-left">&#x2018;N&#x2019;</td>
</tr>

<tr>
<td class="org-left"><b>RESOURCE_HASH_VALUE</b></td>
<td class="org-left"><b>ResourceSegmentCalc_Sh</b></td>
</tr>

<tr>
<td class="org-left"><b>SUBSCRIBER_HASH_VALUE</b></td>
<td class="org-left"><b>SubsriberHashValueCalc_Sh</b></td>
</tr>
</tbody>
</table>
<ol class="org-ol">
<li>For each <b>SID</b> found add a '1' in front which will get you the <b>customer_id</b> then do a query against the <b>APE1_SUBSCR_DATA_REF</b> to get the subscriber_id <i>(Using the above as an example)</i></li>
</ol>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column</b></th>
<th scope="col" class="org-left"><b>Value</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left"><b>CYCLE_CODE</b></td>
<td class="org-left">99</td>
</tr>

<tr>
<td class="org-left"><b>CUSTOMER_SEGMENT</b></td>
<td class="org-left"><b>CustomerSegmentCalc_Sh</b></td>
</tr>

<tr>
<td class="org-left"><b>SUBSCRIBER_ID</b></td>
<td class="org-left">Sequential number <i>(1, 2, 3,&#x2026;)</i></td>
</tr>

<tr>
<td class="org-left"><b>CUSTOMER_ID</b></td>
<td class="org-left">1 + SID</td>
</tr>

<tr>
<td class="org-left"><b>SUBSCRIBER_HASH_VALUE</b></td>
<td class="org-left"><b>SubscriberHashCalculator</b></td>
</tr>
</tbody>
</table>
<ol class="org-ol">
<li>Once you have the subscriber you need to point each entries offer ID's from 
the <b>APE1_SUBSCR_OFFERS_REF</b> table to the correct air and toll charge. <i>(Again using the above example)</i>
To find a suitable offer ID search the <b>CSM_OFFER</b> table, if you cannot find one have the <b>EPC</b> group create one. (<i>In this example we are looking for a offer ID with the Air and Toll charge of 0.3</i>)</li>
</ol>
<pre class="example">
SELECT * FROM CSM_OFFER WHERE SOC_NAME LIKE '%_0.03_Air_0.03_Toll_PP%';
</pre>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Column</b></th>
<th scope="col" class="org-left"><b>Value</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left"><b>CYCLE_CODE</b></td>
<td class="org-left">99</td>
</tr>

<tr>
<td class="org-left"><b>CUSTOMER_SEGMENT</b></td>
<td class="org-left">*CustomerSegmentCalc_Sh</td>
</tr>

<tr>
<td class="org-left"><b>SUBSCRIBER_ID</b></td>
<td class="org-left">sequential number <i>(1, 2, 3,&#x2026;)</i></td>
</tr>

<tr>
<td class="org-left"><b>OFFER_ID</b></td>
<td class="org-left">SOC_ID</td>
</tr>

<tr>
<td class="org-left"><b>OFFER_INSTANCE</b></td>
<td class="org-left">Subscriber ID</td>
</tr>

<tr>
<td class="org-left">SUBSCRIBER_HASH_VALUE</td>
<td class="org-left"><b>SubsriberHashValueCalc_Sh</b></td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-7-8-3" CREATED="1468275705119" MODIFIED="1468275705119" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Hash Creation Programs
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
Some tables require that a unique hash value be created to create those values use these programs:
</p>
<pre class="example">
~/abp_home/core/bin/SubsriberHashValueCalc_Sh  &lt;SUBSCRIBER_ID&gt;

~/abp_home/core/bin/ResourceSegmentCalc_Sh     &lt;Resource Type&gt; 21 = (OutCollects)
                                               &lt;Resource Value&gt; 
                                               &lt;Resource value length&gt;

~/abp_home/core/bin/CustomerSegmentCalc_Sh     &lt;CUSTOMER_ID&gt;
</pre>



<div class="figure">
<p><img src="Pictures/Meissner_War_Bulletins.jpg" alt="Meissner_War_Bulletins.jpg" />
</p>
</div>
</body>
</html>
</richcontent>
</node>
</node>
</node>
<node ID="sec-7-7" CREATED="1468275705118" MODIFIED="1468275705118" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Hot Fix Procedures
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
<ol class="org-ol">
<li>Develop, test the <b>SQL</b> to affect the change.
<ul class="org-ul">
<li>#{Defect}.sql <i>sql script</i></li>
<li>#{Defect}BO.sql <i>backout script</i></li>
<li>#{Defect}VV.sql <i>verify script</i></li>
</ul></li>
<li>If not part of an <b>EPC Dump</b>
<ol class="org-ol">
<li>Update the  <b>BPT Master List</b></li>
<li>Send <b>SQL</b> and test results to <b>Yogesh</b> and request a hot fix</li>
<li>Update <b>BPT Hot Fix Tracking</b> spreadsheet</li>
<li>Contact Carolyn/Sandeep/Sali tell them to apply the Hot Fix.</li>
</ol></li>
<li>Update all databases in the <b>DMZ</b> with the changes</li>
<li>Create a <b>SMART Ticket</b>.
<ol class="org-ol">
<li>Create <b>Install Plan</b></li>
<li>Create <b>Test Plan</b> <i>use email to Yogesh</i></li>
<li>Create <b>Backout Plan</b> <i>point to Install plan</i></li>
<li>Just add the following sections.
<ul class="org-ul">
<li>Risk</li>
<li>Business reason</li>
<li>Impact assessment</li>
</ul></li>
</ol></li>
<li>If not part of an <b>EPC Dump</b> Email John Kelly with the Install plan and all SQL.</li>
<li>If part of an EPC dump. Notify the EPC team so they can include your <b>Smart Ticket</b> with their hot fix.</li>
<li>Represent the change in the <b>Change Control Meeting</b></li>
</ol>
</body>
</html>
</richcontent>
</node>
</node>
<node ID="sec-9-1" CREATED="1468275705120" MODIFIED="1468275705120" COLOR="#00b439"><richcontent TYPE="NODE">

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
<node ID="sec-9-1-1" CREATED="1468275705122" MODIFIED="1468275705122" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>PRDAPPC.USC_ROAM_EVNTS
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
<th scope="col" class="org-left"><b>Descritption</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">AIR_CHRG_AMT</td>
<td class="org-left">NUMBER (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">APPLICATION_ID</td>
<td class="org-left">CHAR (6 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AU_ID</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">BP_START_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CARRIER_CD</td>
<td class="org-left">VARCHAR2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CIBER_FILE_NAME_1</td>
<td class="org-left">VARCHAR2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CIBER_FILE_NAME_2</td>
<td class="org-left">VARCHAR2 (50 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_SERVICE_CODE</td>
<td class="org-left">CHAR (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">DL_UPDATE_STAMP</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EDR_ID</td>
<td class="org-left">NUMBER (11)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EVENT_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EVENT_ID</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">EVENT_TYPE</td>
<td class="org-left">VARCHAR2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">FILE_REPORT_PERIOD</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">GENERATED_REC</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">GEO_CODE</td>
<td class="org-left">VARCHAR2 (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">HOME_COMPANY</td>
<td class="org-left">VARCHAR2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">HOME_SID</td>
<td class="org-left">CHAR (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">NTWRK_ROAM_IND</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OPERATOR_ID</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ORIG_BP</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">ORIGINATING_ID</td>
<td class="org-left">CHAR (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OTHER_COMPANY</td>
<td class="org-left">VARCHAR2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PROD_ID</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SERVE_COMPANY</td>
<td class="org-left">VARCHAR2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SERVE_SID</td>
<td class="org-left">CHAR (5 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SUBSCRIBER_ID</td>
<td class="org-left">CHAR (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SURCHARGE_AMOUNT</td>
<td class="org-left">NUMBER (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SURCHARGE_IND</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_CREATION_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">SYS_UPDATE_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TERMINATING_ID</td>
<td class="org-left">CHAR (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TOLL_CHRG</td>
<td class="org-left">NUMBER (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TOLL_DURATION</td>
<td class="org-left">NUMBER (11)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TOLL_TP_IND</td>
<td class="org-left">VARCHAR2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TOTAL_CHRG_AMOUNT</td>
<td class="org-left">NUMBER (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TOTAL_TAX</td>
<td class="org-left">NUMBER (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">USAGE</td>
<td class="org-left">NUMBER (18,5)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">USC_UOM</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">VISIT_IND</td>
<td class="org-left">CHAR (1 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">VOLUME_TYPE</td>
<td class="org-left">CHAR (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-9-1-2" CREATED="1468275705124" MODIFIED="1468275705124" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>usc_sap_extract_v
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
<th scope="col" class="org-left"><b>Descritption</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">AU_ID</td>
<td class="org-left">NUMBER (9)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CARRIER_CD</td>
<td class="org-left">VARCHAR2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">OTHER_PARTNER</td>
<td class="org-left">VARCHAR2 (20 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AU_PROD_ID</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AU_EVT_ID</td>
<td class="org-left">NUMBER (4)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AU_PROD_CAT_ID</td>
<td class="org-left">CHAR (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AU_BP_START_DATE</td>
<td class="org-left">DATE</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">AU_CHARGE</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">GL_ACCOUNT</td>
<td class="org-left">VARCHAR2 (17 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">CRDR_IND</td>
<td class="org-left">CHAR (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">COST_CENTER</td>
<td class="org-left">CHAR (10 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">PRODUCT</td>
<td class="org-left">CHAR (18 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TAX_CODE</td>
<td class="org-left">CHAR (2 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">TAX_JUR_CD</td>
<td class="org-left">CHAR (15 Byte)</td>
<td class="org-left">&#xa0;</td>
</tr>

<tr>
<td class="org-left">LINE_ORDER</td>
<td class="org-left">NUMBER</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
</node>
<node TEXT="SQL Join Reference" ID="sec-7-3" CREATED="1468275705086" MODIFIED="1469732963360" COLOR="#00b439">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<div class="figure">
<p><img src="Pictures/Sql_Joins.png" alt="Sql_Joins.png" />
</p>
</div>
</body>
</html>
</richcontent>
</node>
</node>
<node TEXT="TOPS Operations" POSITION="right" ID="sec-3" CREATED="1468275705068" MODIFIED="1470236074701" COLOR="#0033ff">
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>
<node ID="sec-3-1" CREATED="1468275705069" MODIFIED="1468275705069" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Acquisition and Formating (A&amp;F)
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
<b>A&amp;F</b> is to the new system what <b>MAF and RBMS</b> was to the old. Since
the majority of rules will be moved to <b>INTEC, A&amp;F's</b> primary
function in the <b>post-TOPS</b> world will be to move the data from the
<b>UFF</b> to the usage record<sup><a id="fnr.1" class="footref" href="#fn.1">1</a></sup>.  If an <b>A&amp;F</b> error does
occur the record will be dumped into a file to be later processed by
the <b>AEM</b> <i>(Amdocs Error Manager)</i>.
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-3-2" CREATED="1468275705069" MODIFIED="1468275705069" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>TurboCharging
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
<img src="Pictures/TC.png" alt="TC.png" />
Though the overall architecture seems to be the same, with some name changes like <b>MAF</b> is now A&amp;F<sup><a id="fnr.2" class="footref" href="#fn.2">2</a></sup>, as <b>CARES</b> the major change has been the addition of the new real-time rater which <b>Amdocs</b> calls <b>Turbo Charging</b> that can handle both PRE and POST pay customers.<br  />
</p>
<ul class="org-ul">
<li>All interaction is done through the network interface.</li>
<li>All tables are now in memory to improve performance.</li>
<li>We can re-rate continuously by running re-rating in daemon mode.</li>
<li>We can rate in other units beside minutes like <b>Content, Volume, Qos</b>.</li>
<li>Rating can be by step or tiered.</li>
<li><b>Event flow:</b>
<ol class="org-ol">
<li>An event comes in to via a network element</li>
<li>Transforms data into a conical form which also includes the network element.</li>
<li>Gets Rated
<ul class="org-ul">
<li>For <b>Pre-Pay</b> the HLR<sup><a id="fnr.3" class="footref" href="#fn.3">3</a></sup>. is handled by the <b>SCP</b></li>
</ul></li>
<li>The response is sent back to the calling network element.</li>
</ol></li>
<li><b>International Calls</b> are rated to the country not the individual city/town.</li>
<li>Find that in <b>LD_COUNTRY_RATES</b> table.</li>
<li>For <b>Pre-Pay</b> roaming customers still get a record which needs to go through <b>CIBER</b> process.</li>
<li>Major problem for <b>CCMI</b>. It was decided to remove it but the <b>LERG</b> does not give us the granularity that we might need.</li>
<li>For <b>Pre-Pay</b> <b>MMS</b> we will not charge each recipient only the sender.</li>
<li>We convert everything to the <b>Home SID time</b> for bill presentment.</li>
<li>Limiting or <i>choking</i> usage can be handled by <b>Diameter</b> for real-time and <b>Turbo-Charging</b> for <b>Post-Pay</b></li>
</ul>
</body>
</html>
</richcontent>
<node ID="sec-3-2-1" CREATED="1468275705071" MODIFIED="1468275705071" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>RLC (Rating Logic configurator)
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
<ul class="org-ul">
<li>The <b>RLC</b> has a repository that keeps it rules as an <b>XML</b> string
in a <i>database column</i>.</li>
<li>Though they are stored as <b>XML</b> you can view them as <b>Product Catalog UI</b>.
<ul class="org-ul">
<li><b>Customer</b> defines set of attributes possibly having different values for different <b>customers/subscribers</b>.These attributes are further used in qualification criteria to define guiding to service functionality, and in event handlers to personalize pricing logic for specific customer/subscriber</li>
<li><b>Performance Indicator</b> defines set of attributes (counters) to keep accumulated usage for some specific pricing item Its attributes are used and modified by the event handlers logic.</li>
<li><b>Item Parameters</b> define a set of attributes that are the parameters of the Pricing Item Type Their values are set in the Product Catalog UI tool while creating a Pricing Item based on a given Pricing Item Type</li>
<li><b>External record</b> defines a set of attributes associated with a specific extract record layout.</li>
<li><b>Variables</b> define a set of attributes (variables) are used by handlers statements.</li>
</ul></li>
<li><b>PIT</b> <i>Pricing Item Type</i></li>
<li>We can define a number of different <b>Rating roles</b> and rating events.</li>
<li>Incoming calls are not dropped but instead are zero rated.</li>
</ul>
<ol class="org-ol"><li><a id="orgheadline79"></a>Configuration Tools<br  /><p>
The tool is a split screen application. On the left side contains
all the rating schemes which are then dragged and dropped to
create a tree structure on the right side.
</p>

<ul class="org-ul">
<li><b>RLC - Rating Logic configurator</b> <i>Used to configure the rating engine</i></li>
<li>Uses the <b>EPC</b> to create the rating logic, not the price
plans. Once your finished with the configurator you the compile
with the <b>ICC (Implementation Compiler configurator)</b> which
then creates C++ code thats added to the rater.</li>

<li><b>TCC (Turbo-Charging configurator)</b> - Used to configure the
Turbo-Charging rater.</li>

<li><b>Replenishment Manager</b> - Used for <b>Pre-Pay</b>.</li>
</ul></li></ol>
</body>
</html>
</richcontent>
</node>
<node LOCALIZED_STYLE_REF="AutomaticLayout.level,3" ID="sec-3-3" CREATED="1468275705071" MODIFIED="1468615441337"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AEM
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" BOLD="true"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
AEM gets the Turbo-Charging errors from the <b>APE1_REJECTED_EVENTS</b> table. For <b>A&amp;F</b> they are in the <b>EM1_RECORD</b> table. Since there are so many coulmns in the EM1_RECORD table we must limit are query's to the following columns.
<a href="docs/EM1%20Query's">EM1 Queries</a>
</p>
</body>
</html>
</richcontent>
</node>
</node>
<node ID="sec-3-4" CREATED="1468275705071" MODIFIED="1468275705071" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Production Servers/EpsMonitors
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
<ul class="org-ul">
<li><b>Batch1</b> - <b>kprl1batch.uscc.com (10.176.177.177)</b> 
<ul class="org-ul">
<li>/pkgbl01/inf/aimsys/prdwrk1/eps/monitors</li>
</ul></li>
<li><b>Batch2</b> - <b>kprl2batch.uscc.com (10.176.177.178)</b> 
<ul class="org-ul">
<li>/pkgbl02/inf/aimsys/prdwrk2/eps/monitors</li>
</ul></li>
<li><b>Batch3</b> - <b>kprl3batch.uscc.com (10.176.177.179)</b> 
<ul class="org-ul">
<li>/pkgbl03/inf/aimsys/prdwrk3/eps/monitors</li>
</ul></li>
<li><b>Batch4</b> &#x2013; <b>kprl6batch.uscc.com (10.176.181.123)</b></li>
<li><b>Event1</b> &#x2013; <b>kprl1event.uscc.com (10.176.181.116)</b></li>
<li><b>Event2</b> &#x2013; <b>kprl2event.uscc.com (10.176.181.117)</b></li>
<li><b>Event3</b> &#x2013; <b>kprl3event.uscc.com (10.176.181.118)</b></li>
<li><b>Event4</b> &#x2013; <b>kprl4event.uscc.com (10.176.181.119)</b></li>
<li><b>Event5</b> &#x2013; <b>kprl5event.uscc.com (10.176.181.120)</b></li>
<li><b>Event6</b> &#x2013; <b>kprl6event.uscc.com (10.176.181.121)</b></li>
</ul>
<ul class="org-ul">
<li><b>APRM</b> - <b>kprl1batch.uscc.com (10.176.177.179)</b>
<ul class="org-ul">
<li>/inf_nas/apm1/prod/aprmoper/eps/monitors</li>
</ul></li>
</ul>
</body>
</html>
</richcontent>
<node LOCALIZED_STYLE_REF="AutomaticLayout.level,3" ID="sec-3-5" CREATED="1468275705072" MODIFIED="1468615483273"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Event Servers
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" BOLD="true"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
There are multiple Event Servers which coresspond to bill cycle and run on the event servers.   
Their status can be viewed using the following query on the <b>PRDAF</b> database. 
</p>
<pre class="example">
SELECT * FROM ADJ3_JOBS_INST_CTRL WHERE JOB_NAME = 'ADJ1EVENTSRV';
</pre>
<p>
From the output if the column <b>event status = Y</b> then that particular server is in use. 
If your job requires an event server that is already in use you can change it to one that is not by using <b>SQL</b> below on the <b>PRDCUST</b> database logged in as <b>PRDOPRC</b>. 
</p>

<p>
In this example we are setting the job rec to run using the <b>ES_EOC1045</b> event server 
</p>

<pre class="example">
Update OP_APP_DATA set data = 'ES_EOC1045'
       where JOB_REC = '{Your Job Rec}' and field_seq_num = 1 
       and table_NAME IN ('ADJ1EVENTSRV');
</pre>
</body>
</html>
</richcontent>
</node>
<node LOCALIZED_STYLE_REF="AutomaticLayout.level,3" ID="sec-3-6" CREATED="1468275705072" MODIFIED="1468615551783"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Rerate Servers
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" BOLD="true"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
There are three <b>Rerate Servers</b> they are:
</p>
<ol class="org-ol">
<li><b>RRP_EOC1056</b></li>
<li><b>RRP_EOC1068</b></li>
<li><b>RRP_EOC1192</b></li>
</ol>
</body>
</html>
</richcontent>
</node>
</node>
<node ID="sec-3-7" CREATED="1468275705072" MODIFIED="1468275705072" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>OutCollect Operational Jobs (CIBER Processing)
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
<b>CIBER</b> files are a collection of roaming records, these can be
either a foreign carrier on our network or one of our customers
on another network. More succinctly there are two
types of roaming scenarios.
</p>
<ol class="org-ol">
<li><b>OutCollects</b> <br  /></li>
</ol>
<p>
Non-USCC customers using our network, eventually
   the records created become part of the <b>OutCollect</b> process.
</p>
<ol class="org-ol">
<li><b>InCollects</b> <br  />
USCC customers roaming on another carriers
network. These records are sent to Syniverse which in turn
sends them to us and become part of our <b>InCollect</b> process. All though InCollects come pre-rated they are still re-rated according to their plan.</li>
</ol>

<p>
The OutCollect process runs twice a day <b>1:00 a.m/p.m.</b>
</p>
<ul class="org-ul">
<li><b>OUTCOL</b> <br  />
Extracts from the <b>APE1_RATED_EVENT</b> table and creates files for <b>MAS</b>.</li>
<li><b>ADJ9MAS OUTCOL</b> <br  />
Creates files for <b>SPL1</b>.</li>
<li><b>SPL1</b> - <i>Daemon</i> <br  />
Processes files as it sees them and creates files for <b>RGD</b>.</li>
<li><b>RGD</b> - <i>Daemon</i> <br  />
Processes files as it sees them and creates files for <b>APP</b>.</li>
<li><b>APP</b> - <i>Daemon</i> <br  />
Processes files in RD after 12 hours of the last files processed. Output files for <b>Syniverse</b>.</li>
<li><b>MF9FTDTAX</b> <br  />
Loads data into <b>MF9_OUTCOL_TAXES</b> table</li>
<li><b>AR9OUTCLTAX</b> <br  /></li>
</ul>

<p>
End-day after <b>MF9FTDTAX</b>.
</p>
</body>
</html>
</richcontent>
<node ID="sec-3-7-1" CREATED="1468275705072" MODIFIED="1468275705072" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>OutCollect Files
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
These are the file that are created by <b>TOPS</b> that will be sent to <b>Syniverse</b>.
</p>
<ul class="org-ul">
<li><b>aprout (OutCollect Directory)</b> <br  /></li>
</ul>
<p>
<b>pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/apr/interfaces/output</b>
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-3-7-2" CREATED="1468275705072" MODIFIED="1468275705072" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Operational Tables
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
<ol class="org-ol"><li><a id="orgheadline80"></a><b>AC1_CONTROL</b><br  /><p>
The Outbound Syniverse files
</p>
<pre class="example">
select * from ac1_control
where nxt_pgm_name = 'CBRRPT'
and cur_pgm_name = 'APP'

FILE_NAME
---------
CIBER_CIBER_20130917090101_1312027_0001.dat
CIBER_CIBER_20131012092425_1237215_0013.dat
CIBER_CIBER_20130927090046_1027159_0012.dat
...
CIBER_CIBER_20131011211952_1237215_0012.dat
</pre></li>
<li><a id="orgheadline81"></a><b>MF1_CIBER_BATCH_SEQ</b><br  /><p>
Contain the CIBER batch sequence numbers <i>(See Database Section)</i>.
</p></li></ol>
</body>
</html>
</richcontent>
</node>
</node>
<node ID="sec-3-8" CREATED="1468275705072" MODIFIED="1468275705072" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Overage Protection
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
Overage notifications are detected on an event by event basis. As events are processed by <b>TC</b> and added to 
the <b>APE1_ACCUMULATORS</b> table a check is made against the <b>L9_FIRST_THRESHOLD/L9_SECOND_THRESHOLD</b> fields. If an overage is detected the <b><b><b>FIELD</b></b></b> CTN is added to file (segregated by unique <b>TC</b> file?) in the NTF directory. MFT then pulls these files and delivers to DMI for distribution. A note is added to the NOTIFICATION_HUB.SMS_NOTIFICATION table (ODS) indicating the message was sent by DMI.
</p>
</body>
</html>
</richcontent>
<node ID="sec-3-8-1" CREATED="1468275705072" MODIFIED="1468275705072" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Overage process flow
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
<div class="figure">
<p><img src="Pictures/overage.png" alt="overage.png" />
</p>
</div>
</body>
</html>
</richcontent>
</node>
<node ID="sec-3-8-2" CREATED="1468275705073" MODIFIED="1468275705073" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Output Location
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
<pre class="example">
select notif_desc, file_path from CM9_NOTIFICATION_DEF
where  FILE_PATH = '$ABP_APR_ROOT/interfaces/output/NTF'
and FILE_ALIAS = 'SMSNTF'
</pre>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>NOTIF_DESC</b></th>
<th scope="col" class="org-left"><b>FILE_PATH</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Overage cap notification on group level</td>
<td class="org-left">$ABP_APR_ROOT/interfaces/output/NTF</td>
</tr>

<tr>
<td class="org-left">Disclaimer notification on group level</td>
<td class="org-left">$ABP_APR_ROOT/interfaces/output/NTF</td>
</tr>

<tr>
<td class="org-left">Bucket notification on group level</td>
<td class="org-left">$ABP_APR_ROOT/interfaces/output/NTF</td>
</tr>
</tbody>
</table>

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />
</colgroup>
<tbody>
<tr>
<td class="org-left"><b>prdwrk1@kprl1batch:/pkgbl01/inf/aimsys/prdwrk1/var/usc/projs/apr/interfaces/output/NTF</b></td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node ID="sec-3-8-3" CREATED="1468275705073" MODIFIED="1468275705073" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Fields of Interest
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
S - SMS, M - MMS, V - Voice, D - Data, L - LTE =&gt; L3_CALL_SOURCE
</p>
</body>
</html>
</richcontent>
</node>
</node>
<node ID="sec-3-9" CREATED="1468275705073" MODIFIED="1468275705073" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Billing Process
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
The billing process follows a map which is created by the job <b>ADJ3_APR_CycleBillRun_Sh</b>. If it completes successfully it will create a billing map that will look something like the following:
</p>



<div class="figure">
<p><img src="Pictures/billing_tc_map-27124108.png" alt="billing_tc_map-27124108.png" />
</p>
</div>
</body>
</html>
</richcontent>
</node>
<node ID="sec-3-10" CREATED="1468275705073" MODIFIED="1468275705073" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Log File Location
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<node ID="sec-3-10-1" CREATED="1468275705073" MODIFIED="1468275705073" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Batch 1
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
<ul class="org-ul">
<li>cdlog - \//pkgbl01\//inf\//aimsys\//prdwrk1\//var\//usc\//log</li>
<li>A&amp;F | ssh prdwrk2@kpr02batch | MF1_MD_MD_USC</li>
<li>F2E | ssh prdwrk4@kpr02batch | ADJ1_File2E_Daemon_Shell_Sh_F2E</li>
</ul>
</body>
</html>
</richcontent>
</node>
</node>
<node ID="sec-3-11" CREATED="1468275705073" MODIFIED="1468275705073" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Alias
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
<ul class="org-ul">
<li><b>cdlog</b> - cd to the logfile directory.</li>
<li><b>cdswitch (Batch1 Only)</b> - cd to the switch directory.</li>
<li><b>aprout</b> - cd to the <b>CIBER</b> out directories.</li>
</ul>
</body>
</html>
</richcontent>
</node>
<node ID="sec-3-12" CREATED="1468275705073" MODIFIED="1468275705073" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Operational Terms and Definitions
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
<ul class="org-ul">
<li><b>Front-end Processes</b>
<ul class="org-ul">
<li><b>CRM:</b> Customer Relationship Manager
<ul class="org-ul">
<li><b>Smart Client Designer</b></li>
<li><b>ASCF Designer - Amdocs Smart Client Designer</b></li>
<li><b>APM - Amdocs Process manager</b></li>
</ul></li>
<li><b>RIM:</b>  Retail Interaction Manager
<ul class="org-ul">
<li><b>POS:</b> Point of sale provided by <b>Microtelecom</b></li>
<li><b>Pricing Studio</b></li>
<li><b>ASM Amdocs Security Module</b></li>
</ul></li>
</ul></li>
<li><b>Provisioning</b>
<ul class="org-ul">
<li><b>AM or AAM - Activation Manager:</b> Provision Tool
<ul class="org-ul">
<li><b>APM:</b> The Gui front end to <b>AM</b></li>
</ul></li>
</ul></li>
<li><b>Usage Acquisition and Rating</b>
<ul class="org-ul">
<li><b>A&amp;F</b> Acquisition and formatting</li>
<li><b>Turbo-Charging</b> Real-time rater
<ul class="org-ul">
<li><b>SCP</b> - Session Control Protocol</li>
</ul></li>
<li><b>MAF now called Acquisition and Formatting</b></li>
<li><b>AMC - Amdocs Monitoring and control</b></li>
<li><b>AEM - Amdocs Error Manager</b> <i>replaces EMS</i></li>
<li><b>RLC</b> - Rating Logic Configurator</li>
</ul></li>
<li><b>Billing</b>
<ul class="org-ul">
<li><b>Billing Configurator</b></li>
<li><b>Invoicing Configurator</b></li>
<li><b>Replenishment Manager</b></li>
<li><b>Designer Studio</b> <i>for bill layout</i></li>
<li><b>Pooling</b> - Everyone brings there services to be shared within
everyone in the pool. Pooling is customization.</li>
<li><b>Sharing</b> - A finite set of resources are set-up and everyone can
use it.</li>
<li><b>MRC - Monthly Recurring Charge</b></li>
</ul></li>
<li><b>Integration sub-systems</b>
<ul class="org-ul">
<li><b>AIF - Amdocs Integration Framework</b></li>
<li><b>\index{ASM}ASM - Amdocs Security Manager</b></li>
<li><b>APM - Amdocs Process Manager</b></li>
<li><b>MMI - Multimedia Integrator</b></li>
<li><b>OM - Order Manager</b></li>
<li><b>OMS - Order Management System</b></li>
</ul></li>
</ul>
</body>
</html>
</richcontent>
</node>
<node ID="sec-3-13" CREATED="1468275705074" MODIFIED="1468275705074" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Operational SQL
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<node ID="sec-3-13-1" CREATED="1468275705074" MODIFIED="1468275705074" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>TC Files by Physical File
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
<ul class="org-ul">
<li>phy_file_ident = {some identifier}
<a href="docs/Operational%20File%20Query">AC_CONTROL_HIST Query</a></li>
</ul>
</body>
</html>
</richcontent>
</node>
<node LOCALIZED_STYLE_REF="AutomaticLayout.level,3" ID="sec-5-5" CREATED="1468275705083" MODIFIED="1468615621391"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Incollect Voice CIBER
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" BOLD="true"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
<a href="docs/Ciber_Voice_Incollects.sql">Voice Operational SQL</a>
</p>
</body>
</html>
</richcontent>
</node>
<node LOCALIZED_STYLE_REF="AutomaticLayout.level,3" ID="sec-5-6" CREATED="1468275705083" MODIFIED="1468615635309"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Incollect Data CIBER
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" BOLD="true"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
<a href="docs/Ciber_Data_Incollects.sql">Data Operational SQL</a>
</p>
</body>
</html>
</richcontent>
</node>
</node>
<node ID="sec-3-14" CREATED="1468275705074" MODIFIED="1468275705074" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>TC Runbook
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
<a href="docs/AB%208%201%20-%20TC%208%201%20SP2%20-%20Run%20Book%20Core.pdf">TC Runbook Version 8.1</a>
</p>
</body>
</html>
</richcontent>
</node>
<node LOCALIZED_STYLE_REF="AutomaticLayout.level,2" ID="ID_1089218570" CREATED="1468275705119" MODIFIED="1469806205146"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Production Support - SUP1
</p>
</body>
</html>
</richcontent>
<edge WIDTH="8"/>
<node LOCALIZED_STYLE_REF="AutomaticLayout.level,3" ID="ID_1972547337" CREATED="1468275705119" MODIFIED="1468609055481"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Support Server
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" BOLD="true"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Accessed from Putty in <b>TOPS</b> Production Support Applications.
Should be able to login on with LAN ID and password (which is same as your LAN ID).
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>SERVER NAME</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Ksr01omsap.uscc.com</td>
</tr>

<tr>
<td class="org-left">ksr01bmrim.uscc.com</td>
</tr>

<tr>
<td class="org-left">ksr01csmap.uscc.com</td>
</tr>

<tr>
<td class="org-left">ksr01batch.uscc.com</td>
</tr>

<tr>
<td class="org-left">ksr01tiger.uscc.com</td>
</tr>

<tr>
<td class="org-left">ksr01aprma.uscc.com</td>
</tr>

<tr>
<td class="org-left">ksr01mcsap.uscc.com</td>
</tr>

<tr>
<td class="org-left">ksr01ebiap.uscc.com</td>
</tr>

<tr>
<td class="org-left">msr01esadm.uscc.com</td>
</tr>

<tr>
<td class="org-left">msr01esb01.uscc.com</td>
</tr>

<tr>
<td class="org-left">msr01esb02.uscc.com</td>
</tr>

<tr>
<td class="org-left">msr01wladm.uscc.com</td>
</tr>

<tr>
<td class="org-left">msr01wls01.uscc.com</td>
</tr>

<tr>
<td class="org-left">msr01wls02.uscc.com</td>
</tr>

<tr>
<td class="org-left">msr01web01.uscc.com</td>
</tr>

<tr>
<td class="org-left">msr01web02.uscc.com</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
<node LOCALIZED_STYLE_REF="AutomaticLayout.level,3" ID="ID_1450965879" CREATED="1468275705120" MODIFIED="1468609027112"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Development Servers
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" BOLD="true"/>
<edge STYLE="bezier" WIDTH="thin"/>
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

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Environment</b></th>
<th scope="col" class="org-right"><b>IP</b></th>
<th scope="col" class="org-left"><b>Hostname</b></th>
<th scope="col" class="org-left"><b>UserID</b></th>
<th scope="col" class="org-left"><b>Password</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">Development</td>
<td class="org-right">10.106.10.9</td>
<td class="org-left">mdr01bld01</td>
<td class="org-left">md1dbal1</td>
<td class="org-left"><i>password</i></td>
</tr>

<tr>
<td class="org-left">Testing</td>
<td class="org-right">10.106.10.9</td>
<td class="org-left">mdr01bld01</td>
<td class="org-left">d_medap</td>
<td class="org-left">Henry*123</td>
</tr>

<tr>
<td class="org-left">CallDump</td>
<td class="org-right">10.176.179.3</td>
<td class="org-left">kpr01scdap</td>
<td class="org-left">calldmp</td>
<td class="org-left">Henry*128</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>
</node>
<node LOCALIZED_STYLE_REF="AutomaticLayout.level,2" ID="sec-10" CREATED="1468275705124" MODIFIED="1470236134597"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Accounts Receivable
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Handles Finance, Payments and credits as well Collections. 
</p>
</body>
</html>
</richcontent>
<node LOCALIZED_STYLE_REF="AutomaticLayout.level,3" ID="sec-10-1" CREATED="1468275705124" MODIFIED="1470236154032"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR Basics
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<ul class="org-ul">
<li><b>Root Directory</b> - $ABP_AR_ROOT on kpr01batch</li>
<li><b>Collection Interface</b> - /pkgbl01/inf/aimsys/prdwrk1/var/usc/projs/cl/interfaces</li>
</ul>
</body>
</html>
</richcontent>
</node>
<node LOCALIZED_STYLE_REF="AutomaticLayout.level,3" ID="sec-10-2" CREATED="1468275705124" MODIFIED="1470236181232"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR Jobs and Deamons
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif"/>
<edge STYLE="bezier" WIDTH="thin"/>
<node ID="sec-10-2-1" CREATED="1468275705124" MODIFIED="1468275705124" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR1JRNLEXT
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
The Journal Extract process extracts to an output file all financial activities that occurred since the last run of this process.
</p>
<ul class="org-ul">
<li><b>LOG FILE</b> - AR1JRNLEXT.&lt;SYS_DATE&gt;.log</li>
<li><b>Output File</b> -</li>
<li><b>Script Name</b> - ar1_JrnlExtract_Sh</li>
</ul>
</body>
</html>
</richcontent>
</node>
<node ID="sec-10-2-2" CREATED="1468275705124" MODIFIED="1468275705124" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR1PYMRCT
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
</node>
<node ID="sec-10-2-3" CREATED="1468275705124" MODIFIED="1468275705124" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR1DDREQCRE
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
</node>
<node ID="sec-10-2-4" CREATED="1468275705124" MODIFIED="1468275705124" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR3GWLSTR
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
</node>
<node ID="sec-10-2-5" CREATED="1468275705124" MODIFIED="1468275705124" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR1PYMPOST
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
</node>
<node ID="sec-10-2-6" CREATED="1468275705124" MODIFIED="1468275705124" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR1DDFEDBCK
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
</node>
<node ID="sec-10-2-7" CREATED="1468275705124" MODIFIED="1468275705124" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR1INVRCT
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif" SIZE="14"/>
</node>
</node>
<node LOCALIZED_STYLE_REF="AutomaticLayout.level,3" ID="sec-10-3" CREATED="1468275705124" MODIFIED="1470236181276"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>End of Month
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
<a href="docs/AR%20EOM.sql">AR End Of Month - SQL</a>
</p>
<ul class="org-ul">
<li>Email List for Revenue Accounting</li>
<li>Revenue Not confirmed for cycles 24,26 and 28</li>
<li>Null GeoCodes</li>
<li>Query for the EOM</li>
</ul>
</body>
</html>
</richcontent>
</node>
<node LOCALIZED_STYLE_REF="AutomaticLayout.level,3" ID="sec-10-4" CREATED="1468275705125" MODIFIED="1470236181270"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Payment File
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
Once in a while payment files break due to either bad sequence numbers or format issues. For the most part you should tell Amdocs to put the file in CN status and have <b>Payment Control</b> to resend.
If the file is also out of sequence have payment control send it with a new sequence number. If the whole file fails, not just records, then have Payment Control send a new file with a new sequence number.
</p>
<pre class="example">
PaymentControl-ImportPaymentFiles@uscellular.com&gt;
</pre>
</body>
</html>
</richcontent>
</node>
<node LOCALIZED_STYLE_REF="AutomaticLayout.level,3" ID="sec-10-5" CREATED="1468275705125" MODIFIED="1470236181264"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR Reports
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<ul class="org-ul">
<li><b>LockBox</b>
<ul class="org-ul">
<li><i>File Location</i> : $ABP_AR_ROOT/interfaces/input/lockbox/MELL_PYM.*.csv</li>
</ul></li>
<li><b>AGTCASH</b>
<ul class="org-ul">
<li><i>File Location</i> : $ABP_AR_ROOT/interfaces/input/lockbox/ACP_PYM*.csv</li>
</ul></li>
<li><b>IMPCOL</b>
<ul class="org-ul">
<li><i>File Location</i> : $ABP_AR_ROOT/interfaces/input/lockbox/IMPCOL.PAY*.csv</li>
</ul></li>
<li><b>IMPEFT</b>
<ul class="org-ul">
<li><i>File Location</i> : $ABP_AR_ROOT/interfaces/input/lockbox/IMPEFT.PAY.*csv</li>
</ul></li>
<li><b>IMPPAY</b>
<ul class="org-ul">
<li><i>File Location</i> : $ABP_AR_ROOT/interfaces/input/lockbox/IMPPAY.PAY.*.csv</li>
</ul></li>
<li><b>Autopay Reports</b> \\ Both of these reports are derived after the above files have been processed.
<ul class="org-ul">
<li><b>Autopay_PostPaid</b>
<ul class="org-ul">
<li>Run both the expected and actual <b>SQL</b></li>
</ul></li>
<li><b>Autopay_PrePaid</b>
<ul class="org-ul">
<li>Run prepaid expected <b>SQL</b></li>
</ul></li>
</ul></li>
<li><b>ACH extract file</b> \\Check to see if the output report and <b>SQL</b> match.
<ul class="org-ul">
<li><i>File Location</i> : $ABP_AR_ROOT/interfaces/output/ACH.ar.DD_OUT*<br  /></li>
</ul></li>
</ul>
</body>
</html>
</richcontent>
</node>
<node LOCALIZED_STYLE_REF="AutomaticLayout.level,3" ID="sec-10-7" CREATED="1468275705128" MODIFIED="1470236181258"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Credit Cards
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif"/>
<edge STYLE="bezier" WIDTH="thin"/>
<node ID="sec-10-7-1" CREATED="1468275705128" MODIFIED="1468275705128" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AR9_CC_AUTH_LOG
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
Credit card transactions from the <b>TOPS</b> side.
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-10-7-2" CREATED="1468275705128" MODIFIED="1468275705128" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>CTLOG
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
Database from the microtelecom side.
</p>
</body>
</html>
</richcontent>
</node>
</node>
<node LOCALIZED_STYLE_REF="AutomaticLayout.level,3" ID="sec-10-9" CREATED="1468275705129" MODIFIED="1470236181252"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>GL Extracts
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
These are created via <b>APRM</b>.
</p>
</body>
</html>
</richcontent>
<node ID="sec-10-9-1" CREATED="1468275705129" MODIFIED="1468275705129" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>SAP Extracts
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
<ul class="org-ul">
<li>Business owner (3/15/2013): Diane Matulis</li>
<li>Transfer target: svc_mft_ops@babble.tds.local:~bosstven/glinty3t</li>
</ul>
</body>
</html>
</richcontent>
</node>
<node ID="sec-10-9-2" CREATED="1468275705129" MODIFIED="1468275705129" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>General Ledger - Incollect - USCSAPEXTRGL SAPIN
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
<ul class="org-ul">
<li>Job name: USCSAPEXTRGL SAPIN</li>
<li>Schedule: EOD</li>
<li>TWS Job name: PR-FINFN17-APRM_RMG_SAP_INCOLGENLEDGER</li>
<li>Transfer Date: 22nd of each month @ 12:00 am</li>
<li>SLA: 2 days</li>
<li>File name convention: GLINCY3YYYYMMDDHHMMSS</li>
<li>File location: ~aprmoper/var/usc/SAPGLEXTR/IN/</li>
</ul>
</body>
</html>
</richcontent>
</node>
<node ID="sec-10-9-3" CREATED="1468275705129" MODIFIED="1468275705129" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>General Ledger - Outcollect - USCSAPEXTRGL SAPOUT
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
<ul class="org-ul">
<li>Job name: USCSAPEXTRGL SAPOUT</li>
<li>Schedule: EOD</li>
<li>TWS Job name: PR-FINFN17-APRM_RMG_SAP_OUTCOLGENLEDGER</li>
<li>Transfer Date: 22nd of each month @ 12:00 am</li>
<li>SLA: 2 days</li>
<li>File name convention: GLOUTY3YYYYMMDDHHMMSS</li>
<li>File location: ~aprmoper/var/usc/SAPGLEXTR/RO/</li>
</ul>
</body>
</html>
</richcontent>
</node>
<node ID="sec-10-9-4" CREATED="1468275705129" MODIFIED="1468275705129" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Accrual EOM - Incollect - USCSAPEXTRGL ACCIN
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
<ul class="org-ul">
<li>Job name: USCSAPEXTRGL ACCIN</li>
<li>Schedule: EOD</li>
<li>TWS Job name: PR-FINFN17-APRM_RMG_SAP_INCOLGENLEDGER</li>
<li>Transfer Date: 1st of each month @ 12:00 am</li>
<li>SLA: End of day</li>
<li>File name convention: GLINCY4YYYYMMDDHHMMSS</li>
<li>File location: ~aprmoper/var/usc/SAPGLEXTR/IN/ 
<ul class="org-ul">
<li>Ex: /inf_nas/apm1/prod/aprmoper/var/usc/SAPGLEXTR/IN/GLINCY420130401005834</li>
</ul></li>
</ul>
</body>
</html>
</richcontent>
</node>
<node ID="sec-10-9-5" CREATED="1468275705129" MODIFIED="1468275705129" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Accrual EOM - Outcollect - USCSAPEXTRGL ACCOUT
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
<ul class="org-ul">
<li>Job name: USCSAPEXTRGL ACCOUT</li>
<li>Schedule: EOD</li>
<li>TWS Job name: PR-FINFN17-APRM_RMG_SAP_INCOLGENLEDGER</li>
<li>Transfer Date: 1st of each month @ 12:00 am</li>
<li>SLA: End of day</li>
<li>File name convention: GLOUTY4YYYYMMDDHHMMSS</li>
<li>File location: ~aprmoper/var/usc/SAPGLEXTR/RO/ 
<ul class="org-ul">
<li>Ex: /inf_nas/apm1/prod/aprmoper/var/usc/SAPGLEXTR/RO/GLOUTY420130401005834</li>
</ul></li>
</ul>
</body>
</html>
</richcontent>
</node>
<node ID="sec-10-9-6" CREATED="1468275705133" MODIFIED="1468275705133" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Intra-Company Roaming - USCSAPEXTRGL SAPIR
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
<ul class="org-ul">
<li>Job name: USCSAPEXTRGL SAPIR</li>
<li>Schedule: EOD</li>
<li>TWS Job name: PR-FINFN17-APRM_RMG_SAP_INCOLGENLEDGER</li>
<li>Transfer Date: 1st of each month @ 12:00 am</li>
<li>SLA: End of day</li>
<li>File name convention: GLINTY3YYYYMMDDHHMMSS</li>
<li>File location: ~aprmoper/var/usc/SAPGLEXTR/IR/ 
<ul class="org-ul">
<li>Ex: /inf_nas/apm1/prod/aprmoper/var/usc/SAPGLEXTR/IR/GLINTY320130401005834</li>
</ul></li>
</ul>
</body>
</html>
</richcontent>
</node>
</node>
<node LOCALIZED_STYLE_REF="AutomaticLayout.level,3" ID="sec-10-10" CREATED="1468275705133" MODIFIED="1470236181244"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Operational SQL
</p>
</body>
</html>
</richcontent>
<font NAME="SansSerif"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<p>
All of these scripts would be good monitor scripts.
<a href="docs/AR%20Operational.sql">AR Operational SQL</a>
</p>
<ul class="org-ul">
<li>Checks to see if all payment files have been processed.(<b>PRDCUST</b>)</li>
<li>Gateway Listener (<b>PRDCUST</b>)</li>
<li>More General stuff (<b>PRDCUST</b>)</li>
<li>Query for Batch Payments</li>
</ul>
</body>
</html>
</richcontent>
</node>
</node>
<node ID="sec-9-2" CREATED="1468275705124" MODIFIED="1468275705124" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>APRM Queries
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
<a href="docs/APRM%20Queries">AprmQuery.sql</a>
</p>
</body>
</html>
</richcontent>
</node>
<node TEXT="TC Oncall Daily Duties" ID="sec-4" CREATED="1468275705075" MODIFIED="1470254668911" COLOR="#0033ff" TEXT_SHORTENED="true">
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>
<node TEXT="Check the Web Monitors" ID="sec-4-1" CREATED="1468275705075" MODIFIED="1470336772785" COLOR="#00b439">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<node ID="sec-4-1-1" CREATED="1468275705075" MODIFIED="1468275705075" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Batch Tab
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
<ul class="org-ul">
<li>Open Remedy against Amdocs - Tier 2 Billing to restart the scripts when any of the Batch1, Batch2, Batch3, or APRM columns are missing indicating they are down.</li>
<li><p>
Open Remedy against Amdocs - Tier 2 Billing to restart the script when any of these scripts are red indicating they are down.<br  />
<b>Batch 1 APPS</b><br  />
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<tbody>
<tr>
<td class="org-left">Aged_reject_to_close_prdcust</td>
<td class="org-left">Up</td>
<td class="org-left">Jul23</td>
</tr>

<tr>
<td class="org-left">AnFReport</td>
<td class="org-left">Up</td>
<td class="org-left">Jul23</td>
</tr>

<tr>
<td class="org-left">BillingTasks</td>
<td class="org-left">Up</td>
<td class="org-left">Jul26</td>
</tr>

<tr>
<td class="org-left">cpni_auto</td>
<td class="org-left">Up</td>
<td class="org-left">Jul23</td>
</tr>

<tr>
<td class="org-left">ovpDmiRejectsWA</td>
<td class="org-left">Up</td>
<td class="org-left">Jul26</td>
</tr>

<tr>
<td class="org-left">ovpMonitorAuto</td>
<td class="org-left">Up</td>
<td class="org-left">Jul24</td>
</tr>
</tbody>
</table>
<p>
<b>Batch 2 APPS</b><br  />
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<tbody>
<tr>
<td class="org-left">af_fixer</td>
<td class="org-left">Up</td>
<td class="org-left">Jul27</td>
</tr>

<tr>
<td class="org-left">auto_error_handle_PRDUSG1</td>
<td class="org-left">Up</td>
<td class="org-left">Jul27</td>
</tr>

<tr>
<td class="org-left">auto_error_handle_PRDUSG2</td>
<td class="org-left">Up</td>
<td class="org-left">Jul27</td>
</tr>

<tr>
<td class="org-left">auto_error_handle_PRDUSG3</td>
<td class="org-left">Up</td>
<td class="org-left">Jul27</td>
</tr>

<tr>
<td class="org-left">auto_error_handle_PRDUSG4</td>
<td class="org-left">Up</td>
<td class="org-left">Jul27</td>
</tr>

<tr>
<td class="org-left">large_charge</td>
<td class="org-left">Up</td>
<td class="org-left">Jul27</td>
</tr>

<tr>
<td class="org-left">Log_Monitoring</td>
<td class="org-left">Up</td>
<td class="org-left">14:19</td>
</tr>

<tr>
<td class="org-left">pseudoCron</td>
<td class="org-left">Up</td>
<td class="org-left">Jul27</td>
</tr>

<tr>
<td class="org-left">pseudoCron1day</td>
<td class="org-left">Up</td>
<td class="org-left">Jul27</td>
</tr>
</tbody>
</table>
<p>
<b>Batch 2 Filesystem</b><br  />
</p>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-right" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left"><b>Folder</b></th>
<th scope="col" class="org-left"><b>Size</b></th>
<th scope="col" class="org-left"><b>Used</b></th>
<th scope="col" class="org-left"><b>Available</b></th>
<th scope="col" class="org-right"><b>Used</b></th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">/var</td>
<td class="org-left">1.9G</td>
<td class="org-left">267M</td>
<td class="org-left">1.6G</td>
<td class="org-right">15%</td>
</tr>

<tr>
<td class="org-left">/tmp</td>
<td class="org-left">5.7G</td>
<td class="org-left">1.8G</td>
<td class="org-left">3.6G</td>
<td class="org-right">34%</td>
</tr>

<tr>
<td class="org-left">/af</td>
<td class="org-left">9.4T</td>
<td class="org-left">2.1T</td>
<td class="org-left">7.4T</td>
<td class="org-right">23%</td>
</tr>

<tr>
<td class="org-left">/JP_FS</td>
<td class="org-left">5.9T</td>
<td class="org-left">2.8T</td>
<td class="org-left">3.2T</td>
<td class="org-right">47%</td>
</tr>
</tbody>
</table></li>
</ul>
</body>
</html>
</richcontent>
</node>
<node ID="sec-4-1-2" CREATED="1468275705075" MODIFIED="1468275705075" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Event Tab
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
<ul class="org-ul">
<li>Open Remedy against Amdocs - Tier 2 Billing to restart the scripts when any of the Event1 through Event6 columns are missing indicating they are down.</li>
<li>Open Remedy against Amdocs - Infra Environments to investigate available space when any of the File system % Used sections are red.</li>
</ul>
</body>
</html>
</richcontent>
</node>
<node ID="sec-4-1-3" CREATED="1468275705075" MODIFIED="1468275705075" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AC1 Control Tab
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
<ul class="org-ul">
<li>Open Remedy against Amdocs  for AF and stuck in IU or RD files when creation date and is less than current date.</li>
<li>Use the A&amp;F monitor report for &lt;MM/DD/YYYY&gt; and APRM monitor report for &lt;MM/DD/YYYY&gt; emails as supporting evidence, which run every hour.</li>
</ul>
</body>
</html>
</richcontent>
</node>
<node ID="sec-4-1-4" CREATED="1468275705075" MODIFIED="1468275705075" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>AEM Tab
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
<ul class="org-ul">
<li>Ignore &#x2013; monitor was turned off due a conflict with prepaid event transactions.</li>
</ul>
</body>
</html>
</richcontent>
</node>
<node ID="sec-4-1-5" CREATED="1468275705075" MODIFIED="1468275705075" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Other Tab
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
<ul class="org-ul">
<li>Open Remedy against Amdocs - Tier 2 Billing to check on going rerating when rows are in red for more than one day.</li>
</ul>
</body>
</html>
</richcontent>
</node>
</node>
<node ID="sec-4-2" CREATED="1468275705076" MODIFIED="1468275705076" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Check Overage Protection Monitor.
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
<ul class="org-ul">
<li>Go to the MPS mailbox and look for the Overage Notification Count for &lt;MM-DD-YYYY&gt; email.<br  />
When received with counts similar to these there are no issues.</li>
</ul>
<pre class="example">
Total Files: 42987
Total Records: 154323
75%: 84418
100%: 69830
Disclaimer: 60
Balance: 15
</pre>
<ul class="org-ul">
<li>When count are significantly low open a Sev 3 ticket against Amdocs.</li>
</ul>
<pre class="example">
Total Files: 2607
Total Records: 9458
75%: 5365
100%: 4092
Disclaimer: 0
Balance: 1
</pre>
<ul class="org-ul">
<li>Open a Sev 2 ticket against Amdocs when Overage Notification Count FAILED for &lt;MM-DD-YYYY&gt;! is received.
<ul class="org-ul">
<li>Call IS Support at 608-828-5812 to inform them of a Sev 2 or above ticket.</li>
<li>Escalate ticket in Remedy, call Amdocs T2.5 on call at 217-766-1979.</li>
<li>Email applicable teams the ticket number and description.</li>
</ul></li>
</ul>
<pre class="example">
To:  GSSUSCCTier25RA@amdocs.com
Cc:  USCDLISOps-BillingandAROperations@uscellular.com; MPS@uscellular.com
</pre>
</body>
</html>
</richcontent>
</node>
<node ID="sec-4-3" CREATED="1468275705076" MODIFIED="1468275705076" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Check .LOG file monitor.
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
<ul class="org-ul">
<li>Go to the MPS mailbox and look for the Log Monitoring Count for &lt;MM-DD-YYYY&gt; ! email</li>
<li>When received with No LOG files where found for  &lt;MM-DD-YYYY&gt; there are no issues.</li>
<li><p>
When received with "Log files found for &lt;MM-DD-YYYY&gt; Total Log Files:  &lt;XXXXXX&gt; open a sev 3 Remedy ticket against Amdocs.
</p>
<ul class="org-ul">
<li>Escalate ticket in Remedy, call Amdocs T2.5 on call at 217-766-1979.</li>
<li>Email applicable teams the ticket number and description.</li>
</ul>
<pre class="example">
To:  GSSUSCCTier25RA@amdocs.com
Cc:  USCDLISOps-BillingandAROperations@uscellular.com; MPS@uscellular.com
</pre></li>
</ul>
</body>
</html>
</richcontent>
</node>
<node ID="sec-4-4" CREATED="1468275705076" MODIFIED="1468275705076" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Check AC1_CONTROL Fixer Status.
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
<ul class="org-ul">
<li>Go to the MPS mailbox and look for the AC1_CONTROL Fixer Status emails.  There are two.  One at ~12:04AM and on at ~4:03AM.</li>
<li><p>
The output is similar to what is shown below.  The only action needed is when a Sid is removed other than <b>SIDS</b> 45696, 49697, and 49698.  When a Sid other than the aforementioned <b>SIDS</b> is removed open a Sev 4 Remedy against Inter-carrier Services, email the ticket number, description, and details to Zachary.Gutter@uscellular.com asking him to validate the Sid.
</p>

<pre class="example">
Results for the AC1_CONTROL Fixer:
</pre>

<pre class="example">
Fixed /pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/up/physical/
      switch/DIRI/SDIRI_FCIBER_ID000069_T20150802185115.DAT 
and replaced it with /pkgbl02/inf/aimsys/prdwrk2/var/usc/projs
      /up/physical/switch/DIRI/SDIRI_FCIBER_ID000069_T20150802185199
</pre>

<pre class="example">
Sid:  was removed
</pre>

<pre class="example">
There were 0 CIBER AF files with wr_rec_quantity of 2
</pre>

<pre class="example">
There were 0 out of sequence CIBER files
</pre>

<pre class="example">
There were 0 OutColllects files stuck IU and set to RD
</pre>

<pre class="example">
There were 0 File2E stuck IU/AF files and set to RD
</pre>

<pre class="example">
There were 0 Files stuck FR files and set to RD
</pre>

<pre class="example">
There were 21 ORG records updated at prdusg1c.ape1_subscriber_rerate
from num_of_rerate_tries=3 to 1
</pre>

<pre class="example">
There were 14 ORG records updated at prdusg2c.ape1_subscriber_rerate 
from num_of_rerate_tries=3 to 1
</pre>

<pre class="example">
There were 28 ORG records updated at prdusg3c.ape1_subscriber_rerate 
from num_of_rerate_tries=3 to 1
</pre>

<pre class="example">
There were 28 ORG records updated at prdusg4c.ape1_subscriber_rerate 
from num_of_rerate_tries=3 to 1
</pre></li>
</ul>
</body>
</html>
</richcontent>
</node>
<node ID="sec-4-5" CREATED="1468275705076" MODIFIED="1468275705076" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Check Large Charge monitor.
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
<ul class="org-ul">
<li>Go to the MPS mailbox and look for the Large Charge email.</li>
<li><p>
When the subject line is other than Large Charge Not Detected - No Action Required open a sev 3 Remedy against Amdocs.
</p>
<ul class="org-ul">
<li>Escalate ticket in Remedy, call Amdocs T2.5 on call at 217-766-1979.</li>
<li>Email applicable teams the ticket number and description.</li>
</ul>
<pre class="example">
To:  GSSUSCCTier25RA@amdocs.com
Cc:  USCDLISOps-BillingandAROperations@uscellular.com; MPS@uscellular.com
</pre></li>
</ul>
</body>
</html>
</richcontent>
<node ID="sec-4-5-1" CREATED="1468275705076" MODIFIED="1468275705076" COLOR="#990000"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>High Dollar Amount Recovery Procedure
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
<b>IMPORTANT :  High Dollar amounts must be reversed on the same day they are created.</b>
</p>
<ol class="org-ol">
<li>Amdocs OCCGMSCPSGUSCCBOPSAR@amdocs.com receives an internal alert indicating there is a high dollar amount issue.</li>
<li>Amdocs OCCGMSCPSGUSCCBOPSAR@amdocs.com calls the USC Billing On-Call Person from the daily Billing Priorities Email as soon as the alert is received.</li>
<li>Amdocs OCCGMSCPSGUSCCBOPSAR@amdocs.com sends an email to the USCDLISOps-BillingandAROperations@uscellular.com email distribution list within 1 hour of the initial internal alert.  This email contains:
<ul class="org-ul">
<li>FA/BAR</li>
<li>transaction_id</li>
<li>amount (e.g. charges_amount)</li>
<li>tax_amount</li>
<li>debit_id</li>
<li>l9_geo_cod</li>
<li>operator_id (associate id)</li>
<li>first_name</li>
<li>last_name</li>
<li>e_mail</li>
<li>employee_no</li>
<li>work_group</li>
</ul></li>
<li>USC forwards the Amdocs communication email to the following Financial Services email addresses within 1 hour of receiving the email communication from Amdocs: 
<ul class="org-ul">
<li>NFSC-TulsaResolutions@uscellular.com</li>
<li>NFSCMADFSHelpDesk@uscellular.com</li>
<li>Lane.Dohl@uscellular.com</li>
</ul></li>
<li>Financial Services reverses any incorrect transactions and replies to the email distribution list for USC and Amdocs.  If the process is successful, no further action is required.  If there are any other issues, further escalation is needed using our standard processes.  This escalation requires a Sev-3 ticket created and routed to the Amdocs Tier 2 Billing queue.</li>
</ol>
</body>
</html>
</richcontent>
</node>
</node>
<node ID="sec-4-6" CREATED="1468275705076" MODIFIED="1468275705076" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Check out of sequence CIBER records monitor.
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
<ul class="org-ul">
<li>Go to the MPS mailbox and look for the out of sequence CIBER records email.</li>
<li>When the subject line is other than No out of sequence CIBER records for &lt;YYYYMMDD&gt; open a sev 4 Remedy against Amdocs.
<ul class="org-ul">
<li>Email applicable teams the ticket number and description.</li>
</ul></li>
</ul>
<pre class="example">
To:  GSSUSCCTier25RA@amdocs.com
Cc:  USCDLISOps-BillingandAROperations@uscellular.com; MPS@uscellular.com
</pre>
</body>
</html>
</richcontent>
</node>
<node ID="sec-4-7" CREATED="1468275705076" MODIFIED="1468275705076" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Check Late Usage Processing
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
Follow the link below to see a query to find late usage for a given cycle.
<a href="file:///home/dbalchen/workspace/CommonPlace/docs/LateUsage.sql">Late Usage SQL</a>
</p>
</body>
</html>
</richcontent>
</node>
<node ID="sec-4-8" CREATED="1468275705076" MODIFIED="1468275705076" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>When Notified Nonfictions.
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
<ul class="org-ul">
<li>kpr01ebiap maintenance. 
<ul class="org-ul">
<li>Login to the EBI server with your LAN ID and password.</li>
<li>Check if AEM and KPI scripts are running.</li>
</ul></li>
</ul>
<pre class="example">
[md1dsmi1@kpr01ebiap eps]$ ps -ef | grep perl | grep md1dsmi1 | grep -v grep
md1dsmi1   16566       1  0 Jul30 ?        00:00:00 perl ./aem_purge_trending_split.pl 1 0
md1dsmi1 2345044       1  0 Jul28 ?        00:00:00 perl ./aem_error_trending_auto.pl
md1dsmi1 2345048       1  0 Jul28 ?        00:00:00 perl ./aem_purge_trending_auto.pl
md1dsmi1 2345050       1  0 Jul28 ?        00:00:00 perl ./em1_errors_trending_auto.pl
md1dsmi1 2345052       1  0 Jul28 ?        00:00:00 perl ./em1_errors_write_off_auto.pl
md1dsmi1 2345053       1  0 Jul28 ?        00:00:00 perl ./remedy_reports_auto.pl
md1dsmi1 2345054       1  0 Jul28 ?        00:00:43 perl ./tc_kpi_auto.pl 2 2 1 1
md1dsmi1 2345055       1  0 Jul28 ?        00:00:02 perl ./tc_kpi_datain_auto.pl 2 2 1 1
</pre>
<ul class="org-ul">
<li>Check if Business Report scripts are running.</li>
</ul>
<pre class="example">
[md1dsmi1@kpr01ebiap eps]$ ps -ef | grep MainLoop | grep -v grep
md1dsmi1 2188567       1  0 Jul28 ?        00:00:00 HS1H MainLoop - next: 
md1dsmi1 2188568       1  0 Jul28 ?        00:00:00 CancelLineIL MainLoop - next:
md1dsmi1 2188569       1  0 Jul28 ?        00:00:00 MADISON MainLoop - next: 
md1dsmi1 2188570       1  0 Jul28 ?        00:00:00 CancelLineWI MainLoop - next:
md1dsmi1 2188571       1  0 Jul28 ?        00:00:00 daily_counts MainLoop - next:
</pre>
</body>
</html>
</richcontent>
</node>
<node ID="sec-4-9" CREATED="1468275705077" MODIFIED="1468275705077" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Restart AEM and KPI scripts.
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
<ul class="org-ul">
<li>Login to the EBI server with your LAN ID and password.</li>
<li>cd to /home/common/eps/das</li>
<li>Run from the command line nohup ./StartAllErrorAndKPI.sh &amp;</li>
</ul>
</body>
</html>
</richcontent>
</node>
<node ID="sec-4-10" CREATED="1468275705078" MODIFIED="1468275705078" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Restart Business Report scripts.
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
<ul class="org-ul">
<li>Login to the EBI server with your LAN ID and password.</li>
<li>cd to /home/common/eps/reports</li>
<li>Run from the command line nohup ./StartAllReportCron.sh &amp;</li>
</ul>

<p>
Note all scripts use Dave Smith's LAN ID password and when the failure is due to the password being expired please notify him immediately and if he is out of the office wait until he returns to the office to reset his password and update the scripts.
</p>
</body>
</html>
</richcontent>
</node>
</node>
</node>
<node TEXT="CallDump" POSITION="right" ID="sec-11" CREATED="1468275705133" MODIFIED="1468609686497" COLOR="#0033ff">
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>
<node TEXT="Data Directories" ID="sec-11-1" CREATED="1468275705133" MODIFIED="1468609693255" COLOR="#00b439">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>
<richcontent TYPE="NOTE">

<html>
<head>
</head>
<body>
<ul class="org-ul">
<li><b>/m04/switchb/ecs</b> - <b>(aaa1)</b> 3G or lower data usage guide by <b>#19</b>.</li>
<li><b>/m06/switch/MMS</b> - Picture Messaging</li>
<li><b>/m06/switch/MMSText</b> - Picture Messaging Text only.</li>
<li><b>/m06/switch/sms_nsn</b> - SMS Motorola</li>
<li><b>/m06/switchb/sms_alu</b> - SMS ALU</li>
<li><b>/m04/switch/lte</b> - <b>(aaa3)</b> P-Gateway 4G usage</li>
<li><b>/m04/switchb/valista</b> - Premium SMS</li>
<li><b>/m05/switch/brew</b> - Brew and Brew data <b>(aaa2)</b></li>
<li><b>/m01/switchb/tas</b> - Volte</li>
</ul>
</body>
</html>
</richcontent>
</node>
<node ID="sec-11-2" CREATED="1468275705133" MODIFIED="1468275705133" COLOR="#00b439"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>WEDO (Switch to bill)
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
The <b>WEDO</b> process pulls usage files tar's them up and places them into a directory so that <b>MFT</b> can pick them up. The operational jobs are as follows:
</p>
<ol class="org-ol">
<li>Job PR-BOD-S2B_TO_WEDO is running this script: /m01/switch/to_wedo.sh</li>
<li>Job PR-BOD-S2B_CREATE_WEDO_ARCH is running this script: /m01/switch/wedo/create_wedo_archive.sh</li>
</ol>
</body>
</html>
</richcontent>
</node>
</node>
<node POSITION="left" ID="sec-12" CREATED="1468275705133" MODIFIED="1468610776866" COLOR="#0033ff"><richcontent TYPE="NODE">

<html>
<head>
</head>
<body>
<p>Telephone Numbers
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
    <table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">
      <colgroup>
      <col class="org-left"/>
      <col class="org-right"/>
      </colgroup>
      

      <tr>
        <th scope="col" class="org-left">
          <b>Name</b>
        </th>
        <th scope="col" class="org-right">
          <b>Cell</b>
        </th>
      </tr>
      <tr>
        <td class="org-left">
          Vanessa
        </td>
        <td class="org-right">
          608-441-7106
        </td>
      </tr>
      <tr>
        <td class="org-left">
          Alex
        </td>
        <td class="org-right">
          608-219-7641
        </td>
      </tr>
      <tr>
        <td class="org-left">
          Dexter
        </td>
        <td class="org-right">
          608-219-5832
        </td>
      </tr>
      <tr>
        <td class="org-left">
          Dr. Smith
        </td>
        <td class="org-right">
          608-263-7500
        </td>
      </tr>
      <tr>
        <td class="org-left">
          <p>
            CVS
          </p>
        </td>
        <td class="org-right">
          <p>
            608-836-6630
          </p>
        </td>
      </tr>
      <tr>
        <td class="org-left">
          Chuck
        </td>
        <td class="org-right">
          630-710-5201
        </td>
      </tr>
      <tr>
        <td class="org-left">
          Cindy
        </td>
        <td class="org-right">
          608-516-4539
        </td>
      </tr>
      <tr>
        <td class="org-left">
          Deb
        </td>
        <td class="org-right">
          312-810-1111
        </td>
      </tr>
      <tr>
        <td class="org-left">
          DC Operations
        </td>
        <td class="org-right">
          865-777-8771
        </td>
      </tr>
      <tr>
        <td class="org-left">
          Escalate Ticket
        </td>
        <td class="org-right">
          217-766-1979
        </td>
      </tr>
      <tr>
        <td class="org-left">
          Steve
        </td>
        <td class="org-right">
          608-222-5222
        </td>
      </tr>
      <tr>
        <td class="org-left">
          Ron W
        </td>
        <td class="org-right">
          651-734-8230
        </td>
      </tr>
      <tr>
        <td class="org-left">
          Paul Volpe
        </td>
        <td class="org-right">
          773-216-5606
        </td>
      </tr>
      <tr>
        <td class="org-left">
          Aunt Patty
        </td>
        <td class="org-right">
          256-772-7512
        </td>
      </tr>
      <tr>
        <td class="org-left">
          Help Desk:
        </td>
        <td class="org-right">
          608-828-5889
        </td>
      </tr>
      <tr>
        <td class="org-left">
          Soly
        </td>
        <td class="org-right">
          630-285-8386
        </td>
      </tr>
      <tr>
        <td class="org-left">
          Traci
        </td>
        <td class="org-right">
          630-285-8447
        </td>
      </tr>
    </table>
  </body>
</html>
</richcontent>
</node>
</node>
</map>
