<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.guigu.vo.MenuInfo" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/10/5
  Time: 22:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工管理</title>
</head>
<body>
<%
    //模拟从数据库查询到拥有权限的菜单代码
    List<MenuInfo> list = (List<MenuInfo>) session.getAttribute("list");
%>
<!-- 添加功能的页面 -->
<div class="export" id="toolbar">
    <button id="new_add" type="button" class="btn btn-primary btn-lg" <% if(!list.contains("userMgr:add")){   %>
            disabled="disabled"
            <% } %>>   <%--data-target="#tianjia"  这个属性可以让模态框不要show也能打开  data-toggle="modal"--%>
        <img src="img/add_two.png"/> <span>添加</span>
    </button>
    <div class="modal fade" id="tianjia">
        <div class="modal-dialog modal-lg modal_position">

            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">添加
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </h4>
                </div>
                <div class="modal-body">
                    <form id="adduser" method="post" target="mainframe">
                        <table id="xztb" class="table">
                            <!-- required 此属性可以设置提示信息-->
                            <tr>
                                <td class="tb_bg"><label>员工姓名</label></td>
                                <td>
                                    <input class="userName" type="text"
                                           placeholder="请输入员工姓名" name="name" required id="name"/></td>
                                <td class="tb_bg">
                                    <label>账户名</label>
                                </td>
                                <td>
                                    <input class="userName" type="text"
                                           placeholder="请输入账户名" name="loginname" required id="loginname"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="tb_bg">
                                    <label>登录密码</label>
                                </td>
                                <td>
                                    <input class="password-field" type="password"
                                           placeholder="请输入登录密码" name="password" required id="password"/>
                                </td>
                        </table>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                            data-dismiss="modal">取消</button>
                    <button id="add_btn" class="btn btn-secondary">确定</button>
                </div>
            </div>

        </div>
    </div>
</div>
<!-- 修改功能的页面 -->
<div class="modal fade" id="xiugai">
    <div class="modal-dialog modal-lg modal_position">

        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">修改
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </h4>
            </div>
            <div class="modal-body">
                <form id="updateuser" method="post" target="mainframe">
                    <table id="xztb1" class="table">
                        <input type="text" hidden name="id" id="id"/>
                        <!-- required 此属性可以设置提示信息-->
                        <tr>
                            <td class="tb_bg"><label>员工姓名</label></td>
                            <td>
                                <input class="userName" type="text"
                                       placeholder="请输入员工姓名" name="name" required id="name1"/></td>
                            <td class="tb_bg">
                                <label>账户名</label>
                            </td>
                            <td>
                                <input class="userName" type="text"
                                       placeholder="请输入账户名" name="loginname" required id="loginname1"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="tb_bg">
                                <label>登录密码</label>
                            </td>
                            <td>
                                <input class="password-field" type="password"
                                       placeholder="请输入登录密码" name="password" required id="password1"/>
                            </td>
                    </table>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary"
                        data-dismiss="modal">取消</button>
                <button id="update_btn" class="btn btn-secondary">确定</button>
            </div>
        </div>
    </div>
