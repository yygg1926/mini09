<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>


</head>

<body>

	<form name="updatePurchase" action="/purchase/updatePurchaseView"
		method="post">

		������ ���� ���Ű� �Ǿ����ϴ�.

		<table border=1>
			<tr>
				<td>��ǰ��ȣ</td>
				<td>${purchase.purchaseProd.prodNo}</td>
				<td></td>
			</tr>
			<tr>
				<td>�����ھ��̵�</td>
				<td>${purchase.buyer.userId}></td>
				<td></td>
			</tr>
			<tr>
				<td>���Ź��</td>
				<td>${puchase.paymentOption}</td>
				<td></td>
			</tr>
			<tr>
				<td>�������̸�</td>
				<td>${purchase.buyer.userName}</td>
				<td></td>
			</tr>
			<tr>
				<td>�����ڿ���ó</td>
				<td>${purchase.receiverPhone}</td>
				<td></td>
			</tr>
			<tr>
				<td>�������ּ�</td>
				<td>${purchase.dlvyAddr}</td>
				<td></td>
			</tr>
			<tr>
				<td>���ſ�û����</td>
				<td>${purchase.dlvyRequest}</td>
				<td></td>
			</tr>
			<tr>
				<td>����������</td>
				<td>${purchase.dlvyDate}</td>
				<td></td>
			</tr>
		</table>
	</form>

</body>
</html>
