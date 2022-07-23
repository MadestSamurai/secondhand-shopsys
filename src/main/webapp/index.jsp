<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>

<%@include file="include/header.jsp" %>
<%@include file="include/top.jsp" %>
<%@include file="include/search.jsp" %>

<head>
    <title>主页</title>
    <link type="text/css" href="css/index.css" rel="stylesheet"/>
</head>

<div class="category-con">
    <div class="workArea">

        <%-- 分类栏 --%>
        <div class="category-tab-content">
            <ul class="normal-nav">
                <c:forEach items="${categories}" var="c">
                    <li class="nav-item" category_id="${c.id}">${c.name}</li>
                </c:forEach>
            </ul>
            <%@include file="include/hot-word-con.jsp" %>
        </div>

        <script type="text/javascript">
            function showProductsByCategoryId(category_id) {
                $("div.hot-word-con[category_id=" + category_id + "]").show();
            }

            function hideProductsByCategoryId(category_id) {
                $("div.hot-word-con[category_id=" + category_id + "]").hide();
            }

            $(function () {
                $("li.nav-item").mouseenter(function () {
                    var category_id = $(this).attr("category_id");
                    showProductsByCategoryId(category_id);
                });
                $("li.nav-item").mouseleave(function () {
                    var category_id = $(this).attr("category_id");
                    hideProductsByCategoryId(category_id);
                });
                $("div.hot-word-con").mouseenter(function () {
                    var category_id = $(this).attr("category_id");
                    showProductsByCategoryId(category_id);
                });
                $("div.hot-word-con").mouseleave(function () {
                    var category_id = $(this).attr("category_id");
                    hideProductsByCategoryId(category_id);
                });
            });
        </script>

        <div style="clear: both;"></div>

        <div data-ride="carousel" class="carousel-of-product carousel" id="carousel-of-product">
            <!-- Indicators -->
            <ol class="carousel-indicators">
                <li class="active" data-slide-to="0" data-target="#carousel-of-product"></li>
                <li data-slide-to="1" data-target="#carousel-of-product" class=""></li>
                <li data-slide-to="2" data-target="#carousel-of-product" class=""></li>
                <li data-slide-to="3" data-target="#carousel-of-product" class=""></li>
            </ol>
            <!-- Wrapper for slides -->
            <div role="listbox" class="carousel-inner">
                <div class="item active">
                    <img src="img/fore/carousel1.jpg" class="carousel carouselImage">
                </div>
                <div class="item">
                    <img src="img/fore/carousel2.jpg" class="carouselImage">
                </div>
                <div class="item">
                    <img src="img/fore/carousel3.jpg" class="carouselImage">
                </div>
                <div class="item">
                    <img src="img/fore/carousel4.jpg" class="carouselImage">
                </div>
            </div>
        </div>
    </div>
</div>
<div style="clear: both;"></div>

<div class="new-floor-con">
    <div class="workArea">
        <c:forEach items="${categories}" var="c" varStatus="sts">

            <%-- 该分类下有产品才能显示 --%>
            <c:if test="${!empty c.products}">
                <%-- 默认只展示前五个分类的内容，多了页面太长 --%>
                <c:if test="${sts.count<=5}">
                    <div class="floor-line-con">
                        <i class="color-mark"></i>
                        <div class="floor-name">${c.name}</div>
                        <br>
                        <c:forEach items="${c.products}" var="p" varStatus="st">
                            <c:if test="${st.count<=5}">
                                <a class="grid" href="showProduct?product_id=${p.id}">
                                    <div class="productItem">
                                        <img class="floor-item-img" src="img/product/${p.id}/1.jpg">
                                        <div class="floor-item-title">${p.name}</div>
                                        <div class="floor-price">${p.price}</div>
                                    </div>
                                </a>
                            </c:if>
                        </c:forEach>

                    </div>
                    <div style="clear: both;"></div>
                </c:if>
            </c:if>
        </c:forEach>
        <div class="tm-end">
            <img src="img/fore/end.png"/>
        </div>
    </div>
</div>
<div style="clear: both;"></div>


<%@include file="include/footer.jsp" %>
