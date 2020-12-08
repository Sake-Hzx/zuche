<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/9/27
  Time: 15:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>地平线租车后台管理</title>
    <meta charset="UTF-8" />

   <%-- <!-- bootstrap核心样式文件 -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- jquery库 必须在其他js库前引入-->
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <!-- bootstrap库 必须在其他js库前引入-->
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/bootstrap-menu.js"></script>
    <link rel="stylesheet" href="css/bootstrap-table.min.css">--%>
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
        #mz {
            margin-left: 30px;
             /*去除下划线 */
            text-decoration:none;
            float: left;
        }
        #timer {
            margin-right: 30px;
            float: right;
        }
    </style>
</head>
<body>
<div>
    <div class="row text-center">
        <div>
            <h2 class="page-header" style="color: #ac85d3">地平线租车管理系统</h2>
            <label id="timer" style="color: orange;"></label>
        </div>
        <a id="mz" href="login.jsp" style="color: #3ea2ee">${yuangonuser.name},欢迎您！</a>
    </div>
    <div class="row" style="margin-top: 10px">
        <%--<ul id="menu" class="col-md-2"></ul>
        <div id="tabsDemo" class="col-md-10">
            <ul class="nav nav-pills"></ul>
            <div class="tab-content" style="margin-top: 20px;padding-top: 20px;border-top: 1px solid pink"></div>
        </div>--%>
            <!-- 菜单选项 -->
            <div class="col-xs-12 col-sm-3 col-lg-2 column">
                <div id="bs-menu-tree" style="padding: 0"></div>
            </div>
            <!-- 选项卡 -->
            <div class="col-xs-12 col-sm-9 col-lg-10 column">
                <div id="bs-menu-tabs"></div>
            </div>
    </div>
</div>

<script>
    $(function () {
        //初始化选项卡
        $("#bs-menu-tabs").initTabs();
        //初始化树节点
        $("#bs-menu-tree").loadTree({
            data : {
                url : "queryallmenus2.action?rid=2", //登录 这个可以写判断这个角色有没有这个管理页面的权限 权限精确到按钮级了 没必要
                type : "get"
            },
            process : {
                open : false,
                icon : 'iconUrl',
               /* checkbox : {
                    enable: true,
                    name: undefined,
                    value: 'name',
                    checked: undefined,
                    onChecked: undefined
                },*/
                title : 'name',
                text : 'name',
                after : undefined,
                child : function (item,index,layer) {
                    //return layer < 2 && item.bsMenus;
                    return layer < 2 && item.childMenu; //两级效果 授权要三级 layer < 2 &&
                },
                onChick : function (e,node,type) {
                    if (type === 'child') {
                        $("#bs-menu-tabs").addTabs(node.text(),node.data("image"),node.data("url")); //页面点开的路径有问题
                        console.log(node.data("url"));
                    }
                },
                custom : function (li,item,index,layer) {
                    li.children("span").data("url",item.linkUrl).data("image",item.iconUrl);  //linkUrl是数据库跳转地址
                }
            },
            fill : true,
            fontSize : 15
        });
        $("#select").click(function () {
            let temp = $("#bs-menu-tree").getSelectTree(true);
            for (let i = 0; i < temp.length; i++) {
                console.log(temp[i].value);
            }
        })
    })
    /*$(function () {

        let param = {
            url: 'Demo02.json',
            type: 'post',
            ulDoc: '#menu',
            tabDoc: '#tabsDemo',
            /!*checkbox: true*!/
        }
        chu(param)
    })*/
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