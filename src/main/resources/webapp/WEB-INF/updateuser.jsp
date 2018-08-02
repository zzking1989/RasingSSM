<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>用户修改</title>
    <meta name="content-type" content="text/html; charset=UTF-8">
    <script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery-1.8.3.js"></script>
    <!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/font-awesome/4.5.0/css/font-awesome.min.css"/>

    <!-- page specific plugin styles -->

    <!-- text fonts -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/fonts.googleapis.com.css"/>

    <!-- ace styles -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/ace.min.css" class="ace-main-stylesheet" id="main-ace-style"/>

    <!--[if lte IE 9]>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/ace-part2.min.css" class="ace-main-stylesheet"/>
    <![endif]-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/ace-skins.min.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/ace-rtl.min.css"/>

    <!--[if lte IE 9]>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/ace-ie.min.css"/>
    <![endif]-->

    <!-- inline styles related to this page -->

    <!-- ace settings handler -->
    <script src="<%=request.getContextPath()%>/assets/js/ace-extra.min.js"></script>

    <!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

    <!--[if lte IE 8]>
    <script src="<%=request.getContextPath()%>/assets/js/html5shiv.min.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div id="navbar" class="navbar navbar-default ace-save-state"></div>
<div style="height: 400px;width: 400px;margin: 0px auto;background-color: white">
    <h3 style="text-align: center; margin-top: 180px;padding-top: 20px;padding-bottom: 20px">Sign up</h3>
    <form id="updateform" onsubmit="return false" action="##" method="post">
        <table align="center">
            <tr style="margin: 4px;display: block">
                <td>Username：</td>
                <td colspan="2">${user.userName}</td>
            </tr>
            <tr style="margin: 4px;display: block">
                <td colspan="2"><input class="form-control" type="text" name="userName" id="userName" value="${user.userName}" style="display: none"/></td>
            </tr>
            <tr style="margin: 4px;display: block">
                <td>Password：</td>
                <td colspan="2"><input class="form-control" type="password" name="password" id="password"/></td>
            </tr>
            <tr style="margin: 4px;display: block">
                <td>Age：</td>
                <td colspan="2"><input class="form-control" type="text" name="age" id="age"/></td>
            </tr>
            <tr style="margin: 4px;display: block">
                <td>Email:</td>
                <td colspan="2"><input class="form-control" type="text" name="email" id="email"/></td>
            </tr>
            <td colspan="3" align="center">
                <button class="btn btn-info" style="margin-top: 20px" type="submit" onclick="saveChange()">Submit</button>
            </td>
            <td colspan="3" align="center">
                <span class="span1" id="span1" style="color: brown"></span>
            </td>
        </table>
    </form>
</div>
</body>

<script>
    function saveChange() {
        console.info("saveChange")
        var loginFormValues = document.getElementById("updateform")
        if (loginFormValues.elements[1].value == "") {
            $(".span1").html("密码不能为空！");
        } else {
            $.ajax({
                type: "POST",//方法类型
                dataType: "",//预期服务器返回的数据类型
                url: "/user/ajaxupdate",//url
                data: $('#updateform').serialize(),
                success: function (result) {
                    if (result.code == 1) {
                        alert("修改成功");
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
