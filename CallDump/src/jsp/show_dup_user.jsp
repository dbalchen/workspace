<%@ taglib prefix="html"
	uri="http://jakarta.apache.org/struts/tags-html"%>

<html>
<body>

	<h1>Duplicate User:</h1>
	<br> UserID:
	<%= request.getParameter("user") %>
	<br> First :
	<%= request.getParameter("firstname") %>
	<br> Last :
	<%= request.getParameter("lastname") %>
	<br>
	<br> Press BACK button on browser to correct and retry.
</body>
</html>

