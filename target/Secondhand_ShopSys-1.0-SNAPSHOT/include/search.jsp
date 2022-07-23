<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>

<%-- 首页搜索栏和SH图标 --%>
<div class="header">
    <div class="headerLayout workArea">

        <%-- 图片logo --%>
        <div class="logo">
            <a href="${context}">
                <img src="../img/fore/SH-logo.png" alt="SH二手商店">
            </a>
        </div>

        <%-- 搜索框 --%>
        <form class="mallSearch-input" action="/searchProduct">
            <input name="keyword" type="text" placeholder="搜索 商品关键词">
            <button type="submit" class="searchButton">搜索</button>
            <ul class="hot-query">
                <li>
                    <a href="searchProduct?keyword=针织衫">针织衫</a>
                </li>
                <li class="hot-query-li">
                    <a href="searchProduct?keyword=索尼耳机">索尼耳机</a>
                </li>
                <li class="hot-query-li">
                    <a href="searchProduct?keyword=CD">CD</a>
                </li>
                <li class="hot-query-li">
                    <a href="searchProduct?keyword=索尼相机">索尼相机</a>
                </li>
                <li class="hot-query-li">
                    <a href="searchProduct?keyword=徽章">徽章</a>
                </li>
                <li class="hot-query-li">
                    <a href="searchProduct?keyword=雷蛇鼠标">雷蛇鼠标</a>
                </li>
                <li class="hot-query-li">
                    <a href="searchProduct?keyword=课本">课本</a>
                </li>
                <li class="hot-query-li">
                    <a href="searchProduct?keyword=运动鞋">运动鞋</a>
                </li>
                <li class="hot-query-li">
                    <a href="searchProduct?keyword=手机">手机</a>
                </li>
            </ul>
        </form>
    </div>
</div>

<div style="clear: both;"/>

<%-- 分类信息栏 --%>
<div class="main-nav">
    <div class="workArea">
        <span class="category-type">
            <span class="glyphicon glyphicon-th-list category-type-icon"></span>
            <span class="category-type-text">商品分类</span>
        </span>
        <span>
            <c:forEach items="${links}" var="link">
                <a href="${link.link}">${link.text}</a>
            </c:forEach>
        </span>
    </div>
</div>