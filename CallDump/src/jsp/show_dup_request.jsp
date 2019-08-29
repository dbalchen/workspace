<%@ taglib prefix="jstl-core" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>

<html><body>

<h3>Error in Creating Request: <%= request.getAttribute("message") %> </h3>
<h3><%= request.getParameter("request") %> </h3>

<table border="1" cellpadding="5">

	<tr>
		<th>Request</th>
		<th>Requestor</th>
		<th>Description</th>
	</tr>

	<jstl-core:forEach var="tempRecording" items="${dupkey}">
		<tr>
			<td> ${tempRecording.request} </td>
			<td> ${tempRecording.requestor} </td>
			<td> ${tempRecording.description} </td>
		</tr>
	</jstl-core:forEach>

</table>

</body>
</html>

