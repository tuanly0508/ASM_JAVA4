function sendCodeEmail() {
    var email = document.getElementById("codeEmailSender").value;
    var code = Math.random().toString().substring(2, 8);

    var send = new Object();
    send.codeEmail = code;
    send.email = email;
    var data = JSON.stringify(send)
    $.ajax({
        type: "POST",
        data: data,
        contentType: "application/json",
        url: "http://localhost:8080/laptopshop/updateCode",
        success: function (result) {
            alert("Verify code đã được gửi vào email !!!");
        },
        error: function (e) {
            alert("Error: ", e);
            console.log("Error", e);
        }
    });
}