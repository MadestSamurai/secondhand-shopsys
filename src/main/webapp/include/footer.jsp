<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>

<%@include file="modal.jsp" %>

<style>
    div.footer {
        margin: 0px 0px;
        border-top: 1px solid #D1D1DC;
    }

    a:hover {
        text-decoration: none;
    }

    div.tmall-ensure {
        margin-top: 24px;
        margin-bottom: 24px;
        text-align: center;
    }

    div.tmall-desc dl a {
        width: 100px;
        overflow: hidden;
        text-align: left;
        height: 20px;
        line-height: 20px;
        color: #8b8b8b;
    }

    div.tmall-desc dl {
        float: left;
        width: 20%;
        padding-left: 52px;
    }

    div.tmall-desc dl dt {
        color: #646464;
        font-size: 16px;
        font-weight: 700;
        height: 30px;
        line-height: 30px;
        text-align: left;
    }

    div.tmall-desc dl dd {
        text-align: left;
    }

    div.sh-copyright {
        background-color: black;
        border-top: 2px solid #f39800;
    }

    div.footer-copyright div.copyRightYear {
        margin: 5px 10px;
        color: #f8f8f8;
    }

</style>

<div id="footer" class="footer" style="display: block;">

    <div class="workArea">
        <div class="tmall-ensure">
            <img src="../img/fore/footer1.png">
            <img src="../img/fore/footer2.png">
            <img src="../img/fore/footer3.png">
        </div>

        <div style="clear:both"></div>
    </div>

    <div class="sh-copyright">
        <div class="workArea">
            <div class="mui-global-fragment-load">
                <div class="footer-copyright">
                    <div class="copyRightYear">© 2021 SH.COM 版权所有</div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>