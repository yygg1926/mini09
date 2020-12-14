<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }">
			�� ����
	</c:if>
	<c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
			<c:set var="menu" value="${menu }" scope="request"/>
			<a href="javascript:${requestScope.script }('${ resultPage.currentPage-1}')">�� ����</a>
	</c:if>
	
	<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">

		<c:set var="menu" value="${menu }" scope="request"/>
		<a href="javascript:${requestScope.script }('${ i }');">${ i }</a>
	</c:forEach>
	
	<c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
			���� ��
	</c:if>
	<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
			<c:set var="menu" value="${menu }" scope="request"/>
			<a href="javascript:${requestScope.script }('${resultPage.endUnitPage+1}')">���� ��</a>
	</c:if>