</div>
<%--员工数据表--%>
<table id="userlist"></table>
<script>
    //显示员工信息  表格
    $(function () {
        chushihua();
    });

    //生成员工  //初始化表格
    function chushihua() {
        $('#userlist').bootstrapTable({
            url: 'queryUserAll.action',
            //method: 'post',
            toolbar: '#toolbar',
            editable: true,//开启编辑模式
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
            //height: 500,                      //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
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
                    page: (params.offset / params.limit) + 1,  //页码
                };
                return temp;
            },
            columns: [
                /* {field: ' ', title: '复选框', checkbox:true},*/
                {field: 'id', title: '编号', align: 'center',},
                {field: 'name', title: '员工名', align: 'center',},
                {field: 'loginname', title: '账户名', align: 'center',},
                {
                    field: '', title: '操作', align: 'center',
                    formatter: function (value, row, index) {
                        return '<button href="#" class="btn btn-info" onclick="queryuserByid(' + row.id + ')" <% if(!list.contains("userMgr:edit")){   %> disabled="disabled" <% } %>>编辑</button>' +//让href里生成一个id参数
                            '&nbsp;&nbsp;&nbsp;<button href="#" class="btn btn-danger" onclick="del('+row.id+')" <% if(!list.contains("userMgr:delete")){   %> disabled="disabled" <% } %>>删除</button>';
                    }
                }]
        });
    }

    //让添加模态框打开
    $("#new_add").click(function () {
        $("#tianjia").modal("show");
    });
    //添加员工
    $("#add_btn").click(function () {
        //验证参数
        var falg = true;
        //验证名字非空
        /* 拿到姓名的id */
        var user = document.querySelector('#name');
        /* 拿到姓名文本框的值 */
        var name = document.getElementById("name").value;
        if (name == null || name == "") {
            user.setCustomValidity("名字不能为空");
            falg = false;
        } else {
            user.setCustomValidity("");//此语句表示把自设错误状态改为false  语句正确不改状态无法提交
            //验证登录名非空
            /* 拿到登录名的id */
            var loginname = document.querySelector('#loginname');
            /* 拿到登录名文本框的值 */
            var loginnamevar = document.getElementById("loginname").value;
            if (loginnamevar == null || loginnamevar == "") {
                loginname.setCustomValidity("登录名不能为空");
                falg = false;
            } else {
                loginname.setCustomValidity("");//此语句表示把自设错误状态改为false  语句正确不改状态无法提交
                // 验证登录密码非空
                /* 拿到登录密码的id */
                var password = document.querySelector('#password');
                /* 拿到登录密码文本框的值 */
                var passwordvar = document.getElementById("password").value;
                if (passwordvar == null || passwordvar == "") {
                    password.setCustomValidity("登录密码不能为空");
                    falg = false;
                } else {
                    password.setCustomValidity("");//此语句表示把自设错误状态改为false  语句正确不改状态无法提交
                    falg = true;
                }
            }
        }

        if (falg) {
            //判断账号是否被注册
            $.post("panduanzhuce.action", {loginname: $("#loginname").val()}, function (data) {
                if (data=="可以注册"){
                    var param = {
                        url: "addyuangon.action",   //提交地址
                        type: "post",     //提交方式
                        dataType: "json",   //返回数据类型
                        success: function (data) {   // 回调函数

                            if (data.code == "1") {
                                //添加成功提示
                                $.showPromptSuccess(data.msg);
                                //添加成功关闭页面
                                $("#tianjia").modal("hide");
                                //清除数据
                                $("#tianjia input").val("");
                                //刷新表格
                                $('#userlist').bootstrapTable('refresh');
                            }
                        }
                    };
                    //完成表单提交
                    $("#adduser").ajaxSubmit(param);
                }else {
                    $.showPromptDanger(data);
                }
            });

        } else {
            //添加失败提示
            $.showPromptDanger("添加失败");
        }
    });

    //删除员工
    function del(id) {
        //alert(id)
        $.post("deluser.action", {id: id}, function (data) {
                if (data==1){
                    $.showPromptSuccess("删除成功");
                    $('#userlist').bootstrapTable('refresh');
                }
        });
    }

    //查询要修改的数据的详情
    function queryuserByid(id){
        //alert(id)
        //让修改模态框打开
        $("#xiugai").modal("show");
        //根据id查询员工详情 并赋值给修改的模态框
        $.post("queryuserByid.action", {id: id}, function (data) {
            //不等于null就是找到了 按理说也不会找不到
            if (data!=null){
                //赋值给修改的模态框的input
                $("#id").val(data.id)
                $("#name1").val(data.name)
                $("#loginname1").val(data.loginname)
                $("#password1").val(data.password)
            }
        })
    }
    //修改员工
    $("#update_btn").click(function () {
        //验证参数
        var falg = true;
        //验证名字非空
        /* 拿到姓名的id */
        var user = document.querySelector('#name1');
        /* 拿到姓名文本框的值 */
        var name = document.getElementById("name1").value;
        if (name == null || name == "") {
            user.setCustomValidity("名字不能为空");
            falg = false;
        } else {
            user.setCustomValidity("");//此语句表示把自设错误状态改为false  语句正确不改状态无法提交
            //验证登录名非空
            /* 拿到登录名的id */
            var loginname = document.querySelector('#loginname1');
            /* 拿到登录名文本框的值 */
            var loginnamevar = document.getElementById("loginname1").value;
            if (loginnamevar == null || loginnamevar == "") {
                loginname.setCustomValidity("登录名不能为空");
                falg = false;
            } else {
                loginname.setCustomValidity("");//此语句表示把自设错误状态改为false  语句正确不改状态无法提交
                // 验证登录密码非空
                /* 拿到登录密码的id */
                var password = document.querySelector('#password1');
                /* 拿到登录密码文本框的值 */
                var passwordvar = document.getElementById("password1").value;
                if (passwordvar == null || passwordvar == "") {
                    password.setCustomValidity("登录密码不能为空");
                    falg = false;
                } else {
                    password.setCustomValidity("");//此语句表示把自设错误状态改为false  语句正确不改状态无法提交
                    falg = true;
                }
            }
        }

        if (falg) {
            //判断账号是否被注册
            $.post("panduanzhuce.action", {loginname: $("#loginname1").val()}, function (data) {
                if (data=="可以注册"){
                    var param = {
                        url: "updateyuangon.action",   //提交地址
                        type: "post",     //提交方式
                        dataType: "json",   //返回数据类型
                        success: function (data) {   // 回调函数
                            if (data == 1) {
                                //修改成功提示
                                $.showPromptSuccess("修改成功");
                                //修改成功关闭页面
                                $("#xiugai").modal("hide");
                                //清除数据
                                $("#updateuser input").val("");
                                //刷新表格
                                $('#userlist').bootstrapTable('refresh');
                            }
                        }
                    };
                    //完成表单提交
                    $("#updateuser").ajaxSubmit(param);
                }else {
                    $.showPromptDanger(data);
                }
            });

        } else {
            //修改失败提示
            $.showPromptDanger("修改失败");
        }
    });




    //定义验证规则
    // extend the 'equals' rule
    /* $.extend($.fn.validatebox.defaults.rules, {

         chinese : {// 验证中文
             validator : function(value) {

                 return /^[\Α-\￥]+$/i.test(value);
             },
             message : '请输入中文'
         },
     });*/
</script>
</body>
</html>
