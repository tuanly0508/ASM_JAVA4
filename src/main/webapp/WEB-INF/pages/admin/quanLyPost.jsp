<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="ISO-8859-1">
                <title>Quản lý Post</title>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            </head>

            <body>
                <jsp:include page="template/header.jsp"></jsp:include>
                <jsp:include page="template/sidebar.jsp"></jsp:include>

                <div class="col-md-9 animated bounce">
                    <h3 class="page-header">Quản lý Post</h3>

                    <button class="btn btn-success btnThemPost">Thêm mới Post</button>

                    <hr />
                    <!--       <ul class="breadcrumb">
        <li>
          <span class="glyphicon glyphicon-home">&nbsp;</span>Home</li>
        <li>
          <a href="#">Dashboard</a>
        </li> 
      </ul>-->
                    <table class="table table-hover postTable">
                        <thead>
                            <tr>
                                <th>Mã Post</th>
                                <th>Tên Post</th>
                                <th>Short Description</th>
                                <th>Description</th>
                            </tr>

                        </thead>
                        <tbody>
                        </tbody>

                    </table>

                    <ul class="pagination">
                    </ul>
                </div>
                <div class="row col-md-6">
                    <form class="postForm" id="form">

                        <div>
                            <div class="modal fade" id="postModal" tabindex="-1" role="dialog"
                                aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static"
                                data-keyboard="false">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="exampleModalLabel">Tạo mới/Cập nhật Post
                                            </h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label for="id">ID:</label> <input type="text" class="form-control"
                                                    id="id" />
                                            </div>
                                            <div class="form-group">
                                                <label for="name">Tên Post:</label> <input type="text"
                                                    class="form-control" id="tenPost" placeholder="Nhập vào tên Post"
                                                    required />
                                            </div>
                                            <div class="form-group">
                                                <label for="name">Short Description:</label> <input type="text"
                                                    class="form-control" id="shortDescription"
                                                    placeholder="Nhập vào tên Short Description" required />
                                            </div>
                                            <div class="form-group">
                                                <label for="name">Description:</label> <input type="text"
                                                    class="form-control" id="description"
                                                    placeholder="Nhập vào tên Description" required />
                                            </div>
                                            <div class="form-group">
                                                <label for="inputState">Danh Muc</label> 
                                                <select class="form-control" id="danhMucDropdown">
                                                    <option value="1">LapTop</option>
                                                    <option value="2">PC ĐỒNG BỘ & PC GAMING</option>
                                                    <option value="3">TB NGHE NHÌN & GIẢI TRÍ</option>
                                                    <option value="4">LINH KIỆN MÁY TÍNH</option>
                                                    <option value="5">THIẾT BỊ LƯU TRỮ</option>
                                                    <option value="6">THIẾT BỊ MẠNG</option>
                                                </select>
                                            </div>
                                            <div>
                                                <label for="inputEmail4">Hình ảnh</label> <input type="file" class="form-control" id="inputEmail4" name="hinhAnh">
                                            </div>

                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary"
                                                    data-dismiss="modal">Hủy</button>
                                                <input class="btn btn-primary" id="btnSubmit" type="button"
                                                    value="Xác nhận" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                </div>


                <jsp:include page="template/footer.jsp"></jsp:include>
                <script src="<c:url value='/js/postAjax.js'/>"></script>
            </body>

            </html>