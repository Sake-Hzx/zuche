<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/10/5
  Time: 22:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人中心页面</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet"/>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-table.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-table-zh-CN.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap-table.min.css">
    <%--样式--%>
    <link rel="stylesheet" type="text/css" href="css3/style.css"/>
    <%--表单提交--%>
    <script src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
    <%--提示框--%>
    <script src="${pageContext.request.contextPath}/js/bootstrap-extend.js"></script>
    <link href="${pageContext.request.contextPath}/css/bootstrap-extend.css" rel="stylesheet">
    <style>
        body{
            margin: 0;
        }
        #xx {
            margin-left: 30px;
            /*去除下划线 */
           /* text-decoration:none;*/
            float: left;
        }
        #mz {
           /* margin-left: 30px;*/
            /*去除下划线 */
            text-decoration:none;
            /*float: left;*/
        }
        #balance {
            /*margin-left: 70px;*/
            /*去除下划线 */
            text-decoration:none;
           /* float: left;*/
        }
        #timer {
            margin-right: 30px;
            float: right;
        }
    </style>
</head>
<body>
<div class="row text-center">
    <div>
        <h2 class="page-header" style="color: #ac85d3">个人中心</h2>
        <label id="timer" style="color: orange;"></label>
    </div>

    <div id="xx">
        <%--点击名字注销session 退出登录--%>
        <a id="mz" href="zhuxiao.action" style="color: #3ea2ee">${zukeuser.name},欢迎您!，点击退出登录</a><br>
        <%--显示余额--%>
        <p style="color: red">余额为:<a id="balance" href="#" style="color: red"></a>，点击充值</p>
    </div>
</div>
<span id="toolbar">我的订单:</span>
<table id="dingdan"></table>

<!-- 充值功能的页面 -->
<div class="modal fade" id="chonzhi">
    <div class="modal-dialog modal-lg modal_position">

        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">充值
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </h4>
            </div>
            <div class="modal-body">
                    <table id="xztb" class="table">
                        <!-- required 此属性可以设置提示信息-->
                        <tr>
                            <td class="tb_bg"><label>充值金额</label></td>
                            <td>
                                <input class="userName" type="number"
                                       placeholder="请输入金额" name="jine" required id="jine"/>
                            </td>
                        </tr>
                    </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary"
                        data-dismiss="modal">取消</button>
                <button id="chonzhi_btn" class="btn btn-secondary">确定</button>
            </div>
        </div>
    </div>
</div>
<!-- 还车功能的页面 -->
<div class="modal fade" id="zhifu">
    <div class="modal-dialog modal-lg modal_position">

        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">还车
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </h4>
            </div>
            <div class="modal-body">
                <table id="xztb1" class="table">
                    <!-- required 此属性可以设置提示信息-->
                    <tr>
                        <%--订单id--%>
                        <td hidden><input id="ddid" hidden></td>
                        <td class="tb_bg" height="100px" style="font-size: 40px">是否支付<a id="zujin" style="color: red;font-size: 40px">xx</a>元归还车辆</td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary"
                        data-dismiss="modal">取消</button>
                <button id="zhifu_btn" class="btn btn-secondary">确定</button>
            </div>
        </div>
    </div>
