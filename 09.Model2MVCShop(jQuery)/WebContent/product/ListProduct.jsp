
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

function fncGetProductList(currentPage){
	document.getElementById("currentPage").value = currentPage;

	document.detailForm.submit();
	
}

$(function(){
	<c:set var="i" value="0"/>
	<c:forEach var="product" items="${list }">
			
	$($(".ct_list_pop td:nth-child(3)")[${i}]).css('color', 'red').on("click", function(){
		
		
		self.location ="/product/updateProductView?menu=manage&prodNo="+$($(".ct_list_pop td:nth-child(3)")[${i}]).attr("class");
				//$(".ct_list_pop td:nth-child(3)").text().trim();
			
		
	});
	

	<c:set var="i" value="${i+1 }"/>
	</c:forEach>
/*	
	if("${fn:trim(product.proTranCode)}" == '1'){
		<c:set var="i" value="0"/>
		<c:forEach var="product" items="${list }">
		
		$($(".ct_list_pop td:nth-child(10)")[${i}]).on("click", function(){
			
			
			self.location ="/purchase/updateTranCodeByProd?tranCode=1&prodNo=${product.prodNo}"+$($(".ct_list_pop td:nth-child(10)")[${i}]).attr("class");
					//$(".ct_list_pop td:nth-child(3)").text().trim();
			<c:set var="i" value="${i+1 }"/>
		});
		</c:forEach>
		
	}*/
	
	//if('${fn:trim(product.proTranCode)}'=="1"){
	//$($('.ct_list_pop td:nth-child(10)')[${i}]).on("click", function(){
	
	
		//self.location ="/purchase/updateTranCodeByProd?tranCode=1&prodNo="+$($(".ct_list_pop td:nth-child(10)")[${i}]).attr("class");
			//$(".ct_list_pop td:nth-child(3)").text().trim();
	
	//});
//}
	$("h7").css("color" , "red");
	
	$("td:contains('����ϱ�')").on("click", function(){
		
		self.location ="/purchase/updateTranCodeByProd?tranCode=1&prodNo="+$(this).attr("class");
	});
	
	$(".search td:nth-child(2)").on("click", function(){
		fncGetProductList();
	});
});

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/product/listProduct?menu=manage" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">��ǰ ���� </td>
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
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" ${! empty search.searchCondition  && search.searchCondition==0 ? "selected" : ""}>��ǰ��ȣ</option>
				<option value="1" ${! empty search.searchCondition  && search.searchCondition==1 ? "selected" : ""}>��ǰ��</option>
				<option value="2" ${! empty search.searchCondition  && search.searchCondition==2 ? "selected" : ""}>��ǰ����</option>
			<input type="text" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px" />
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr class="search">
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- <a href="javascript:fncGetProductList();">�˻�</a> -->
						�˻�
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;" id="tab">
	<tr>
		<td colspan="11" >��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��<br>
			<h7 >(��ǰ�� click:������)</h7></td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b" colspan="2">�������</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<c:set var="i" value="0"/>
	<c:forEach var="product" items="${list }">
		<c:set var="i" value="${i+1 }"/>
		<tr class="ct_list_pop" name="ct">
			<td align="center">${i}</td>
			<td></td>
			<td align="left" name="proName" class=${product.prodNo }>
			<!--  a href="/product/updateProductView?prodNo=${product.prodNo}&menu=${menu}">${product.prodName}</a-->
			${product.prodName}
			</td>
			<td></td>
			<td align="left">${product.price}</td>
			<td></td>
			<td align="left">${product.manuDate}</td>
			<td></td>
			<c:if test="${fn:trim(product.proTranCode)=='0' }">
				<td align="left">�Ǹ���</td>
			</c:if>
			<c:if test="${fn:trim(product.proTranCode)=='1' }">
				<td align="left">���ſϷ�</td>
				<td class=${product.prodNo }> 
				<!-- <a href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=1">����ϱ�</a>-->
				����ϱ�
				</td>
			</c:if>
			<c:if test="${fn:trim(product.proTranCode)=='2' }">
				<td align="left">�����</td>
			</c:if>
			<c:if test="${fn:trim(product.proTranCode)=='3' }">
				<td align="left">��ۿϷ�</td>
			</c:if>
		</tr>
		<tr>
			<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>	
		</c:forEach>
		
<%-- 
	<%
		int no = list.size();
		for(int i = 0; i < list.size(); i++){
				Product productVO = (Product)list.get(i);
	%>
	<tr class="ct_list_pop">
		<td align="center"><%= i+1 %></td>
		<td></td>
				<%if(request.getAttribute("menu").equals("manage")){ %>
				<td align="left"><a href="/updateProductView.do?prodNo=<%=productVO.getProdNo() %>&menu=<%=request.getAttribute("menu") %>"><%=productVO.getProdName() %></a></td>
			<%}else{ %>
							<td align="left"><a href="/getProduct.do?prodNo=<%=productVO.getProdNo() %>&menu=<%=request.getAttribute("menu") %>"><%=productVO.getProdName() %></a></td>
			<%} %>
		<td></td>
		<td align="left"><%= productVO.getPrice() %></td>
		<td></td>
		<td align="left"><%=productVO.getManuDate() %></td>
		<td></td>
		<td align="left">
		
			�Ǹ���
		
		</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	<%} %>
--%>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
		   <input type="hidden" id="menu" name="menu" value="manage"/>
<%-- 
			<% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
					�� ����
			<% }else{ %>
					<a href="/listProduct.do?currentPage=<%=resultPage.getCurrentPage()-1%>&menu=<%=request.getAttribute("menu")%>&searchKeyword=<%=search.getSearchKeyword()%>&searchCondition=<%=search.getSearchCondition()%>">�� ����</a>
			<% } %>

			<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
					<a href="/listProduct.do?currentPage=<%=i %>&menu=<%=request.getAttribute("menu")%>&searchKeyword=<%=search.getSearchKeyword()%>&searchCondition=<%=search.getSearchCondition()%>"><%=i %></a>
			<% 	}  %>
	
			<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
					���� ��
			<% }else{ %>
					<a href="/listProduct.do?currentPage=<%=resultPage.getEndUnitPage()+1%>&menu=<%=request.getAttribute("menu")%>&searchKeyword=<%=search.getSearchKeyword()%>&searchCondition=<%=search.getSearchCondition()%>">���� ��</a>
			<% } %>
--%>
			<c:set var="script" value="fncGetProductList" scope="request"/>
			
			<jsp:include page="../common/prodPageNavigator.jsp"/>	
    	</td>
	</tr>
</table>
<!--  ������ Navigator �� -->

</form>

</div>
</body>
</html>
