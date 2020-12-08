<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<!--首页-->
<head>

    <title>地平线租车</title>
    <meta charset="UTF-8"/>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-table.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-table-zh-CN.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap-table.min.css">

    <link href="css/animate.min.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link href="css/style.css" rel="stylesheet">
    <%--样式--%>
    <%--<link rel="stylesheet" type="text/css" href="css3/style.css"/>--%>
    <%--表单提交--%>
    <script src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
    <%--提示框--%>
    <script src="${pageContext.request.contextPath}/js/bootstrap-extend.js"></script>
    <link href="${pageContext.request.contextPath}/css/bootstrap-extend.css" rel="stylesheet">
    <style>
        #xztb tr td {
            background: #fff;
            padding: 0.25px !important;
        }

        #xztb tr td input {
            width: 100% !important;
            padding: 0 0.5rem;
            height: 35px;
        }

        #xztb tr .tb_bg {
            background: #f5f7fa;
        }
    </style>
</head>

<body id="page-top">
<%--判断租客有没有登录--%>
<input type="text" value="${zukeuser.name}" id="a" style="display: none"/>
<%--<c:if test="${empty zukeuser.name}">
    <script type="text/javascript">
        alert(1111)
    </script>
</c:if>--%>


<div class="navbar-wrapper">
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="navbar-header page-scroll">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                        aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <!--logo-->
                <a class="navbar-brand" href="#">地平线租车</a>

            </div>
            <!--导航栏-->
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li><a class="page-scroll" href="#page-top">首页</a></li>
                    <li><a class="page-scroll" href="#features">自驾租车</a></li>
                    <li><a class="page-scroll" href="#team">国际租车</a></li>
                    <li><a class="page-scroll" href="#testimonials">自驾游</a></li>
                    <li><a class="page-scroll" href="#pricing">企业服务</a></li>
                    <li><a class="page-scroll" href="#contact">联系我们</a></li>
                    <li><a id="zukeming" class="page-scroll" href="#" style="color: green;">请登录</a></li>
                </ul>
            </div>
        </div>
    </nav>
</div>
<div id="inSlider" class="carousel slide carousel-fade" data-ride="carousel">
    <ol class="carousel-indicators">
        <li data-target="#inSlider" data-slide-to="0" class="active"></li>
        <li data-target="#inSlider" data-slide-to="1"></li>
    </ol>
    <div class="carousel-inner" role="listbox">
        <div class="item active">
            <div class="container">
                <div class="carousel-caption">
                    <h1>道路千万条，<br/> 安全第一条。<br/> 行车不规范，<br/> 亲人两行泪。</h1>
                    <p>温馨提示:开酒不喝车</p>
                    <p>
                        <a id="lijixuanche" class="btn btn-lg btn-primary" role="button">立即选车</a>
                        <!--<a class="caption-link" href="#" role="button">Inspinia Theme</a>-->
                    </p>
                </div>
            </div>

            <div class="header-back one"></div>
        </div>
        <div class="item">
            <div class="container">
                <div class="carousel-caption blank">
                    <h1>你想要 <br/> 让自己空闲的车产生收益吗</h1>
                    <p>快点击下方"成为车主"让自己多一份外快吧</p>
                    <p><a class="btn btn-lg btn-primary" href="#" role="button">成为车主</a></p>
                </div>
            </div>

            <div class="header-back two"></div>
        </div>
    </div>
    <!--左右翻页-->
    <a class="left carousel-control" href="#inSlider" role="button" data-slide="prev">
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#inSlider" role="button" data-slide="next">
        <span class="sr-only">Next</span>
    </a>
</div>
<section id="features" class="container services">
    <div class="row">
        <div class="col-sm-3">
            <h2>自驾租车</h2>
            <p>自驾租车自驾租车自驾租车自驾租车自驾租车自驾租车自驾租车自驾租车自驾租车自驾租车</p>
            <p><a class="navy-link" href="#" role="button">自驾租车 &raquo;</a></p>
        </div>
        <div class="col-sm-3">
            <h2>国际租车</h2>
            <p>国际租车国际租车国际租车国际租车国际租车国际租车国际租车</p>
            <p><a class="navy-link" href="#" role="button">国际租车 &raquo;</a></p>
        </div>
        <div class="col-sm-3">
            <h2>自驾游</h2>
            <p>自驾游自驾游自驾游自驾游自驾游自驾游自驾游自驾游自驾游自驾游自驾游</p>
            <p><a class="navy-link" href="#" role="button">自驾游 &raquo;</a></p>
        </div>
        <div class="col-sm-3">
            <h2>企业服务</h2>
            <p>企业服务企业服务企业服务企业服务企业服务企业服务企业服务企业服务企业服务</p>
            <p><a class="navy-link" href="#" role="button">企业服务 &raquo;</a></p>
        </div>
    </div>
