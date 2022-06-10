<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Quản lý thong ke</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script>
	window.onload = function() {
		var data = [];
		var label = [];
		var dataForDataSets = [];
		var dataForOrder = [];
		$.ajax({
			async:false,
			type: "GET",
			data: data,
			contentType: "application/json",
			url: "http://localhost:8080/laptopshop/api/don-hang/amountOrder",
			success: function (data) {
				for (var i = 0; i < data.length; i++) {
					dataForOrder.push(data[i][2]);
				}
			},
			error: function (e) {
				alert("Error: ", e);
				console.log("Error", e);
			}
		});
		$.ajax({
			async : false,
			type : "GET",
			data : data,
			contentType : "application/json",
			url : "http://localhost:8080/laptopshop/api/don-hang/report",
			success : function(data) {
				for (var i = 0; i < data.length; i++) {
					label.push(data[i][0] + "/" + data[i][1]);
					dataForDataSets.push(data[i][2]/1000000);
				}
			},
			error : function(e) {
				alert("Error: ", e);
				console.log("Error", e);
			}
		});
		var canvas = document.getElementById('myChart');
		data = {
			labels : label,
			datasets : [ 
				{
					label : "Tổng giá trị (Triệu đồng)",
					backgroundColor : "#5b94f0",
					borderColor : "#5b94f0",
					borderWidth : 5,
					hoverBackgroundColor : "#0043ff",
					hoverBorderColor : "#0043ff",
					data : dataForDataSets,
					pointRadius: 5,
					fill: false
				},
				{
					label: "Số lượng đơn hàng",
					backgroundColor: "#ff6347",
					borderColor: "#ff6347",
					borderWidth: 5,
					hoverBackgroundColor: "#0043ff",
					hoverBorderColor: "#0043ff",
					data: dataForOrder,
					pointRadius: 5,
					fill: false
				}
			]
		};
		var option = {
			scales : {
				yAxes : [ {
					stacked : false,
					gridLines : {
						display : true,
						color : "rgba(255,99,132,0.2)"
					}
				} ],
				xAxes : [ {
					barPercentage: 0.5,
					gridLines : {
						display : true
					}
				} ]
			},
			maintainAspectRatio: false,
			legend: {
	            labels: {
	                fontSize: 20
	            }
			},
			interaction: {
				intersect: false,
				mode: 'index',
			},
			plugins: {
				title: {
					display: true,
					text: (ctx) => 'Tooltip point style: ' + ctx.chart.options.plugins.tooltip.usePointStyle,
				},
				tooltip: {
					usePointStyle: true,
					callbacks: {
						footer: footer,
					}
				}
			}
		};		

		var myBarChart = Chart.Line(canvas, {
			data : data,
			options : option
		});
	}

	const footer = (tooltipItems) => {
		let sum = 0;

		tooltipItems.forEach(function (tooltipItem) {
			sum += tooltipItem.parsed.y;
		});
		return 'Sum: ' + sum;
	};
</script>

</head>
<body>
	<jsp:include page="template/header.jsp"></jsp:include>
	<jsp:include page="template/sidebar.jsp"></jsp:include>

	<div class="col-md-9 animated bounce">
		<h3 class="page-header">Thống kê</h3>

		<canvas id="myChart" width="600px" height="400px"></canvas>
		<h4 style="text-align: center; padding-right: 10%">Biểu đồ tổng giá trị đơn hàng hoàn thành theo tháng</h4>

	</div>


	<jsp:include page="template/footer.jsp"></jsp:include>

	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.3/Chart.min.js">
	</script>
</body>
</html>
