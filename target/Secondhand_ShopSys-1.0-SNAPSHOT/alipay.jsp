<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>

<%@include file="include/header.jsp" %>
<%@include file="include/top.jsp" %>

<link type="text/css" href="css/alipay.css" rel="stylesheet"/>
<div class="aliPayPageDiv">
    <div class="aliPayPageLogo">
        <img class="pull-left" src="img/fore/simpleLogo.png">
        <div style="clear:both"></div>
    </div>

    <div>
        <span class="confirmMoneyText">扫一扫付款（元）</span>
        <span class="confirmMoney">
		￥${param.total}</span>
    </div>
    <div>
        <img class="aliPayImg" src="img/fore/alipay_qrcode.jpg">
    </div>

    <div>
        <a href="payed?order_id=${param.order_id}&total=${param.total}">
            <button class="confirmPay">确认支付</button>
        </a>
    </div>
</div>