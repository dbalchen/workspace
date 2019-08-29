<%@ taglib prefix="jstl-core" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>


<html>
<head>
<title>Build Request</title>
</head>

<body>
<h3>Password Reminder</h3>
<hr>

<html:form method="post" action="/sendPasswordReminderAction">
<table border="0">
  <tr>
    <td width="200" >User</td>
    <td width="200">
      <html:text property="user"/> <em><font size="-2">(required)</font></em>
    </td>
  </tr>
</table>
  <p>
    <html:submit>Submit Request</html:submit>
    <html:reset>Clear</html:reset>
  </p>
  </html:form>
<p>&nbsp; </p>
</body>
</html>
