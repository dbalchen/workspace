<%@ taglib prefix="jstl-core" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<html><body>
<%@ include file="header.jsp"%>
<%@ include file="menu.jsp"%>

<table align="center" bordercolor="black" border="2" cellpadding="5" cellspacing="1px" frame="box" rules="none">

	<tr bgcolor="#000066">
		<th><FONT COLOR="white" FACE="courier" SIZE="2">UserID</th>
		<th><FONT COLOR="white" FACE="century" SIZE="2">First </th>
		<th><FONT COLOR="white" FACE="century" SIZE="2">Last</th>
		<th><FONT COLOR="white" FACE="century" SIZE="2">Email Address</th>
		<th><FONT COLOR="white" FACE="century" SIZE="2">Current</th>
		<th><FONT COLOR="white" FACE="century" SIZE="2">Status</th>
		<th><FONT COLOR="white" FACE="century" SIZE="2">Roles</th>
	</tr>
	<jstl-core:forEach var="userlist" items="${userskey}">
		<tr bgcolor="${userlist.util}">
			<td><FONT FACE="century" SIZE="2">${userlist.userId} </td>
			<td><FONT FACE="century" SIZE="2">${userlist.firstName} </td>
			<td><FONT FACE="century" SIZE="2">${userlist.lastName} </td>
			<td><FONT FACE="century" SIZE="2">${userlist.emailAddress} </td>
			<td><FONT FACE="century" SIZE="2">${userlist.status} </td>
            <td><FONT FACE="century" SIZE="2"><html:link page="/security/ChangeUserStatus.do?id=${userlist.userId}&status=${userlist.status}" target="_self">Change</html:link></font></td>
            <td><FONT FACE="century" SIZE="2"><html:link page="/security/ShowUserRoleUpdate.do?user=${userlist.userId}" target="_self">Edit</html:link></font></td>
		</tr>
	</jstl-core:forEach>
</table>

</body>
</html>

