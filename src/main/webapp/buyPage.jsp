<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>

<%@include file="include/header.jsp" %>
<%@include file="include/top.jsp" %>
<link type="text/css" href="css/buyPage.css" rel="stylesheet"/>
<script type="text/javascript" src="js/buyPage.js"></script>
<div class="buyPageDiv">
    <form action="createOrder" method="post">

        <div class="buyFlow">
            <img class="pull-left" src="img/fore/simpleLogo.png">
            <img class="pull-right" src="img/fore/buyflow.png">
            <div style="clear:both"></div>
        </div>
        <div class="address">
            <div class="addressTip">输入收货地址</div>
            <div>

                <table class="addressTable">
                    <tr>
                        <td class="firstColumn">详细地址<span class="redStar">*</span></td>

                        <td><textarea name="address" placeholder="建议您如实填写详细收货地址，例如街道名称、门牌号码、楼层和房间号等信息"></textarea></td>
                    </tr>
                    <tr>
                        <td>邮政编码</td>
                        <td><input name="post" placeholder="如果您不清楚邮递区号，请填写000000" type="text"></td>
                    </tr>
                    <tr>
                        <td>收货人姓名<span class="redStar">*</span></td>
                        <td><input name="receiver" placeholder="长度不超过25个字符" type="text"></td>
                    </tr>
                    <tr>
                        <td>手机号码 <span class="redStar">*</span></td>
                        <td><input name="mobile" placeholder="请输入11位手机号码" type="text"></td>
                    </tr>
                </table>

            </div>

        </div>
        <div class="productList">
            <div class="productListTip">确认订单信息</div>

            <table class="productListTable">
                <thead>
                <tr>
                    <th colspan="2" class="productListTableFirstColumn">
                        <img class="shbuy" src="img/fore/shbuy.png">
                        <a class="marketLink" href="#nowhere">店铺：SH官方店铺</a>
                        <a class="wangwanglink" href="#nowhere"> <span class="wangwangGif"></span></a>
                    </th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>小计</th>
                    <th>配送方式</th>
                </tr>
                <tr class="rowborder">
                    <td colspan="2"></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                </thead>
                <tbody class="productListTableTbody">
                <c:forEach items="${orderItems}" var="oi" varStatus="st">
                    <tr class="orderItemTR">
                        <td class="orderItemFirstTD"><img class="orderItemImg" src="img/product/${oi.product_id}/1.jpg">
                        </td>
                        <td class="orderItemProductInfo">
                            <a href="foreproduct?pid=${oi.product_id}" class="orderItemProductLink">
                                    ${oi.product.name}
                            </a>

                            <img src="img/fore/creditcard.png" title="支持信用卡支付">
                            <img src="img/fore/7day.png" title="消费者保障服务,承诺7天退货">
                            <img src="img/fore/promise.png" title="消费者保障服务,承诺如实描述">

                        </td>
                        <td>

                                <%--<span class="orderItemProductPrice">￥<fmt:formatNumber type="number"--%>
                                <%--value="${oi.product.price}"--%>
                                <%--minFractionDigits="2"/></span>--%>
                            <span>${oi.product.price}</span>
                        </td>
                        <td>
                            <span class="orderItemProductNumber">${oi.number}</span>
                        </td>
                        <td>
                                <%--<span class="orderItemUnitSum">--%>
                                <%--￥<fmt:formatNumber type="number" value="${oi.product.price*oi.number}"--%>
                                <%--minFractionDigits="2"/>--%>
                                <%--</span>--%>
                            <span>${oi.product.price*oi.number}</span>
                        </td>
                        <c:if test="${st.count==1}">
                            <td rowspan="5" class="orderItemLastTD">
                                <label class="orderItemDeliveryLabel">
                                    <input type="radio" value="" checked="checked">
                                    普通配送
                                </label>

                                <select class="orderItemDeliverySelect" class="form-control">
                                    <option>快递 免邮费</option>
                                </select>

                            </td>
                        </c:if>

                    </tr>
                </c:forEach>

                </tbody>

            </table>
            <div class="orderItemSumDiv">
                <div class="pull-left">
                    <span class="leaveMessageText">给我们留言:</span>
                    <span>
                        <img class="leaveMessageImg" src="img/fore/leaveMessage.png">
                    </span>
                    <span class="leaveMessageTextareaSpan">
					<textarea name="user_message" class="leaveMessageTextarea"></textarea>
					<div>
						<span>还可以输入200个字符</span>
					</div>
				</span>
                </div>

                <span class="pull-right">店铺合计(含运费): ￥${total}</span>
            </div>


        </div>

        <div class="orderItemTotalSumDiv">
            <div class="pull-right">
                <span>实付款：</span>
                <span class="orderItemTotalSumSpan">￥${total}</span>
            </div>
        </div>

        <div class="submitOrderDiv">
            <button type="submit" class="submitOrderButton">提交订单</button>
        </div>
    </form>
</div>

<%@include file="include/footer.jsp" %>
