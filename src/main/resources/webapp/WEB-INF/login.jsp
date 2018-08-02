<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>Sign In</title>
    <meta name="content-type" content="text/html; charset=UTF-8">
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
<!-- 全局js -->

<body>
<div id="navbar" class="navbar navbar-default ace-save-state"></div>
<div style=" height: 250px;width: 350px;margin: 0px auto;background-color: white">
    <h3 style="text-align: center; margin-top: 180px;padding-top: 20px;padding-bottom: 20px">Sign&nbsp&nbspIn</h3>
    <form id="loginform" onsubmit="return false" action="##" method="post">
        <table align="center">
            <tr style="margin: 4px;display: block">
                <td>Username：</td>
                <td colspan="2" style="text-align: left"><input class="form-control" type="text" name="username"
                                                                id="username"/></td>
            </tr>
            <tr style="margin: 4px;display: block">
                <td>Password：&nbsp</td>
                <td colspan="2" style="text-align: left"><input class="form-control" type="password" name="password"
                                                                id="password"/></td>
            </tr>
            <tr style="margin: 4px;display: block" align="center">
                <td colspan="3" align="center">
                    <span class="span1" id="span1" style="color: brown"></span>
                </td>
            </tr>
            <tr style="margin: 4px;display: block" align="center">
                <td colspan="3" align="center">
                    <button class="btn btn-info" style="margin-top: 20px" type="submit" onclick="login()">Submit
                    </button>
                </td>
            </tr>



        </table>
    </form>
</div>
<script>
    function login() {
        var loginFormValues = document.getElementById("loginform")
        if (loginFormValues.elements[0].value == "") {
            $(".span1").html("用户名不能为空！");
        } else if (loginFormValues.elements[1].value == "") {
            $(".span1").html("密码不能为空！");
        } else {
            $.ajax({
                type: "POST",//方法类型
                dataType: "",//预期服务器返回的数据类型
                url: "/user/ajaxlogin",//url
                data: $('#loginform').serialize(),
                success: function (result) {
                    // console.log(result);//打印服务端返回的数据
                    // alert(result);//弹框
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
</script>
</body>
</html>

