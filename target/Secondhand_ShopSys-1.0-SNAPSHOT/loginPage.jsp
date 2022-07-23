<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>

<%@include file="include/header.jsp" %>
<html>
<head>
    <title>登录</title>
    <link type="text/css" href="css/loginPage.css" rel="stylesheet"/>
</head>
<body>
<div class="shopPage" id="shopPage">
    <div class="header">
        <a href="/home">
            <img src="/img/fore/shLogo.png" class="sh-logo" alt="SH二手商店">
        </a>
    </div>
</div>
<script>
    $(function () {
        <c:if test="${!empty msg}">
        $("span.errorMessage").html("${msg}");
        $("div.loginErrorMessageDiv").show();
        </c:if>
        $("form.loginForm").submit(function () {
            if (0 === $("#name").val().length || 0 === $("#password").val().length) {
                $("span.errorMessage").html("请输入账号密码");
                $("div.loginErrorMessageDiv").show();
                return false;
            }
            return true;
        });
        $("form.loginForm input").keyup(function () {
            $("div.loginErrorMessageDiv").hide();
        });
    })

    function change() {
        document.getElementById("validate").src = "/validate?random=" + Math.random();
    }
</script>
<div class="content">
    <div class="login-banner-wrap" style="width: 100%; background-color: #F7F7F7;" title="">
        <div class="inner">
            <img src="/img/fore/loginPage-background.jpg" alt="背景">
        </div>
    </div>

    <div class="form" style="display: block; right: 177px;">
        <div class="form-inner">
            <div class="static-form">
                <div class="loginErrorMessageDiv" style="display: none;">
                    <div class="alert alert-danger">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
                        <span class="errorMessage"></span>
                    </div>
                </div>
                <div class="login-title">密码登录</div>
                <form action="/login" class="loginForm" method="post">
                    <div class="field">
                        <span class="loginInputIcon">
					        <span class=" glyphicon glyphicon-user"></span>
				        </span>
                        <input id="name" name="name" placeholder="手机/会员名/邮箱" type="text">
                    </div>
                    <div class="field">
                        <span class="loginInputIcon ">
                            <span class=" glyphicon glyphicon-lock"></span>
                        </span>
                        <input id="password" name="password" type="password" placeholder="密码" type="text">
                    </div>
                    <div class="Vcode">
                        <span class="loginInputIcon ">
                            <span class=" glyphicon glyphicon-pencil"></span>
                        </span>
                        <input type="text" name="VCode" class="textVcode"/>
                        <span>
                            <img src="/validate" id="validate" onclick="change()"/>
                            <a href="javascript:change()">看不清，换一张</a>
                        </span>
                    </div>
                    <br><br>
                    <div style="margin-top: 10px;">
                        <button class="redButton" type="submit">登 录</button>
                    </div>
                    <div style="margin-top: 20px;">
                        <a class="notImplementLink" href="#nowhere">忘记登录密码</a>
                        <a href="registerPage" class="pull-right">免费注册</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>