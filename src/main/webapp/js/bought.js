let deleteOrder = false;
let deleteOrderId = 0;

$(function () {
    $("a[orderStatus]").click(function () {
        const orderStatus = $(this).attr("orderStatus");
        if ('all' == orderStatus) {
            $("table[orderStatus]").show();
        }
        else {
            $("table[orderStatus]").hide();
            $("table[orderStatus=" + orderStatus + "]").show();
        }

        $("div.orderType div").removeClass("selectedOrderType");
        $(this).parent("div").addClass("selectedOrderType");
    });

    $("a.deleteOrderLink").click(function () {
        deleteOrderId = $(this).attr("oid");
        deleteOrder = false;
        $("#deleteConfirmModal").modal("show");
    });

    $("button.deleteConfirmButton").click(function () {
        deleteOrder = true;
        $("#deleteConfirmModal").modal('hide');
    });

    $('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
        if (deleteOrder) {
            var page = "deleteOrder";
            $.post(
                page,
                {"order_id": deleteOrderId},
                function (result) {
                    if ("success" == result) {
                        $("table.orderListItemTable[oid=" + deleteOrderId + "]").hide();
                    }
                    else {
                        location.href = "login.jsp";
                    }
                }
            );

        }
    })

    $(".ask2delivery").click(function () {
        const link = $(this).attr("link");
        $(this).hide();
        $.ajax({
            url: link,
            success: function (result) {
                alert("当前货物已秒发，刷新当前页面，即可进行确认收货")
            }
        });

    });
});