<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>




<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

function fncGetPurchaseList(currentPage){
	document.getElementById("currentPage").value = currentPage;

	document.detailForm.submit();
}

$(function(){
	
	<c:set var="i" value="0"/>
		<c:forEach var="purchase" items="${list }">
				
		$($(".ct_list_pop td:nth-child(1)")[${i}]).css('color', 'red').on("click", function(){
			
			
			self.location ="/purchase/getPurchase?tranNo="+$($(".ct_list_pop td:nth-child(1)")[${i}]).attr("class");
					//$(".ct_list_pop td:nth-child(3)").text().trim();
				
			
		});
		
		$($(".ct_list_pop td:nth-child(3)")[${i}]).css('color', 'red').on("click", function(){
			
			
			self.location ="/user/getUser?menu=search&userId="+$($(".ct_list_pop td:nth-child(3)")[${i}]).attr("class");
					//$(".ct_list_pop td:nth-child(3)").text().trim();
				
			
		});
		
		<c:set var="i" value="${i+1 }"/>
		</c:forEach>
	
	$("td:contains('물건도착')").on("click", function(){
		
		self.location ="/purchase/updateTranCode?tranCode=2&prodNo="+$(this).attr("class");
	});
});
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/purchase/listPurchase?menu=${menu }" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매 목록조회 </td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">전화번호</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">정보수정</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>

	<c:set var="i" value="0"/>
	<c:forEach var="purchase" items="${list }">
	<c:set var="i" value="${i+1 }"/>
	<tr class="ct_list_pop">
		<td align="center" class=${purchase.tranNo }>
		${i}</td>
		<td></td>
		<td align="left" class=${purchase.buyer.userId }>${purchase.buyer.userId}</td>
		<td></td>
		<td align="left">${purchase.receiverName}</td>
		<td></td>
		<td align="left">${purchase.receiverPhone}</td>
		<td></td>
		<c:if test="${fn:trim(purchase.tranCode) eq '1'}">
			<td align="left">구매완료 상태입니다</td>
		</c:if>
		<c:if test="${fn:trim(purchase.tranCode) eq '2'}">
			<td align="left">배송중 상태입니다 </td>
		</c:if>
		<c:if test="${fn:trim(purchase.tranCode) eq '3'}">
			<td align="left">배송완료 상태입니다</td>
		</c:if>
		<td></td>
		<td align="left" class=${purchase.purchaseProd.prodNo }>
			<c:if test="${fn:trim(purchase.tranCode) eq '2' }" >
			물건도착
			</c:if>
		</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	</c:forEach>


</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
	<%-- 	<%if(resultPage.getMaxPage() < resultPage.getPageUnit()){ %>
				<%for(int i = 1; i <= resultPage.getMaxPage(); i++){ %>
					<a href="/listPurchase.do?currentPage=<%=i %>&menu=<%=request.getAttribute("menu")%>"><%=i %></a>
				<%} %>
			<%}else{ %>
				<%if(resultPage.getPageUnit() <= resultPage.getMaxPage()) {%>
					<%for(int i = resultPage.getBeginUnitPage(); i < resultPage.getBeginUnitPage()+5; i++){ %>
						<%if(i > 5 && i%5==1){ %>
							<a href="/listPurchase.do?currentPage=<%=i-1 %>&menu=<%=request.getAttribute("menu")%>"> &lt;&lt; </a>
							<a href="/listPurchase.do?currentPage=<%=i %>&menu=<%=request.getAttribute("menu")%>"><%=i %></a>
						<%}else if(resultPage.getMaxPage() > 5 && i%5 == 0){ %>
							<a href="/listPurchase.do?currentPage=<%=i %>&menu=<%=request.getAttribute("menu")%>"><%=i %></a>
							<a href="/listPurchase.do?currentPage=<%=i+1 %>&menu=<%=request.getAttribute("menu")%>"> &gt;&gt; </a>
						<%}else{%>
							<a href="/listPurchase.do?currentPage=<%=i %>&menu=<%=request.getAttribute("menu")%>"><%=i %></a>
						<%} %>
					<%} %>
				<%}else{ %>
					<%for(int k = resultPage.getBeginUnitPage(); k < resultPage.getMaxPage(); k++){ %>
						<%if(k%5 == 1){ %>
							<a href="/listProduct.do?currentPage=<%=k-1 %>&menu=<%=request.getAttribute("menu")%>"> &lt;&lt; </a>
							<a href="/listProduct.do?currentPage=<%=k %>&menu=<%=request.getAttribute("menu")%>"><%=k %></a>
						<%}else{ %>
							<a href="/listProduct.do?currentPage=<%=k %>&menu=<%=request.getAttribute("menu")%>"><%=k %></a>
						<%} %>
					<%} %>
				<%} %>
			<%} %> --%>
			
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
		    <input type="hidden" id="menu" name="menu" value="manage"/>
		
			<c:set var="script" value="fncGetPurchaseList" scope="request"/>
			
			<jsp:include page="../common/prodPageNavigator.jsp"/>			
		
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>