</section>

<section class="container features">
    <div class="row">
        <div class="col-lg-12 text-center">
            <div class="navy-line"></div>
            <h1>广告位招租<br/> <span class="navy"> 广告位招租广告位招租</span></h1>
            <p>广告位招租广告位招租广告位招租</p>
        </div>
    </div>
    <div class="row">
        <div class="col-md-3 text-center wow fadeInLeft">
            <div>
                <!--<i class="fa fa-mobile features-icon"></i>-->
                <h2>广告位招租</h2>
                <p>广告位招租广告位招租广告位招租广告位招租广告位招租广告位招租</p>
            </div>
            <div class="m-t-lg">
                <!--<i class="fa fa-bar-chart features-icon"></i>-->
                <h2>广告位招租</h2>
                <p>广告位招租广告位招租广告位招租广告位招租广告位招租广告位招租</p>
            </div>
        </div>
        <div class="col-md-6 text-center  wow zoomIn">
            <img src="img/perspective.png" alt="dashboard" class="img-responsive">
        </div>
        <div class="col-md-3 text-center wow fadeInRight">
            <div>
               <!-- <i class="fa fa-envelope features-icon"></i>-->
                <h2>广告位招租</h2>
                <p>广告位招租广告位招租广告位招租广告位招租广告位招租广告位招租</p>
            </div>
            <div class="m-t-lg">
                <!--<i class="fa fa-google features-icon"></i>-->
                <h2>广告位招租</h2>
                <p>广告位招租广告位招租广告位招租广告位招租广告位招租广告位招租</p>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12 text-center">
            <div class="navy-line"></div>
            <h1>广告位招租</h1>
            <p>广告位招租广告位招租广告位招租广告位招租广告位招租</p>
        </div>
    </div>
    <div class="row features-block">
        <div class="col-lg-6 features-text wow fadeInLeft">
            <small>广告位招租</small>
            <h2>广告位招租</h2>
            <p>广告位招租广告位招租广告位招租广告位招租广告位招租广告位招租广告位招租广告位招租...............</p>
            <a href="" class="btn btn-primary">联系作者</a>
        </div>
        <div class="col-lg-6 text-right wow fadeInRight">
            <img src="img/7.jpg" alt="dashboard" class="img-responsive pull-right">
        </div>
    </div>
</section>

<section id="contact" class="gray-section contact">
    <div class="container">
        <div class="row m-b-lg">
            <div class="col-lg-12 text-center">
                <div class="navy-line"></div>
                <h1>联系我们</h1>
                <p>您的每一条意见我们都会认真阅读</p>
            </div>
        </div>
        <div class="row m-b-lg">
            <div class="col-lg-3 col-lg-offset-3">
                <address>
                    <strong><span class="navy">地平线租车公司</span></strong><br/>
                   湖南省长沙市XX区XX街道XXXX<br/>
                    <abbr title="Phone">联系电话:</abbr> XXXXXX
                </address>
            </div>
            <div class="col-lg-4">
                <p class="text-color">
                    公司介绍 公司介绍 公司介绍 公司介绍 公司介绍 公司介绍 公司介绍 公司介绍 公司介绍 公司介绍 公司介绍
                    公司介绍 公司介绍 公司介绍 公司介绍 公司介绍 公司介绍 公司介绍 公司介绍 公司介绍 公司介绍 公司介绍
                </p>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 text-center">
                <a href="/cdn-cgi/l/email-protection#e591809691a58088848c89cb868a88" class="btn btn-primary">反馈BUG提交意见</a>
                <p class="m-t-sm">
                    1430191568@qq.com
                </p>
            </div>
        </div>
    </div>
