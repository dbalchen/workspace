<%@ taglib prefix="jstl-core" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="html"
	uri="http://jakarta.apache.org/struts/tags-html"%>


<html>
<head>
<title>Change Password</title>
</head>

<body>
	<h3>Change Password</h3>
	<h3>
		Message:
		<%= request.getAttribute("message") %><br>
	</h3>
	<html:link page="/docs/policies.html" target="_new">Password Policies</html:link>
	<br>
	<hr>

	<html:form method="post" action="/ChangePasswordAction">
		<table border="0">
			<tr>
				<td width="200">User</td>
				<td width="200"><html:text property="user" /> <em><font
						size="-2">(required)</font></em></td>
			</tr>
			<tr>
				<td width="200">Old Password</td>
				<td width="200"><html:password property="old_password" /> <em><font
						size="-2">(required)</font></em></td>
			</tr>
			<tr>
				<td width="200">New Password</td>
				<td width="200"><html:password property="new_password" /> <em><font
						size="-2">(required)</font></em></td>
			</tr>
			<tr>
				<td width="200">Confirm Password</td>
				<td width="200"><html:password property="confirm_new_password" />
					<em><font size="-2">(required)</font></em></td>
			</tr>
		</table>
		<p>
			<html:submit>Change Password</html:submit>
			<html:reset>Clear</html:reset>
		</p>
	</html:form>
	<p>&nbsp;</p>
</body>
</html>
