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
    <title>登录界面</title>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <link rel="stylesheet" href="css/bootstrap.css" />

    <%--提示框--%>
    <script src="${pageContext.request.contextPath}/js/bootstrap-extend.js"></script>
    <link href="${pageContext.request.contextPath}/css/bootstrap-extend.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <fieldset>
                <legend style="color: #7abaff">地平线租车登录</legend>
                <div class="form-group has-success has-feedback">
                    <label for="loginname" class="control-label">账号名：</label>
                    <input type="text"  id="loginname" name="loginname" class="form-control" placeholder="请输入账号名" />
                </div>
                <div class="form-group has-warning">
                    <label for="pwd" class="control-label">密码：</label>
                    <input type="password" id="pwd" name="pwd" class="form-control" placeholder="请输入密码" />
                </div>
                <br>
                <div class="row">
                    <input type="submit" class="btn btn-primary col-md-12" value="登录" onclick="login()" /><br>
                </div>
                <br>
                <div class="row">
                    <input type="submit" class="btn btn-warning col-md-12 " value="注册" onclick="zhuce()"/>
                </div>
               <%-- <br>
                <div class="row">
                <input type="submit" class="btn btn-primary col-md-12" value="员工登录" onclick="yuangonlogin()" />
                </div>--%>
            </fieldset>
        </div>
    </div>
</div>

<script>
    function login() {
        //登录的时候获取账户名 去查询员工表里有没有 然后返回实体
        // 拿到是否是员工字段 判断他该去哪个页面

        //因为写了账户名的判断  租客登录只能是 长度是11位的手机号码
        //员工没有限制  或许为了避免bug可以给员工账户名限定长度小于11位

        //直接登录 设置这个员工表里的实体为session 返回  直接返回实体也可以
        // 然后在jsp页面 获取是否是员工字段 再分别跳转页面

        //取第二种吧 不想写xml了
        var loginnamelength=$("#loginname").val().length
        if (loginnamelength==11){
            $.post("login.action", {loginname: $("#loginname").val(),pwd: $("#pwd").val()}, function (data) {
                if (data=="登录成功"){
                    $.showPromptSuccess(data);
                    $(location).attr('href', 'shouye.jsp');
                }else {
                    $.showPromptDanger(data);
                }
            },"text");
        }else {
            $.post("yuangonlogin.action", {loginname: $("#loginname").val(),pwd: $("#pwd").val()}, function (data) {
                if (data=="登录成功"){
                    $.showPromptSuccess(data);
                    $(location).attr('href', 'index.jsp');
                }else {
                    $.showPromptDanger(data);
                }
            },"text");
        }

    }
    //租客登录
   /* function login() {
        $.post("login.action", {loginname: $("#loginname").val(),pwd: $("#pwd").val()}, function (data) {
            if (data=="登录成功"){
                $.showPromptSuccess(data);
                $(location).attr('href', 'shouye.jsp');
            }else {
                $.showPromptDanger(data);
            }
        },"text");
    }*/
    //注册
    function zhuce() {
        $(location).attr('href', 'zhuce.jsp');
    }
    //员工登录
    /*function yuangonlogin() {
        $.post("yuangonlogin.action", {loginname: $("#loginname").val(),pwd: $("#pwd").val()}, function (data) {
            if (data=="登录成功"){
                $.showPromptSuccess(data);
                $(location).attr('href', 'index.jsp');
            }else {
                $.showPromptDanger(data);
            }
        },"text");
    }*/
</script>
</body>
</html>
