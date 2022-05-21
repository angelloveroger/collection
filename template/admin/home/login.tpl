<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>后台管理登录</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<link rel="stylesheet" href="/packs/layui/css/layui.css" media="all">
<link rel="stylesheet" href="/packs/admin/css/login.css" media="all">
</head>
<body class="login-bg">
<div class="login layui-anim layui-anim-up">
    <div class="message">后台管理登录</div>
    <div id="darkbannerwrap"></div>
    <form method="post" class="layui-form" style="margin: 15px 0;">
        <input name="name" placeholder="用户名" autocomplete="off" type="text" lay-verify="required" class="layui-input" >
        <hr class="hr15">
        <input name="pass" lay-verify="required" autocomplete="off" placeholder="密码"  type="password" class="layui-input">
        <hr class="hr15">
        <input name="code" lay-verify="required" autocomplete="off" placeholder="认证码"  type="password" class="layui-input">
        <hr class="hr15">
        <input value="登录" lay-submit lay-filter="login" style="width:100%;" type="submit">
    </form>
    <div class="text"><p><a href="http://www.yhcms.cc/" target="_blank">YHCMS开发团队研发</a></p></div>
</div>
<script src="/packs/jquery/jquery.min.js"></script>
<script src="/packs/layui/layui.js"></script>
<script>
layui.use(['form','layer'],function(){
    var form = layui.form,layer = layui.layer;
    //监听提交
    form.on('submit(login)', function(data){
        post = data.field;
        var index = layer.load();
        $.post('<?=links('login/save')?>', post, function(res) {
            layer.close(index);
            if(res.code == 1){
                layer.msg('登录成功，请稍后...',{icon: 1});
                setTimeout(function() {
                    window.location.href = '<?=links('home')?>';
                }, 1000);
            }else{
                layer.msg(res.msg,{icon: 2});
            }
        });
        return false;
    });
});
</script>
</body>
</html>