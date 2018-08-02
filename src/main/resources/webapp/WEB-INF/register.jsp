<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
    <script src="../js/jquery.min.js"></script>
    <script src="../js/jquery-1.8.3.js"></script>

    <!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="../assets/font-awesome/4.5.0/css/font-awesome.min.css"/>

    <!-- page specific plugin styles -->

    <!-- text fonts -->
    <link rel="stylesheet" href="../assets/css/fonts.googleapis.com.css"/>

    <!-- ace styles -->
    <link rel="stylesheet" href="../assets/css/ace.min.css" class="ace-main-stylesheet" id="main-ace-style"/>

    <!--[if lte IE 9]>
    <link rel="stylesheet" href="../assets/css/ace-part2.min.css" class="ace-main-stylesheet"/>
    <![endif]-->
    <link rel="stylesheet" href="../assets/css/ace-skins.min.css"/>
    <link rel="stylesheet" href="../assets/css/ace-rtl.min.css"/>

    <!--[if lte IE 9]>
    <link rel="stylesheet" href="../assets/css/ace-ie.min.css"/>
    <![endif]-->

    <!-- inline styles related to this page -->

    <!-- ace settings handler -->
    <script src="../assets/js/ace-extra.min.js"></script>

    <!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

    <!--[if lte IE 8]>
    <script src="../assets/js/html5shiv.min.js"></script>
    <script src="../assets/js/respond.min.js"></script>
    <![endif]-->
</head>
<body style="background-color: white">
<div id="navbar" class="navbar navbar-default ace-save-state"></div>
<div style="margin: 0px auto;">
    <h3 style="text-align: center; margin-top: 100px;padding-top: 20px;padding-bottom: 20px">Sign up</h3>
    <form id="registerform" onsubmit="return false" action="##" method="post">
        <table align="center">
            <tr style="margin: 10px;display: block" align="right">
                <td>Username:&nbsp</td>
                <td colspan="2"><input class="form-control" type="text" name="userName" id="userName"/></td>
            </tr>
            <tr style="margin: 10px;display: block" align="right">
                <td>Password:&nbsp</td>
                <td colspan="2"><input class="form-control" type="password" name="password" id="password"/></td>
            </tr>
            <tr style="margin: 10px;display: block" align="right">
                <td>Age:&nbsp</td>
                <td colspan="2"><input class="form-control" type="text" name="age" id="age"/></td>
            </tr>
            <tr style="margin: 10px;display: block" align="right">
                <td>Email:&nbsp</td>
                <td colspan="2"><input class="form-control" type="text" name="email" id="email"/></td>
            </tr>
            <tr>
                <td colspan="3" align="center">
                    <button class="btn btn-info" type="submit" onclick="register()"><i
                            class="ace-icon fa fa-check bigger-110"></i>Submit
                    </button>
                    <button class="btn" type="reset">
                        <i class="ace-icon fa fa-undo bigger-110"></i>
                        Reset
                    </button>
                </td>


            </tr>
        </table>
    </form>
</div>
</body>

<script>
    function register() {
        var loginFormValues = document.getElementById("registerform")
        if (loginFormValues.elements[0].value == "") {
            $(".span1").html("用户名不能为空！");
        } else if (loginFormValues.elements[1].value == "") {
            $(".span1").html("密码不能为空！");
        } else {
            $.ajax({
                type: "POST",//方法类型
                dataType: "",//预期服务器返回的数据类型
                url: "/user/ajaxregister",//url
                data: $('#registerform').serialize(),
                success: function (result) {
                    if (result.code == 1) {
                        alert("注册成功");
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
</script>
</html>
