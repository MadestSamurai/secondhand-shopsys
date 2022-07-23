<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>

<%@include file="include/header.jsp" %>
<%@include file="include/top.jsp" %>
<%@include file="include/mini-search.jsp" %>

<head>
    <title>订单页</title>
    <link type="text/css" href="css/bought.css" rel="stylesheet"/>
    <script type="text/javascript" src="js/bought.js"></script>
</head>

<div class="boughtDiv">
    <div class="orderType">
        <div class="selectedOrderType"><a orderStatus="all" href="#nowhere">所有订单</a></div>
        <div><a orderStatus="waitPay" href="#nowhere">待付款</a></div>
        <div><a orderStatus="waitDelivery" href="#nowhere">待发货</a></div>
        <div><a orderStatus="waitConfirm" href="#nowhere">待收货</a></div>
        <div><a orderStatus="waitReview" href="#nowhere" class="noRightborder">待评价</a></div>
        <div class="orderTypeLastOne"><a class="noRightborder"> </a></div>
    </div>
    <div style="clear:both"></div>
    <div class="orderListTitle">
        <table class="orderListTitleTable">
            <tr>
                <td>宝贝</td>
                <td width="121px">单价</td>
                <td width="121px">数量</td>
                <td width="141px">实付款</td>
                <td width="121px">交易操作</td>
            </tr>
        </table>

    </div>

    <div class="orderListItem">
        <c:forEach items="${orders}" var="o">
            <table class="orderListItemTable" orderStatus="${o.status}" oid="${o.id}">
                <tr class="orderListItemFirstTR">
                    <td colspan="2">
                        <b>${o.create_date}</b>
                        <span>订单号: ${o.order_code}
                    </span>
                    </td>
                    <td colspan="2"><img width="13px" src="img/fore/orderItemTmall.png" alt="商场">SH商场</td>
                    <td colspan="1">
                        <a class="wangwanglink" href="#nowhere">
                            <div class="orderItemWangWangGif"></div>
                        </a>

                    </td>
                    <td class="orderItemDeleteTD">
                        <a class="deleteOrderLink" oid="${o.id}" href="#nowhere">
                            <span class="orderListItemDelete glyphicon glyphicon-trash"></span>
                        </a>

                    </td>
                </tr>
                <c:forEach items="${o.orderItems}" var="oi" varStatus="st">
                    <tr class="orderItemProductInfoPartTR">
                        <td class="orderItemProductInfoPartTD"><img width="80" height="80"
                                                                    src="img/product/${oi.product.id}/1.jpg" alt="产品">
                        </td>
                        <td class="orderItemProductInfoPartTD">
                            <div class="orderListItemProductLinkOutDiv">
                                <a href="foreproduct?pid=${oi.product.id}">${oi.product.name}</a>
                                <div class="orderListItemProductLinkInnerDiv">
                                    <img src="img/fore/creditcard.png" title="支持信用卡支付">
                                    <img src="img/fore/7day.png" title="消费者保障服务,承诺7天退货">
                                    <img src="img/fore/promise.png" title="消费者保障服务,承诺如实描述">
                                </div>
                            </div>
                        </td>
                        <td class="orderItemProductInfoPartTD" width="100px">

                            <div class="orderListItemProductOriginalPrice">￥${oi.product.price}</div>
                            <div class="orderListItemProductPrice">￥${oi.product.price}</div>

                        </td>
                        <c:if test="${st.count==1}">

                            <td valign="top" rowspan="${fn:length(o.orderItems)}"
                                class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">
                                <span class="orderListItemNumber">${o.totalNumber}</span>
                            </td>
                            <td valign="top" rowspan="${fn:length(o.orderItems)}" width="120px"
                                class="orderListItemProductRealPriceTD orderItemOrderInfoPartTD">
                                <div class="orderListItemProductRealPrice">￥${o.total}</div>
                                <div class="orderListItemPriceWithTransport">(含运费：￥0.00)</div>
                            </td>
                            <td valign="top" rowspan="${fn:length(o.orderItems)}"
                                class="orderListItemButtonTD orderItemOrderInfoPartTD" width="100px">
                                <c:if test="${o.status=='waitConfirm' }">
                                    <a href="confirmPay?order_id=${o.id}">
                                        <button class="orderListItemConfirm">确认收货</button>
                                    </a>
                                </c:if>
                                <c:if test="${o.status=='waitPay' }">
                                    <a href="alipay.jsp?order_id=${o.id}&total=${o.total}">
                                        <button class="orderListItemConfirm">付款</button>
                                    </a>
                                </c:if>

                                <c:if test="${o.status=='waitDelivery' }">
                                    <span>待发货</span>
                                    <%--                                     <button class="btn btn-info btn-sm ask2delivery" link="admin_order_delivery?id=${o.id}">催发货</button> --%>

                                </c:if>

                                <c:if test="${o.status=='waitReview' }">
                                    <a href="review?order_id=${o.id}">
                                        <button class="orderListItemReview">评价</button>
                                    </a>
                                </c:if>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>

            </table>
        </c:forEach>

    </div>

</div>


<%@include file="include/footer.jsp" %>
