function login() {
    var loginFormValues = document.getElementById("loginform")
    if (loginFormValues.elements[0].value == "") {
        // $(".span1").html("用户名不能为空！");
    } else if (loginFormValues.elements[1].value == "") {
        //$(".span1").html("密码不能为空！");
    } else {
        $.ajax({
            type: "POST",
            dataType: "",
            url: "/user/ajaxlogin",
            data: $('#loginform').serialize(),
            success: function (result) {
                if (result.code == 1) {
                    window.location.href = '/user/index';
                } else {
                    $(".span1").html(result.name);
                }
            },
            error: function () {
                alert("异常！");
            }
        });
    }
}

function getUsers() {
    $.ajax({
        type: "GET",//方法类型
        dataType: "",//预期服务器返回的数据类型
        url: "/user/getuser",//url
        data: "",
        success: function (result) {
            if (result != NaN) {
                var userslist = result
                console.info(userslist)
                $("#control").hide();
                $("#userTable").show();
                var tbody = document.getElementById('tbMain');
                for (var i = 0; i < result.length; i++) {
                    console.info(result[i]);
                    var trow = getDataRow(result[i]);
                    tbody.appendChild(trow)
                }

            } else {
                alert("没有数据！");
            }
        },
        error: function () {
            alert("异常！");
        }
    });
}

function getDataRow(user) {
    var row = document.createElement('tr'); //创建行
    row.id = user.id;
    var userNameCell = document.createElement('td'); //创建第一列
    userNameCell.innerHTML = user.userName; //填充数据
    row.appendChild(userNameCell); //加入行 ，下面类似
    var ageCell = document.createElement('td');//创建第二列
    ageCell.innerHTML = user.age;
    row.appendChild(ageCell);
    var emailCell = document.createElement('td');//创建第三列
    emailCell.innerHTML = user.email;
    row.appendChild(emailCell);
    var controlCell = document.createElement('td');//创建第三列
    controlCell.innerHTML = '&nbsp &nbsp <a class="green" href="javascript:void(0);" onclick =updateUser("' + user.id + '",event)><i class="ace-icon fa fa-pencil bigger-130"></i></a>' +
        '&nbsp &nbsp <a class="red" href="javascript:void(0);" onclick =delectUser("' + user.id + '",event)><i class="ace-icon fa fa-trash-o bigger-130"></i></a>';
    row.appendChild(controlCell);
    return row; //返回tr数据
}


function delectUser(userID, event) {
    console.info("in deleteuser");
    console.info(userID);
    var target = event.srcElement || event.target;
    if (confirm("确认要删除么？")) {
        target.returnValue = true;
    } else {
        target.returnValue = false;
    }
    if (target.returnValue == true) {
        $.ajax({
                type: "POST",//方法类型
                dataType: "",//预期服务器返回的数据类型
                url: "/user/deleteuser/" + userID,//url
                success: function (result) {
                    if (result.code > 0) {
                        $("#" + userID).remove();
                    }
                    else {
                        alert("用户不存在！");
                    }
                },
                error: function () {
                    alert("异常！");
                }

            }
        )
    }
}

function updateUser(userID, event) {
    console.info("in updateuser");
    console.info(userID);
    var target = event.srcElement || event.target;
    if (confirm("确认要修改么？")) {
        target.returnValue = true;
    } else {
        target.returnValue = false;
    }
    if (target.returnValue == true) {
        $.ajax({
                type: "POST",//方法类型
                dataType: "",//预期服务器返回的数据类型
                url: "/user/toupdateuser/" + userID,//url
                success: function (result) {
                    if (result.code > 0) {
                        window.location.href = "/user/updateuser/" + userID;
                    }
                    else {
                        alert("用户不存在！");
                    }
                },
                error: function () {
                    alert("异常！");
                }

            }
        )
    }
}

function showMenu() {
    if ($("#user-menu").css('display') === 'none') {
        $("#user-menu").show();
    } else {
        $("#user-menu").hide();
    }

}