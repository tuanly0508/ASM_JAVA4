$(document).ready(function () {

	// click event button Them moi danh muc
	$('.btnThemPost').on("click", function (event) {
		event.preventDefault();
		$('.postForm #postModal').modal();
		$('.postForm #id').prop("disabled", true);
		$('#form').removeClass().addClass("addForm");
		$('#form #btnSubmit').removeClass().addClass("btn btn-primary btnSaveForm");
	});

	// event khi hide modal
	$('#postModal').on('hidden.bs.modal', function () {
		$('#form').removeClass().addClass("postForm");
		$('#form #btnSubmit').removeClass().addClass("btn btn-primary");
		resetText();
	});

	// reset text trong form
	function resetText() {
		$("#id").val("");
		$("#tenPost").val("");
	};


	ajaxGet(1);

	// do get
	function ajaxGet(page) {
		$.ajax({
			type: "GET",
			url: "http://localhost:8080/laptopshop/api/post/all" + "?page=" + page,
			success: function (result) {
				$.each(result.content, function (i, post) {
					var postRow = '<tr style="text-align: center;">' +
						'<td width="20%">' + post.id + '</td>' +
						'<td>' + post.tenPost + '</td>' +
						'<td>' + post.shortDescription + '</td>' +
						'<td>' + post.description + '</td>' +
						'<td>' + '<input type="hidden" value=' + post.id + '>'
						+ '<button class="btn btn-primary btnCapNhatPost" >Cập nhật</button>' +
						'   <button class="btn btn-danger btnXoaPost">Xóa</button></td>'
					'</tr>';
					$('.postTable tbody').append(postRow);
				});

				if (result.totalPages > 1) {
					for (var numberPage = 1; numberPage <= result.totalPages; numberPage++) {
						var li = '<li class="page-item "><a class="pageNumber">' + numberPage + '</a></li>';
						$('.pagination').append(li);
					};

					// active page pagination
					$(".pageNumber").each(function (index) {
						if ($(this).text() == page) {
							$(this).parent().removeClass().addClass("page-item active");
						}
					});
				};
			},
			error: function (e) {
				alert("Error: ", e);
				console.log("Error", e);
			}
		});
	};


	//    // SUBMIT FORM
	//    $(".customerForm").submit(function(event) {
	//        event.preventDefault();
	//        ajaxPost();
	//        resetData();
	//    });

	$(document).on('click', '.btnSaveForm', function (event) {
		event.preventDefault();
		ajaxPost();
		resetData();
	});

	//post
	function ajaxPost() {
		// PREPARE FORM DATA
		var formData = {
			tenPost: $("#tenPost").val(),
			shortDescription: $("#shortDescription").val(),
			description: $("#description").val(),
			categoryId: $("#danhMucDropdown").val(),
		};
		// DO POST
		$.ajax({
			async: false,
			type: "POST",
			contentType: "application/json",
			url: "http://localhost:8080/laptopshop/api/post/save",
			data: JSON.stringify(formData),
			// dataType : 'json',
			success: function (response) {
				if (response.status == "success") {
					$('#postModal').modal('hide');
					alert("Thêm thành công");
				} else {
					$('input').next().remove();
					$.each(response.errorMessages, function (key, value) {
						$('input[id=' + key + ']').after('<span class="error">' + value + '</span>');
					});
				}

			},
			error: function (e) {
				alert("Error!")
				console.log("ERROR: ", e);
			}
		});
	};

	// click edit button
	$(document).on("click", ".btnCapNhatPost", function () {
		event.preventDefault();
		$('.postForm #id').prop("disabled", true);
		var postId = $(this).parent().find('input').val();
		$('#form').removeClass().addClass("updateForm");
		$('#form #btnSubmit').removeClass().addClass("btn btn-primary btnUpdateForm");
		var href = "http://localhost:8080/laptopshop/api/post/" + postId;
		$.get(href, function (post, status) {
			$('.updateForm #id').val(post.id);
			$('.updateForm #tenPost').val(post.tenPost);
			$('.updateForm #shortDescription').val(post.shortDescription);
			$('.updateForm #description').val(post.description);
		});

		removeElementsByClass("error");

		$('.updateForm #postModal').modal();
	});

	// put request
	$(document).on('click', '.btnUpdateForm', function (event) {
		event.preventDefault();
		ajaxPut();
		resetData();
	});

	// put
	function ajaxPut() {
		// PREPARE FORM DATA
		var formData = {
			id: $('#id').val(),
			tenPost: $("#tenPost").val(),
			shortDescription: $("#shortDescription").val(),
			description: $("#description").val(),
		}
		// DO PUT
		$.ajax({
			async: false,
			type: "PUT",
			contentType: "application/json",
			url: "http://localhost:8080/laptopshop/api/post/update",
			data: JSON.stringify(formData),
			// dataType : 'json',
			success: function (response) {

				if (response.status == "success") {
					$('#postModal').modal('hide');
					alert("Cập nhật thành công");
				} else {
					$('input').next().remove();
					$.each(response.errorMessages, function (key, value) {
						$('input[id=' + key + ']').after('<span class="error">' + value + '</span>');
					});
				}
			},
			error: function (e) {
				alert("Error!")
				console.log("ERROR: ", e);
			}
		});
	};

	// delete request
	$(document).on("click", ".btnXoaPost", function () {

		var postId = $(this).parent().find('input').val();
		var workingObject = $(this);

		var confirmation = confirm("Bạn chắc chắn xóa danh mục này ?");
		if (confirmation) {
			$.ajax({
				type: "DELETE",
				url: "http://localhost:8080/laptopshop/api/post/delete/" + postId,
				success: function (resultMsg) {
					resetDataForDelete();
					alert("Xóa thành công");
				},
				error: function (e) {
					alert("Không thể xóa danh mục này ! Hãy kiểm tra lại");
					console.log("ERROR: ", e);
				}
			});
		}
	});

	// reset table after post, put
	function resetData() {
		$('.postTable tbody tr').remove();
		var page = $('li.active').children().text();
		$('.pagination li').remove();
		ajaxGet(page);
	};

	// reset table after delete
	function resetDataForDelete() {
		var count = $('.postTable tbody').children().length;
		console.log("số cột " + count);
		$('.postTable tbody tr').remove();
		var page = $('li.active').children().text();
		$('.pagination li').remove();
		console.log(page);
		if (count == 1) {
			ajaxGet(page - 1);
		} else {
			ajaxGet(page);
		}

	};

	// event khi click vào phân trang Danh mục
	$(document).on('click', '.pageNumber', function (event) {
		//		event.preventDefault();
		var page = $(this).text();
		$('.postTable tbody tr').remove();
		$('.pagination li').remove();
		ajaxGet(page);
	});

	function removeElementsByClass(className) {
		var elements = document.getElementsByClassName(className);
		while (elements.length > 0) {
			elements[0].parentNode.removeChild(elements[0]);
		}
	}
});