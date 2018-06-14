<%@ taglib prefix="html"
	uri="http://jakarta.apache.org/struts/tags-html"%>
<center>

	<p>
	<TABLE BGCOLOR="LIGHTBLUE" WIDTH=428 CELLSPACING=0 CELLPADDING=5
		BORDER=0>
		<br>
		<br>
		<br>
		<br>

		<form action="j_security_check" method="POST">
			<tr>
				<td colspan="2" align="center"><FONT FACE="Helvetica, Arial"
					SIZE="6"><b> Login </b><font></td>
			</tr>

			<tr>
				<td colspan="2"><hr size="1" noshade></td>
			</tr>
			<tr>
				<td align="right"><FONT FACE="Helvetica, Arial" size="3"><b>User
							ID</b></font></td>
				<td><input type="text" name="j_username" size="20"></td>
			</tr>

			<tr>
				<td align="right"><FONT FACE="Helvetica, Arial" size="3"><b>Password</b></font></td>
				<td><input type="password" name="j_password" size="20"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">Read Only:</td>
			</tr>
			<tr>
				<td colspan="2" align="center">login: <i>guest</i> password: <i>guest</i><br></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit"
					value="Login"><input type="reset" value="Clear"></td>

			</tr>
			<tr>
				<td colspan="2" align="center"><html:link
						page="/showPasswordReminderForm.do" target="_blank">Forgot Password</html:link></font><br></td>
			</tr>

		</form>

	</TABLE>

</center>

</body>
<%@ include file="../jsp/trailer.jsp"%>
