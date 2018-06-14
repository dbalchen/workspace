<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="html"
	uri="http://jakarta.apache.org/struts/tags-html"%>

<hr>
<table width="100%">
	<td width="14%" align="center"><html:link
			page="/view/showCallDumpRequests.do?status=NOCO&start=0&end=5"
			target="_self">Show Requests</html:link></td>
	<td width="20%" align="center"><html:link
			page="/view/showCallDumpRequests.do?status=CO&start=0&end=5&restrict=none&timeframe=99999"
			target="_self">Show Completed Requests</html:link></td>
	<td width="14%" align="center"><html:link
			page="/submitter/ShowCallDumpSubmitForm.do" target="_self">Submit CallDump</html:link>
	</td>
	<td width="14%" align="center"><html:link
			page="/security/ShowAddUserForm.do?app=calldump" target="_self">Create User</html:link>
	</td>
	<td width="14%" align="center"><html:link
			page="/security/ShowUsersAction.do" target="_self">Show Users</html:link>
	</td>
	<td width="14%" align="center"><html:link
			page="/help/calldump.html" target="_blank">Help</html:link></td>
	<td width="14%" align="center"><html:link page="/logoutSession.do"
			target="_self">Logout</html:link></td>
</table>
<hr>
