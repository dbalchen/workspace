<%@ taglib prefix="jstl-core" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="html"
	uri="http://jakarta.apache.org/struts/tags-html"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<body>
	<%@ include file="header.jsp"%>
	<%@ include file="menu.jsp"%>
	<center>
		<h2>
			User Roles for :
			<%= request.getParameter("user") %>
		</h2>


		<table bordercolor="black" width="30%" border="2">
			<tr bgcolor="#000066">
				<th><FONT COLOR="white" FACE="courier" SIZE="2"> Role </FONT></th>
				<th><FONT COLOR="white" FACE="courier" SIZE="2"> Next
						Action </FONT></th>
			</tr>
			<c:forEach items="${availablerolekey}" var="tempRecording">
				<tr>
					<td align="left"><FONT FACE="courier" SIZE="2"><c:out
								value="${tempRecording.roleName}" /> </FONT></td>
					<td><FONT FACE="century" SIZE="2"><html:link
								page="/security/AddUserRoleAction.do?user=${tempRecording.userid}&role=${tempRecording.roleName}"
								target="_self">Add Role</html:link> </FONT></td>
				</tr>
			</c:forEach>

			<c:forEach items="${curroleskey}" var="tempRecording">
				<tr>
					<td align="left"><FONT FACE="courier" SIZE="2"><c:out
								value="${tempRecording.roleName}" /> </FONT></td>
					<td><FONT FACE="century" SIZE="2"><html:link
								page="/security/RemoveUserRoleAction.do?user=${tempRecording.userid}&role=${tempRecording.roleName}"
								target="_self">Remove Role</html:link> </FONT></td>

				</tr>
			</c:forEach>

		</table>
	</center>
	<%@ include file="trailer.jsp"%>