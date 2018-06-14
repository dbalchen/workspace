<%@ taglib prefix="html"
	uri="http://jakarta.apache.org/struts/tags-html"%>

<html>
<body>

	<h1>User Added Successfully:</h1>
	<br> UserID:
	<%= request.getParameter("user") %>
	<br> First :
	<%= request.getParameter("firstname") %>
	<br> Last :
	<%= request.getParameter("lastname") %>
	<br> Email :
	<%= request.getParameter("emailaddress") %>
	<br> Role :
	<%= request.getParameter("role") %>
	<br>

</body>
</html>

