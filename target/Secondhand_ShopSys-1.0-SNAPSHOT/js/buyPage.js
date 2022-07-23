$(function () {
    $("a.productDetailTopReviewLink").click(function () {
        $("div.productReviewDiv").show();
        $("div.productDetailDiv").hide();
    });
    $("a.productReviewTopPartSelectedLink").click(function () {
        $("div.productReviewDiv").hide();
        $("div.productDetailDiv").show();
    });

    $("span.leaveMessageTextareaSpan").hide();
    $("img.leaveMessageImg").click(function () {

        $(this).hide();
        $("span.leaveMessageTextareaSpan").show();
        $("div.orderItemSumDiv").css("height", "100px");
    });

    $("div#footer a[href$=#nowhere]").click(function () {
        alert("并没有跳转到实际的页面");
    });


    $("a.wangwanglink").click(function () {
        alert("并不会打开旺旺");
    });
    $("a.notImplementLink").click(function () {
        alert("这个功能没做，蛤蛤~");
    });
});