</div>
<script>
    //查询余额
    function chaxunBalance() {
        $.post("chaxunBalance.action", {id:${zukeuser.id}}, function (data) {
            //给余额框赋值
            $("#balance").text(data);
        })
    }
    //显示这个用户的订单信息  表格
    $(function () {
        chaxunBalance();
        var id=${zukeuser.id};

        //初始化表格
        $('#dingdan').bootstrapTable({
            url: 'queryDingdanByid.action?id='+id,
            //method: 'GET',                      //请求方式（*）
            toolbar: '#toolbar',
            editable: true,                     //开启编辑模式
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            clickToSelect: true,                //是否启用点击选中行
            search: true,                      //是否显示表格搜索
            //searchable: true,
            showColumns: false,                  //是否显示所有的列（选择显示的列）
            showRefresh: true,                  //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            height: 400,                      //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            showToggle: true,                   //是否显示详细视图和列表视图的切换按钮
            //cardView: true,                    //是否显示详细视图
            //detailView: false,                   //是否显示详细视图
            singleSelect: true,                      //单选
            //******前端分页设置****//
            pagination: true,
            sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,
            pageSize: 5,
            pageList: "[5, 10, 25, 50, 100]",
            paginationHAlign: "left",
            paginationDetailHAlign: "right",
            //******前端分页设置****//

            //得到查询的参数
            queryParams: function (params) {
                //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                var temp = {
                    rows: params.limit,                         //页面大小
                    page: (params.offset / params.limit) + 1  //页码

                };
                return temp;
            },
            columns: [{
                field: 'zucarid',
                title: '编号'
            }, {
                field: 'cartype',
                title: '车类型'
            }, {
                field: 'zucardidian',
                title: '租车地址'
            }, {
                field: 'rentalTime',
                title: '租车时间'
            }, {
                field: 'huancarTime',
                title: '还车时间'
            }, {
                field: 'deposit',
                title: '押金'
            }, {
                field: 'name',
                title: '审批人'
            }, {
                field: 'state', title: '状态', formatter: function (value) {
                    if (value==0){
                        return "待审核";
                    }else if (value==1){
                        return "租赁中";
                    }else if (value==2){
                        return "已拒绝";
                    }else if (value==3){
                        return "已结算";
                    }else if (value==4){
                        return "还车待审核";
                    }
                }
            },{
                field: '', title: '操作', align: 'center',
                formatter: function (value, row, index) {

                    if (row.state!=1){
                        return '无';
                    }
                    return '<button href="#" class="btn btn-info" onclick="huanche(' + row.zucarid + ')">还车</button>'
                }
            }],

        });
    });
    //充值模态框打开
    $("#balance").click(function () {
        $("#chonzhi").modal("show");
    });
    //确认充值
    $("#chonzhi_btn").click(function () {
        //获取充值框的值
        var jine = $("#jine").val();
        if (jine<0){
            $.showPromptDanger("充值金额必须大于0");
            return
        }
        if (jine==null||jine==""){
            $.showPromptDanger("充值金额必须是数字");
        }else {
            //完成充值
            $.post("chonzhi.action", {id:${zukeuser.id},jine: jine}, function (data) {
                if (data=="充值成功"){
                    $.showPromptSuccess(data);
                    //关闭页面
                    $("#chonzhi").modal("hide");
                    //清除数据
                    $("#jine").val("");
                    //刷新余额显示
                    chaxunBalance();
                }
            });
        }

    })
    //还车方法
    function huanche(id) {
        //发送还车申请
        $.post("fanhuizujin.action", {id: id}, function (data) {
            //提示是否支付租金XX并还车
            //打开是否确定支付租金还车模态框
            $("#zhifu").modal("show");
            //给租金赋值
            $("#zujin").text(data)
            //传一个订单id到模态框  ddid
            $("#ddid").val(id)
        });
    }
    //点击还车按钮 确定还车方法
    $("#zhifu_btn").click(function () {
        //获取租金
        var zujin=$("#zujin").text();
        //获取余额
        var balance =$("#balance").text();
        //获取订单id
       var ddid=$("#ddid").val();
        //判断是否余额足够支付
        if (balance*1>=zujin*1){ //加*1是为了转换成数字
            //提交还车申请
            $.post("huancheshenqin.action", {ddid: ddid,zujin:zujin}, function (data) {
               //alert(data)
                if (data="还车申请提交成功"){
                    //提示还车申请提交成功
                    $.showPromptSuccess(data);
                    //关闭模态框
                    $("#zhifu").modal("hide");
                    //刷新余额的值
                    chaxunBalance();
                    //刷新表格
                    $('#dingdan').bootstrapTable('refresh');
                }
            });

        }else {
            $.showPromptDanger("余额不足以支付租金，请充值");
        }
    });


    //获取时间的年 月  日   小时  分  秒
    //获取当前时间
    function time() {
        var date = new Date();
        var year = date.getFullYear();
        //月份加1  0-11月
        var month = date.getMonth() + 1;
        //日
        var day = date.getDate();
        // 小时
        var hour = date.getHours();
        //分钟
        var minute = date.getMinutes();
        //秒
        var second = date.getSeconds();
        var str = year + "年" + month + "月" + day + "日" + hour + "时" + minute
            + "分" + second + "秒";
        document.getElementById("timer").innerHTML = str;
    }
    setInterval("time()", 1000);
    //计时器放里面 不加双引号能执行并且能赋第一遍值 但是弹窗会一直有值
</script>
</body>
</html>
