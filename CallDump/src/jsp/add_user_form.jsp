<%@ taglib prefix="jstl-core" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="html"
	uri="http://jakarta.apache.org/struts/tags-html"%>


<html>
<head>
<title>New User</title>
</head>

<body>
<h3>Add User</h3>
<hr>

<html:form method="post" action="/security/addUserForm">
	<table border="0">
		<tr>
			<td width="50">User</td>
			<td width="200"><html:text property="user" /> <em><font
				size="-2">(required)</font></em></td>
		</tr>
		<tr>
			<td>First Name</td>
			<td><html:text property="firstname" /> <em><font size="-2">(required)</font></em>
			</td>
		</tr>
		<tr>
			<td>Last Name</td>
			<td><html:text property="lastname" /> <em><font size="-2">(required)</font></em>
			</td>
		</tr>
		<tr>
			<td>E-Mail Address</td>
			<td><html:text property="emailaddress" /> <em><font
				size="-2">(required)</font></em></td>
		</tr>
		<tr>
			<td>Phone Number (no dashes or periods)</td>
			<td><html:text property="phone" /> <em><font size="-2">(required)</font></em>
			</td>
		</tr>
		<tr>
			<td width="50">Role</td>
			<td width="200"><html:select property="role">
				<html:options collection="rolekey" property="roleName"
					labelName="roleName" />
			</html:select></td>
			<td>
		</tr>
		<tr>
			<td width="300">User Priority (low number = high priority)</td>
			<td width="200"><html:select property="userpriority">
				<html:option value="0">0</html:option>
				<html:option value="1">1</html:option>
				<html:option value="2">2</html:option>
				<html:option value="3">3</html:option>
				<html:option value="4">4</html:option>	
				<html:option value="5">5</html:option>
				<html:option value="6">6</html:option>
				<html:option value="7">7</html:option>
				<html:option value="8">8</html:option>
				<html:option value="9">9</html:option>
			</html:select></td>
			<td>
		</tr>


	</table>
	<p><html:submit>Create User</html:submit> <html:reset>Clear</html:reset>
	</p>
</html:form>
<p>&nbsp;</p>
<!--<html:javascript formName="addUserForm"/>-->

</body>
</html>
