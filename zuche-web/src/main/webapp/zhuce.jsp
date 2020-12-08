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
    <title>注册页面</title>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <link rel="stylesheet" href="css/bootstrap.css" />

    <link href="${pageContext.request.contextPath}/css/bootstrap-extend.css" rel="stylesheet">
    <%--提示框--%>
    <script src="${pageContext.request.contextPath}/js/bootstrap-extend.js"></script>

</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <fieldset>
                <legend style="color: #7abaff">地平线租车注册</legend>
                <div class="form-group has-success has-feedback">
                    <label for="loginname" class="control-label">手机号：</label>
                    <input type="text"  id="loginname" name="loginname" class="form-control" placeholder="请输入手机号" />
                </div>
                <div class="form-group has-warning">
                    <label for="pwd" class="control-label">密码：</label>
                    <input type="password" id="pwd" name="pwd" class="form-control" placeholder="请输入密码" />
                </div>
                <br>
                <div class="row">
                    <input type="submit" class="btn btn-warning col-md-12" value="注册" onclick="zhuce()" /><br>
                </div>
                <br>
                <div class="row">
                    <input type="submit" class="btn btn-info col-md-12 " value="返回登录界面" onclick="fanhui()"/>
                </div>
            </fieldset>
        </div>
    </div>
</div>
<script>
    //注册方法
    function zhuce() {
        /* 拿到电话号码文本框的值 */
        var loginname = document.getElementById("loginname").value;
        //验证电话号码为11位数
        if (loginname.length==11) {
            /* 拿到密码文本框的值 */
            var pwd = document.getElementById("pwd").value;
            //验证密码不能为空
            if (pwd== null || pwd == ""){
                $.showPromptDanger("密码不能为空");
            }else {
                //判断账号是否被注册
                $.post("panduanzhuce.action", {loginname: $("#loginname").val()}, function (data) {

                    if (data=="可以注册"){
                        //提交注册
                        $.post("zhuce.action", {loginname: $("#loginname").val(),pwd: $("#pwd").val()}, function (data) {
                            if (data=="注册成功"){
                                $.showPromptSuccess(data);
                            }else {
                                $.showPromptDanger(data);
                            }
                        },"text");
                    }else {
                        $.showPromptDanger(data);
                    }
                });

            }


        } else {
            $.showPromptDanger("电话号码必须是11位");
        }

    }
    //返回登录界面
    function fanhui() {
        $(location).attr('href', 'login.jsp');
    }
</script>
</body>
</html>
