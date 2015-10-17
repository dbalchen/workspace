<%@ taglib prefix="jstl-core" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<html><body>
<%@ include file="header.jsp"%>
<%@ include file="menu.jsp"%>


<br>
<br>
<center>
<h1> Error:  <%= request.getAttribute("errormsg") %> </h1>

<br>
<FORM><INPUT TYPE="button" VALUE="Back" onClick="history.go(-1);return true;"> </FORM>
</center>
<%@ include file="trailer.jsp"%>