</section>
<!-- 订车的页面 -->
<div class="modal fade" id="dingche">
    <div class="modal-dialog modal-lg modal_position">

        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">订车
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </h4>
            </div>
            <div class="modal-body">
                <table id="xztb" class="table">
                    <!-- required 此属性可以设置提示信息-->
                    <tr>
                        <td class="tb_bg"><label>请选择车辆</label></td>
                        <td>
                           <select id="car" name="car" editable="false" style="width: 145px" onchange="che()">
                               <option value="0" selected="selected">---请选择---</option>
                               <option value="1">五菱宏光</option>
                               <option value="2">奔驰</option>
                               <option value="3">宝马</option>
                           </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="tb_bg"><label>填写租车地址</label></td>
                        <td>
                            <input class="userName" type="text"
                                   placeholder="请输入地址" name="zucardidian" required id="zucardidian"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="tb_bg"><label>押金</label></td>
                        <td>
                            <a id="yajin" style="color: #CC2222;font-size: 20px">0</a><a>元</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="tb_bg"><label>日租金</label></td>
                        <td>
                            <a id="rizujin" style="color: #CC2222;font-size: 20px">0</a><a>元</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary"
                        data-dismiss="modal">取消</button>
                <button id="dingche_btn" class="btn btn-secondary">确定</button>
            </div>
        </div>
    </div>
</div>


<script src="js/pace.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/classie.js"></script>
<script src="js/cbpAnimatedHeader.js"></script>
<script src="js/wow.min.js"></script>
<script src="js/inspinia.js"></script>

<script>
    //获取session的值
    var zhi=$("#a").val() + '';
    $(function () {
        //清除订车页面里的数据
        $("#car").val("0");
        $("#zucardidian").val("");
        $("#yajin").text("0")
        $("#rizujin").text("0")
        //alert(zhi)
        if (zhi!=null && zhi!=""){
            //设置名字为xxx，欢迎您
            $("#zukeming").text(${zukeuser.name}+",欢迎您!")
            //alert($("#zukeming").text())
        }
    });
    //给欢迎您的位置 加上一个个人中心 可以点击退出登录 修改名字 查看订单
    $("#zukeming").click(function () {
        if (zhi!=null && zhi!=""){
            $(location).attr('href', 'gerenzhonxing.jsp');
        }else {
            $(location).attr('href', 'login.jsp');
        }

    });
    var balance="";
    //点击立即选车开始判断
    $("#lijixuanche").click(function () {
        //判断租客有没有登录
        if (zhi==null || zhi==""){
            //跳转到登录页面
            $(location).attr('href', 'login.jsp');
        }else {
            //写一个订车的模态框
            $("#dingche").modal("show");
            //余额     获取session的值 一定要记得打单引号''
            $.post("chaxunBalance.action", {id:'${zukeuser.id}'}, function (data) {
                //给余额赋值
                balance=data;
            })
        }
    });
    //下拉框值改变改变显示押金的值  显示该车的日租金
    //车是死值这些也都写死值
     function che() {
        //alert($("#car").val())
        if ($("#car").val()==1){
            $("#yajin").text("2000")
            $("#rizujin").text("500")
        }
        if ($("#car").val()==2){
            $("#yajin").text("2500")
            $("#rizujin").text("1000")
        }
        if ($("#car").val()==3){
            $("#yajin").text("3000")
            $("#rizujin").text("1500")
        }
    }
   //完成订车
    $("#dingche_btn").click(function () {

        //alert(balance)
        //顾客id
        var gukeid="${zukeuser.id}"
        //alert(gukeid)
        //判断 顾客余额足够就提交订单 并且扣钱 没审核也扣 审核拒绝了就退还钱
        if (balance*1>$("#yajin").text()*1){
            //判断有没有选车
            if ($("#car").val()==0){
                //alert("请选择车辆")
                $.showPromptDanger("请选择车辆");
            }else {
                //判断地址是不是空的
                if ($("#zucardidian").val()==null||$("#zucardidian").val()==""){
                    //alert("请填写地址")
                    $.showPromptDanger("请填写地址");
                }else {
                    //提交订单
                    $.post("dingdan.action", {carid:$("#car").val(),gukeid:gukeid,zucardidian:$("#zucardidian").val(),deposit: $("#yajin").text()}, function (data) {
                        if (data=="成功"){
                            //alert("已提交订单")
                            $.showPromptSuccess("已提交订单");
                            //关闭页面
                            $("#dingche").modal("hide");
                            //清除数据
                            $("#car").val("0");
                            $("#zucardidian").val("");
                            $("#yajin").text("0")
                            $("#rizujin").text("0")
                        }
                    });
                }
            }
        }else {
            //不够就提示 请去个人中心充值
            //alert("余额不够，请充值")
            $.showPromptDanger("余额不够，请充值");
        }

    });
</script>
</body>

</html>