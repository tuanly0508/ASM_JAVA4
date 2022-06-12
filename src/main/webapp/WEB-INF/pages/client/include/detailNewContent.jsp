<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<link rel="stylesheet" href="Frontend/css/detailsp.css">
</head>
	<script type="text/javascript">	  
	$(document).ready(function() { 
	  	var priceConvert = accounting.formatMoney(${sp.getDonGia()})+' VND';
		document.getElementById("priceConvert").innerHTML= priceConvert;
		  
	  });
	</script>
<body>
	<div class="container">
		<div class="card">
			<div class="container-fliud">
				<div class="wrapper row">
					<div class="preview col-md-6">
						
						<div class="preview-pic tab-content">
						  <div class="tab-pane active" id="pic-1"><img src="/laptopshop/img/${sp.getId()}.jpg" /></div>
						</div>		
					</div>
					<div class="details col-md-6">
						<p style="display:none" id="spid">${sp.getId()}</p>
						<h2 class="product-title">${sp.getTenSanPham()}</h2>
						<h4 class="price">Mô tả sản phẩm</h4>
						<p class="product-description">Hãng sản xuất: ${sp.hangSanXuat.tenHangSanXuat}</p>
						<p class="product-description"><span class="important">THÔNG TIN CHUNG:</span> ${sp.getThongTinChung()}</p>
						<p class="product-description"><span class="important">BẢO HÀNH:</span> ${sp.getThongTinBaoHanh()}</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
