<%@ taglib prefix="jstl-core" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="html"
	uri="http://jakarta.apache.org/struts/tags-html"%>
<html>
<body>
	<%@ include file="header.jsp"%>
	<%@ include file="menu.jsp"%>

	<table align="center" bordercolor="black" border="2" cellpadding="5"
		cellspacing="1px" frame="box" rules="none">

		<tr bgcolor="#00006">
			<th><FONT COLOR="white" FACE="courier" SIZE="2">Id</th>
			<% if (!(request.getParameter("status")).equalsIgnoreCase("CO")) { %>
			<th><FONT COLOR="white" FACE="century" SIZE="2">Prty </th>
			<% } %>
			<th><FONT COLOR="white" FACE="century" SIZE="2">Submitted</th>
			<% if ((request.getParameter("status")).equalsIgnoreCase("CO")) { %>
			<th><FONT COLOR="white" FACE="century" SIZE="2">Submit
					Date</th>
			<% } %>

			<th><FONT COLOR="white" FACE="century" SIZE="2">Start
					Time</th>
			<th><FONT COLOR="white" FACE="century" SIZE="2">End Time</th>
			<th><FONT COLOR="white" FACE="century" SIZE="2">Search</th>
			<th><FONT COLOR="white" FACE="century" SIZE="2">Switches</th>

			<% if (request.isUserInRole("calldumpadmin")) { %>
			<% if (!(request.getParameter("status")).equalsIgnoreCase("CO")) { %>
			<th><FONT COLOR="white" FACE="century" SIZE="2">R</th>
			<th><FONT COLOR="white" FACE="century" SIZE="2">L</th>
			<th><FONT COLOR="white" FACE="century" SIZE="2">C</th>
			<th><FONT COLOR="white" FACE="century" SIZE="2">D</th>
			<%   } %>
			<%   } %>
			<% if ((request.getParameter("status")).equalsIgnoreCase("CO")) { %>
			<th><FONT COLOR="white" FACE="century" SIZE="2">Reports</th>
			<% } %>
		</tr>
		<jstl-core:forEach var="cdlist" items="${calldumpkey}">
			<tr bgcolor="${cdlist.color}">
				<td valign="top"><FONT FACE="century" SIZE="1">${cdlist.id}</td>
				<% if (!(request.getParameter("status")).equalsIgnoreCase("CO")) { %>
				<td valign="top"><FONT FACE="century" SIZE="1">${cdlist.priority}</td>
				<% } %>
				<td valign="top"><FONT FACE="century" SIZE="1">${cdlist.submitName}</td>
				<% if ((request.getParameter("status")).equalsIgnoreCase("CO")) { %>
				<td valign="top"><FONT FACE="century" SIZE="1">${cdlist.submitDate}</td>
				<% } %>
				<td valign="top"><FONT FACE="century" SIZE="1">${cdlist.startDate}</td>
				<td valign="top"><FONT FACE="century" SIZE="1">${cdlist.endDate}</td>
				<td valign="top"><FONT FACE="century" SIZE="1">
						${cdlist.searchString1}<br> ${cdlist.searchString2}<br>
						${cdlist.searchString3}<br> ${cdlist.searchString4}<br>
						${cdlist.searchString5}<br> ${cdlist.searchString6}<br></td>
				<td><FONT FACE="century" SIZE="1"> M01:
						${cdlist.switchesM01} <br> M02: ${cdlist.switchesM02} <br>
						M03: ${cdlist.switchesM03} <br> M04: ${cdlist.switchesM04} <br>
						M05: ${cdlist.switchesM05} <br> M06: ${cdlist.switchesM06} <br>
						Data: ${cdlist.switchesData}<br></td>
				<% if (request.isUserInRole("calldumpadmin")) { %>
				<% if (!(request.getParameter("status")).equalsIgnoreCase("CO")) { %>
				<td valign="top"><FONT COLOR="white" FACE="century" SIZE="2"><html:link
							page="/calldumpadmin/RaisePriority.do?id=${cdlist.id}">&#8593</html:link></font></td>
				<td valign="top"><FONT COLOR="white" FACE="century" SIZE="2"><html:link
							page="/calldumpadmin/LowerPriority.do?id=${cdlist.id}">&#8595</html:link></font></td>
				<td valign="top"><FONT COLOR="white" FACE="century" SIZE="2"><html:link
							page="/calldumpadmin/ChangeStatus.do?id=${cdlist.id}&status=${cdlist.nextStatus}">&#8711</html:link></font></td>
				<td valign="top"><FONT COLOR="white" FACE="century" SIZE="2"><html:link
							page="/calldumpadmin/RemoveCallDump.do?id=${cdlist.id}">&#8709</html:link></font></td>
				<% } %>
				<% } %>

				<% if ((request.getParameter("status")).equalsIgnoreCase("CO")) { %>
				<td valign="top"><FONT COLOR="white" FACE="century" SIZE="2"><html:link
							page="/view/getCallDumpReports.do?id=${cdlist.id}">Retrieve</html:link></font></td>
				<% } %>
			</tr>
		</jstl-core:forEach>

	</table>

	<% if ((request.getParameter("status")).equalsIgnoreCase("CO")) { %>
	<table align="center" width="60%" border="0" cellpadding="5"
		cellspacing="1px" frame="box" rules="none">
		<tr>
			<td align="center">Filter:</></td>
			<td align="center"><html:link
					page="/view/showCallDumpRequests.do?status=CO&start=1&end=5&restrict=none"
					target="_self">All Requests</html:link></td>
			<td align="center"><html:link
					page="/view/showCallDumpRequests.do?status=CO&start=1&end=5&restrict=user"
					target="_self">User Requests</html:link></td>
			<% if ((request.getParameter("restrict")!=null) && (request.getParameter("restrict").equalsIgnoreCase("user"))) { %>
			<td align="center"><html:link
					page="/view/showCallDumpRequests.do?status=CO&start=1&end=5&restrict=user&timeframe=1"
					target="_self">Last Day</html:link></td>
			<td align="center"><html:link
					page="/view/showCallDumpRequests.do?status=CO&start=1&end=5&restrict=user&timeframe=7"
					target="_self">Last Week</html:link></td>
			<td align="center"><html:link
					page="/view/showCallDumpRequests.do?status=CO&start=1&end=5&restrict=user&timeframe=31"
					target="_self">Last Month</html:link></td>
			<td align="center"><html:link
					page="/view/showCallDumpRequests.do?status=CO&start=1&end=5&restrict=user&timeframe=365"
					target="_self">Last Year</html:link></td>
			<% } else {%>
			<td align="center"><html:link
					page="/view/showCallDumpRequests.do?status=CO&start=1&end=5&restrict=none&timeframe=1"
					target="_self">Last Day</html:link></td>
			<td align="center"><html:link
					page="/view/showCallDumpRequests.do?status=CO&start=1&end=5&restrict=none&timeframe=7"
					target="_self">Last Week</html:link></td>
			<td align="center"><html:link
					page="/view/showCallDumpRequests.do?status=CO&start=1&end=5&restrict=none&timeframe=31"
					target="_self">Last Month</html:link></td>
			<td align="center"><html:link
					page="/view/showCallDumpRequests.do?status=CO&start=1&end=5&restrict=none&timeframe=365"
					target="_self">Last Year</html:link></td>
			<% } %>
		</tr>
	</table>

	<% } %>

	<table align="center" width="15%" border="0" cellpadding="5"
		cellspacing="1px" frame="box" rules="none">
		<tr>
			<% if (request.getAttribute("prevendkey")!=null) { %>
			<jstl-core:forEach var="cdlist" items="${navkey}">
				<td align="center"><html:link
						page="/view/showCallDumpRequests.do?status=${cdlist.status}&timeframe=${cdlist.timeframe}&restrict=${cdlist.restrict}&start=${cdlist.prevstartkey}&end=${cdlist.prevendkey}"
						target="_self">
						<img src="../images/bkwd.gif" border="0" />
					</html:link></td>
			</jstl-core:forEach>
			<% } %>
			<% if (request.getAttribute("nextendkey")!=null) { %>
			<jstl-core:forEach var="cdlist" items="${navkey}">
				<td align="center"><html:link
						page="/view/showCallDumpRequests.do?status=${cdlist.status}&timeframe=${cdlist.timeframe}&restrict=${cdlist.restrict}&start=${cdlist.nextstartkey}&end=${cdlist.nextendkey}"
						target="_self">
						<img src="../images/fwd.gif" border="0" />
					</html:link></td>
			</jstl-core:forEach>
			<% } %>
		</tr>
	</table>
</body>
</html>

