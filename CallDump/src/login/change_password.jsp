<%@ taglib prefix="jstl-core" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>


<html>
<head>
<title>Password Expired: Change Password</title>
</head>

<body>
<h3>Password Expired: Change Password</h3>
<h3> <% request.getAttribute("message"); %>
<hr>

<html:form method="post" action="/ChangePasswordAction.do" onsubmit="return validateaddUserForm(this);">
<table border="0">
  <tr>
    <td width="50" >User</td>
    <td width="200">
      <html:text property="user"/> <em><font size="-2">(required)</font></em>
    </td>
  </tr>
  <tr>
    <td>Old Password</td>
    <td>
      <html:password property="old_password"/> <em><font size="-2">(required)</font></em>
    </td>
  </tr>
  <tr>
    <td>New Password</td>
    <td>
      <html:password property="new_password"/> <em><font size="-2">(required)</font></em>
    </td>
  </tr>
  <tr>
    <td>Confirm New Password</td>
    <td>
      <html:password property="confirm_new_password"/> <em><font size="-2">(required)</font></em>
    </td>
  </tr>
</table>
  <p>
    <html:submit>Change Password</html:submit>
    <html:reset>Clear</html:reset>
  </p>
  </html:form>
<p>&nbsp; </p>
<html:javascript formName="ChangePasswordForm"/>

</body>
</html>
