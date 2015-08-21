<%@ taglib prefix="jstl-core" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>


<html>
<head>
<title>Invalid Login Attempt</title>
</head>

<body>
<h3>Invalid Login Attempt</h3>
<hr>

<html:form method="post" action="/CheckPasswordStatus.do" onsubmit="return validateaddUserForm(this);">
<table border="0">
  <tr>
    <td width="50" >User</td>
    <td width="200">
      <html:text property="user"/> <em><font size="-2">(required)</font></em>
    </td>
  </tr>
  <tr>
    <td>Password</td>
    <td>
      <html:password property="password"/> <em><font size="-2">(required)</font></em>
    </td>
  </tr>
</table>
  <p>
    <html:submit></html:submit>
    <html:reset>Clear</html:reset>
  </p>
  </html:form>

</body>
</html>
