function forgotPass() {
    var code = document.getElementById("code").value;
    var newPass = document.getElementById("newPass").value;
    var rePass = document.getElementById("rePass").value;
    var flag = 0;
    if (code.length == 0) {
        flag = 1;
        document.getElementById("codeWarning").innerHTML = "Không được để trống";
    }
    if (newPass.length < 8) {
        flag = 1;
        document.getElementById("newPassWarning").innerHTML = "Mật khẩu phải đủ 8 kí tự";
    }
    if (newPass != rePass) {
        flag = 1;
        document.getElementById("rePassWarning").innerHTML = "Mật khẩu xác nhận không trùng mật khẩu mới";
    }
    if (flag == 1) {
        return;
    }
    var object = new Object();
    object.code = code;
    object.newPassword = newPass;
    object.confirmNewPassword = rePass;
    data = JSON.stringify(object)

    $.ajax({
        type: "POST",
        data: data,
        contentType: "application/json",
        url: "http://localhost:8080/laptopshop/updateCodePassword",
        success: function (result) {
            if (result.status == "code") {
                alert("Sai code");
                return;
            } else {
                alert("Mật khẩu đã thay đổi");
                window.location.href = "/laptopshop/account";
            }

        },
        error: function (e) {
            alert("Error: ", e);
            console.log("Error", e);
        }
    });
}