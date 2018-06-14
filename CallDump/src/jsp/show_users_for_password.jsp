<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="html"
	uri="http://jakarta.apache.org/struts/tags-html"%>

<html>
<body>
	<meta http-equiv="refresh" content="60">
	<h3>Password Reminder</h3>

	<table border="1" cellpadding="4" cellspacing="1px">

		<tr>
			<td width="50">User</td>
			<td width="200"><html:select property="user">
					<html:options collection="userkey" property="UserName"
						labelName="UserName" />
				</html:select></td>
		</tr>

	</table>

</body>
</html>

