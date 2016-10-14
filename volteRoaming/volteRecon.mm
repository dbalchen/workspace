<map version="0.9.0">

<node COLOR="#000000">
<font NAME="SansSerif" SIZE="20"/>
<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Data Roaming Reconciliation
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#orgheadline1">1. Data Roaming Reconciliation Documentation <code>[0%]</code></a>
<ul>
<li><a href="#orgheadline2">1.1. Project Scope</a></li>
<li><a href="#orgheadline3">1.2. Assumptions</a></li>
<li><a href="#orgheadline4">1.3. User Requirements</a></li>
<li><a href="#orgheadline5">1.4. <span class="todo TODO">TODO</span> Process Decomposition <code>[25%]</code>&#xa0;&#xa0;&#xa0;<span class="tag"><span class="taskjuggler_project">taskjuggler_project</span></span></a></li>
<li><a href="#orgheadline6">1.5. Infrastructure Considerations</a></li>
<li><a href="#orgheadline7">1.6. Testing Approach</a></li>
<li><a href="#orgheadline8">1.7. Implementation Considerations</a></li>
</ul>
</li>
<li><a href="#orgheadline9">2. Communications Management</a>
<ul>
<li><a href="#orgheadline10">2.1. Communication Matrix</a></li>
</ul>
</li>
<li><a href="#orgheadline11">3. Issue Management</a>
<ul>
<li><a href="#orgheadline12">3.1. Issue Log</a></li>
</ul>
</li>
<li><a href="#orgheadline13">4. SOFTWARE CHANGES</a></li>
<li><a href="#orgheadline14">5. TEST CONDITIONS</a></li>
<li><a href="#orgheadline15">6. TEST EXECUTION RESULTS</a></li>
</ul>
</div>
</div>
</body>
</html>
</richcontent>
<node COLOR="#0033ff" ID="sec-1" POSITION="right" FOLDED="true">
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Data Roaming Reconciliation Documentation <code>[0%]</code>
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<ul class="org-ul">
<li class="off"><code>[&#xa0;]</code> Documentation</li>
<li class="off"><code>[&#xa0;]</code> Code</li>
<li class="off"><code>[&#xa0;]</code> Test</li>
<li class="off"><code>[&#xa0;]</code> Deploy</li>
</ul>
</body>
</html>
</richcontent>
<node COLOR="#00b439" ID="sec-1-1" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Project Scope
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
Create a reconciliation report that will be run both daily and monthly for all roaming data types.
To reconcile in both usage and revenue for all roaming (Incollect and Outcollects). 
</p>
</body>
</html>
</richcontent>
</node>

<node COLOR="#00b439" ID="sec-1-2" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Assumptions
</p>
</body>
</html>
</richcontent>
</node>

<node COLOR="#00b439" ID="sec-1-3" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>User Requirements
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
There will be a Daily and monthly report sent for each roaming type.
</p>
</body>
</html>
</richcontent>
<node COLOR="#990000" ID="sec-1-3-1" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="14"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Daily Report
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
<a href="docs/Settlement-416-515.xlsx">May CDMA Incollect Settlement Report</a>
</p>
</body>
</html>
</richcontent>
</node>

<node COLOR="#990000" ID="sec-1-3-2" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="14"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Monthly Report
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
&lt;Example Here&gt;
</p>
</body>
</html>
</richcontent>
</node>

</node>

<node COLOR="#00b439" ID="sec-1-4" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Process Decomposition <code>[25%]</code>
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<ul class="org-ul">
<li class="on"><code>[X]</code> OutCollects <code>[100%]</code>
<ul class="org-ul">
<li>[ ]Read Craigs Doc</li>
<li class="on"><code>[X]</code> Is there anything for voice or is it just data?</li>
<li class="on"><code>[X]</code> I believe</li>
</ul></li>
<li class="off"><code>[&#xa0;]</code> How do we plan to compare to Syniverse <code>[0%]</code>
<ul class="org-ul">
<li class="off"><code>[&#xa0;]</code> Will there be a job that reads the file then adds the information to the database.</li>
</ul></li>
<li class="off"><code>[&#xa0;]</code> Where does all the ARCM come in&#x2026;.</li>
<li class="off"><code>[&#xa0;]</code> Where does VOLTE and LTE in collects come into play.</li>
</ul>
</body>
</html>
</richcontent>
<node COLOR="#990000" ID="sec-1-4-1" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="14"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Analysis <code>[%]</code>
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<ol class="org-ol"><li><a id="orgheadline16"></a>Usage Types (Incollects) <code>[40%]</code><br  /><ul class="org-ul">
<li class="on"><code>[X]</code> CDMA Voice
<ul class="org-ul">
<li><b>Directory:</b> <i>/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/up/physical/switch/DIRI</i></li>
<li><b>Machine:</b> kpr02batch</li>
<li><b>Record Type:</b> CIBER</li>
</ul></li>
<li class="on"><code>[X]</code> CDMA Data
<ul class="org-ul">
<li><b>Directory:</b> <i>/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/up/physical/switch/DATACBR</i></li>
<li><b>Machine:</b> kpr02batch</li>
<li><b>Record Type:</b> CIBER</li>
</ul></li>
<li class="off"><code>[&#xa0;]</code> Volte
<ul class="org-ul">
<li><b>Directory:</b> <i>/m01/switchb/tas</i></li>
<li><b>Machine:</b> kpr01scdap</li>
<li><b>Record Type:</b> UFF</li>
</ul></li>
<li class="off"><code>[&#xa0;]</code> LTE
<ul class="org-ul">
<li><b>Directory</b>: <i>/m04/switch/lte</i></li>
<li><b>Machine:</b> kpr01scdap</li>
<li><b>Record Type:</b> UFF</li>
</ul></li>
<li class="off"><code>[&#xa0;]</code> GSM
<ul class="org-ul">
<li><b>Directory</b>: /pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/up/physical/GSMI (data)
<ul class="org-ul">
<li>../GSMI/gsmv/ (voice)</li>
<li>../GSMI/gsms/ (SMS)</li>
<li>../GSMI/gsmt/ (PMG)</li>
</ul></li>
<li><b>Machine:</b> kpr02batch</li>
<li><b>Record Type:</b> UFF</li>
</ul></li>
</ul></li>
<li><a id="orgheadline20"></a>System Flow<br  /><ol class="org-ol"><li><a id="orgheadline19"></a>ARCM<br  /><ol class="org-ol"><li><a id="orgheadline17"></a>Flow<br  /></li>
<li><a id="orgheadline18"></a>ARCM Tables<br  /></li></ol></li></ol></li>
<li><a id="orgheadline21"></a><span class="done DONE">DONE</span> Analyse Mediations Outcollect Process<br  /></li></ol>
</body>
</html>
</richcontent>
</node>

<node COLOR="#990000" ID="sec-1-4-2" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="14"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Development
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<ol class="org-ol"><li><a id="orgheadline22"></a>Create table<br  /><p>
Create the table using the spreadsheet as a reference.
<a href="docs/Settlement-416-515.xlsx">May CDMA Incollect Settlement Report</a>
</p>

<pre class="example">
CREATE TABLE table_name
( 
 column1 datatype [ NULL | NOT NULL ],
 column2 datatype [ NULL | NOT NULL ],
 column_n datatype [ NULL | NOT NULL ]
);
</pre></li>

<li><a id="orgheadline38"></a>Create SQL for each data type<br  /><ol class="org-ol"><li><a id="orgheadline25"></a><span class="todo TODO">TODO</span> Volte<br  /><ol class="org-ol"><li><a id="orgheadline23"></a>Incollect<br  /></li>
<li><a id="orgheadline24"></a>Outcollect<br  /></li></ol></li>
<li><a id="orgheadline28"></a><span class="todo TODO">TODO</span> LTE<br  /><ol class="org-ol"><li><a id="orgheadline26"></a>Incollect<br  /></li>
<li><a id="orgheadline27"></a>Outcollect<br  /></li></ol></li>
<li><a id="orgheadline31"></a><span class="done DONE">DONE</span> CDMA (AAA)<br  /><ol class="org-ol"><li><a id="orgheadline29"></a>Data Ciber Incollects (done)<br  /><p>
<a href="docs/CDMA_Data_Incollect.sql">Data Incollect SQL</a>
</p></li>
<li><a id="orgheadline30"></a>Data CIBER Outcollects (Talk to Craig)<br  /></li></ol></li>
<li><a id="orgheadline34"></a><span class="done DONE">DONE</span> Voice<br  /><ol class="org-ol"><li><a id="orgheadline32"></a>Incollects<br  /><p>
<a href="docs/CDMA_Voice_Incollect.sql">Voice Incollects SQL</a>
</p></li>
<li><a id="orgheadline33"></a>Outcollects<br  /></li></ol></li>
<li><a id="orgheadline37"></a><span class="todo TODO">TODO</span> GSM (Incollect Only)<br  /><ol class="org-ol"><li><a id="orgheadline35"></a>GSMV<br  /></li>
<li><a id="orgheadline36"></a>GSMD<br  /></li></ol></li></ol></li>
<li><a id="orgheadline39"></a>Coding<br  /></li>
<li><a id="orgheadline40"></a>Testing<br  /></li>
<li><a id="orgheadline41"></a>Contingency<br  /></li>

<li><a id="orgheadline43"></a>Executable<br  /><ol class="org-ol"><li><a id="orgheadline42"></a><i>Program Name</i><br  /><ul class="org-ul">
<li><b>Language:</b></li>
<li><b>Source Code Location:</b></li>
<li><b>Parameters:</b> <i>input and output</i></li>
<li><b>Description:</b></li>
</ul></li></ol></li></ol>
</body>
</html>
</richcontent>
</node>


<node COLOR="#990000" ID="sec-1-4-3" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="14"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Data Decomposition
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<ul class="org-ul">
<li><b>Table/Field Name:</b></li>
<li><b>Purpose of File/Table:</b></li>
<li><b>Type of Change:</b> <i>create new or modify existing</i></li>
<li><b>Description of Change:</b> <i>or reason for adding</i></li>
<li><b>Primary Keys and Indices:</b></li>
<li><b>Estimated Rows and Growth Rate:</b></li>
</ul>
<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Column/Field Name</th>
<th scope="col" class="org-left">Type</th>
<th scope="col" class="org-left">Values</th>
<th scope="col" class="org-left">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>


<node COLOR="#990000" ID="sec-1-4-4" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="14"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Schedule/Time Management
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<ul class="org-ul">
<li>Build Date
DEADLINE: <span class="timestamp-wrapper"><span class="timestamp">&lt;2016-12-18 Sun&gt;   </span></span></li>
<li>Planned Implimentation Date
DEADLINE: <span class="timestamp-wrapper"><span class="timestamp">&lt;2017-02-12 Sun&gt;</span></span></li>
</ul>
</body>
</html>
</richcontent>
</node>

<attribute NAME="taskjuggler_project" VALUE=""/>
</node>

<node COLOR="#00b439" ID="sec-1-5" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Infrastructure Considerations
</p>
</body>
</html>
</richcontent>
</node>

<node COLOR="#00b439" ID="sec-1-6" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Testing Approach
</p>
</body>
</html>
</richcontent>
</node>

<node COLOR="#00b439" ID="sec-1-7" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Implementation Considerations
</p>
</body>
</html>
</richcontent>
</node>

</node>

<node COLOR="#0033ff" ID="sec-2" POSITION="left" FOLDED="true">
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Communications Management
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
<i>[Insert the project's communication management plan or provide a reference to where it is stored.]</i>
</p>
</body>
</html>
</richcontent>
<node COLOR="#00b439" ID="sec-2-1" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Communication Matrix
</p>
</body>
</html>
</richcontent>
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

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Stakeholder</th>
<th scope="col" class="org-left">Messages</th>
<th scope="col" class="org-left">Vehicles</th>
<th scope="col" class="org-left">Frequency</th>
<th scope="col" class="org-left">Communicators</th>
<th scope="col" class="org-left">Feedback Mechanisms</th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>

</node>


<node COLOR="#0033ff" ID="sec-3" POSITION="right" FOLDED="true">
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Issue Management
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
<i>[Insert the project's issue management plan or provide a reference to where it is stored.]</i>
</p>
</body>
</html>
</richcontent>
<node COLOR="#00b439" ID="sec-3-1" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Issue Log
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
<i>[The Issue Log is normally maintained as a separate document. Provide a reference to where it is stored.]</i>
</p>
</body>
</html>
</richcontent>
</node>

</node>


<node COLOR="#0033ff" ID="sec-4" POSITION="left" FOLDED="true">
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>SOFTWARE CHANGES
</p>
</body>
</html>
</richcontent>
</node>

<node COLOR="#0033ff" ID="sec-5" POSITION="right" FOLDED="true">
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>TEST CONDITIONS
</p>
</body>
</html>
</richcontent>
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

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Test Cond Id</th>
<th scope="col" class="org-left">Module Tested</th>
<th scope="col" class="org-left">Condition Tested</th>
<th scope="col" class="org-left">Test Data - Specify Modifications</th>
<th scope="col" class="org-left">Expected Results</th>
<th scope="col" class="org-left">Actual Results</th>
<th scope="col" class="org-left">Revw'd By</th>
</tr>
</thead>
<tbody>
<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>
</body>
</html>
</richcontent>
</node>

<node COLOR="#0033ff" ID="sec-6" POSITION="left" FOLDED="true">
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>TEST EXECUTION RESULTS
</p>
</body>
</html>
</richcontent>
</node>

</node>
</map>
