//banner
if(typeof(banner_json) != "undefined") {
    var posterTvGrid = new posterTvGrid('bannerindex',{className: "posterTvGrid"},banner_json);
}
var pid = 0;
var user = {
    loginHtml: '<div class="login-box layui-form"><h3>用户登录<span class="right"><i class="layui-close layui-icon layui-icon-close"></i></span></h3><p><input type="tel" name="tel" placeholder="请输入手机号码" autocomplete="off" lay-verify="required|phone" autocomplete="off" class="layui-input"></p><p><input type="password" name="pass" placeholder="请输入登录密码" autocomplete="off" lay-verify="required" autocomplete="off" class="layui-input"></p><button lay-submit lay-filter="login-box" class="btn">立即登录</button><div class="tps"><span class="reg-btn">免费注册</span><span class="pass-btn right">忘记密码</span></div></div>',
    regHtml: '<div class="login-box layui-form reg-box"><h3>注册<span class="right">已有账号？<em class="login-btn">立即登录</em><i class="layui-close layui-icon layui-icon-close"></i></span></h3><p><input type="text" id="tel" name="tel" placeholder="请输入手机号码" autocomplete="off" lay-verify="required|phone" autocomplete="off" class="layui-input"></p>'+(_regcode_ == 1?'<p><input type="text" name="tcode" placeholder="请输入手机验证" autocomplete="off" lay-verify="required" autocomplete="off" class="layui-input"><span data-type="reg" class="telcode-btn">获取验证码</span></p>':'')+'<p><input type="password" name="pass" placeholder="请输入密码" autocomplete="off" lay-verify="required" autocomplete="off" class="layui-input"></p><button lay-submit lay-filter="reg-box" class="btn">立即注册</button><div class="tps"><span class="on"><i class="layui-icon layui-icon-radio"></i>已阅读并同意《<a href="/opt/index/agreement" target="_blank">用户协议服务条款</a>》</span></div></div>',
    passHtml: '<div class="login-box layui-form"><h3>找回密码<span class="right">没有账号？<em class="reg-btn">立即注册</em><i class="layui-close layui-icon layui-icon-close"></i></span></h3><p><input type="text" id="tel" name="tel" placeholder="请输入手机号码" autocomplete="off" lay-verify="required|phone" autocomplete="off" class="layui-input"></p><p><input type="text" name="code" placeholder="请输入手机验证" autocomplete="off" lay-verify="required" autocomplete="off" class="layui-input"><span data-type="pass" class="telcode-btn">获取验证码</span></p><p><input type="password" name="pass" placeholder="请输入新密码" autocomplete="off" lay-verify="required" autocomplete="off" class="layui-input"></p><button lay-submit lay-filter="pass-box" class="btn">立即修改</button></div>',
    tindex: null,
    pindex: null,
    codetype: 'reg',
    time: 60,
    codecid: 0,
    ckey: '',
    codexy: [],
    tkey: '',
    regpost: {},
    paytype: 'vip',
    init: function(){
        if(!getcookie('user_token')){
            if(window.location.href.indexOf('/user/reg') > -1){
                user.reg();
            }else if(window.location.href.indexOf('/user/pass') > -1){
                user.pass();
            }else if(window.location.href.indexOf('/user') > -1){
                user.login();
            }
        }
        $('body').on('click','.login-box .reg-btn',function(){
            user.reg();
        });
        $('body').on('click','.login-box .pass-btn',function(){
            user.pass();
        });
        $('body').on('click','.login-box .login-btn',function(){
            user.login();
        });
        $('body').on('click','.login-box .tps span',function(){
            if($(this).hasClass('on')){
                $(this).removeClass('on');
            }else{
                $(this).addClass('on');
            }
        });
        $('body').on('click','.telcode-btn',function(){
            var tel = $('#tel').val();
            user.codetype = $(this).data('type');
            if(tel == '' && user.codetype != 'tel'){
                layer.msg('请填写正确的手机号码',{shift:6});
            }else{
                user.piccode(1);
            }
        });
        $('body').on('click','.code-img',function(e) {  
            var x = e.pageX-$(this).offset().left;
            var y = e.pageY-$(this).offset().top;
            if(user.codecid < 2){
                user.codecid++;
                user.codexy.push({x:x,y:y});
                var html = '<span class="points-item" style="left:'+x+'px;top:'+y+'px">'+user.codecid+'</span>';
                $(this).append(html);
            }
        });
        $('body').on('click','.js_refresh',function(){
            user.piccode(2);
        });
        $('body').on('click','.smspic-btn',function(){
            var tel = $('#tel').val();
            if(user.codecid < 2){
                layer.msg('请在图片上点击正确的文字',{shift:6});
            }else{
                if(_regcode_ == 0 && $('.reg-box').length > 0){
                    user.regsave();
                }else{
                    user.code(tel);
                }
            }
        });
        $('.user-data-box .data-more').click(function(){
            $(this).remove();
            $('.user-data-box ul li,.user-data-box ul h3').removeClass('none');
        });
        $('.user-data-box .js-data h3 .right').click(function(){
            if($(this).text() == '编辑'){
                $(this).text('取消编辑');
                $('.user-data-box ul li .xuan,.user-xuan-cmd').removeClass('none');
            }else{
                $(this).text('编辑');
                $('.user-data-box ul li .xuan,.user-xuan-cmd').addClass('none');
            }
        });
        $('.user-data-box ul li .xuan').click(function(){
            if($(this).hasClass('on')){
                $(this).removeClass('on');
                $(this).children('i').addClass('layui-icon-circle').removeClass('layui-icon-radio');
            }else{
                $(this).addClass('on');
                $(this).children('i').removeClass('layui-icon-circle').addClass('layui-icon-radio');
            }
        });
        $('.user-xuan-cmd span').click(function(){
            var type = $(this).data('type');
            var table = $(this).data('table');
            var op = $(this).data('op');
            if(type == 'xuan'){
                if($('.user-data-box ul li .xuan.on').length > 0){
                    $('.user-data-box ul li .xuan').removeClass('on');
                    $('.user-data-box ul li .xuan i').addClass('layui-icon-circle').removeClass('layui-icon-radio');
                }else{
                    $('.user-data-box ul li .xuan').addClass('on');
                    $('.user-data-box ul li .xuan i').removeClass('layui-icon-circle').addClass('layui-icon-radio');
                }
            }else{
                var ids = [];
                $('.user-data-box ul li .xuan').each(function(index){
                    if($(this).hasClass('on')) ids.push($(this).data('vid'));
                });
                if(ids.length == 0){
                    layer.msg('请选择要删除的数据',{shift:6});
                }else{
                    layer.confirm('无法恢复，确定吗', {
                        title:'删除提示',
                        btn: ['确定', '取消'], //按钮
                        shade:0.001
                    }, function(index) {
                        var tindex = layer.load();
                        $.post('/index.php/ajax/del'+op,{ids:ids.join(','),type:table}, function(res) {
                            layer.close(tindex);
                            if(res.code == 1){
                                layer.msg(res.msg);
                                setTimeout(function(){
                                    window.location.reload();
                                },1000);
                            }else{
                                layer.msg(res.msg,{shift:6});
                            }
                        },'json');
                    }, function(index) {
                        layer.close(index);
                    });
                }
            }
        });
        $('.user-edit-btn span').click(function(){
            var type = $(this).data('type');
            if(type == 'tel'){
                user.teledit();
            }else{
                user.passedit();
            }
        });
        $('body').on('click','.layui-close',function(){
            layer.close(user.tindex);
        });
    },
    login: function(){
        if(user.tindex) layer.close(user.tindex);
        user.tindex = layer.open({
            type: 1,
            title: false,
            closeBtn: 0,
            area: ['350px', 'auto'],
            content: user.loginHtml
        });
    },
    reg: function(){
        if(user.tindex) layer.close(user.tindex);
        user.tindex = layer.open({
            type: 1,
            title: false,
            closeBtn: 0,
            area: ['350px', 'auto'],
            content: user.regHtml
        });
    },
    pass: function(){
        if(user.tindex) layer.close(user.tindex);
        user.tindex = layer.open({
            type: 1,
            title: false,
            closeBtn: 0,
            area: ['350px', 'auto'],
            content: user.passHtml
        });
    },
    piccode: function(n){
        var index = layer.load();
        $.get('/index.php/ajax/piccode',function(res){
            layer.close(index);
            if(res.code == 1){
                user.codexy = [];
                user.codecid = 0;
                user.ckey = res.data.ckey;
                if(n == 1){
                    var html = '<div class="sms-code-box"><div class="code-img"><img class="js_smsImg" alt="获取图片验证码失败，刷新重新获取" src="'+res.data.img+'"><div class="refresh js_refresh"><i class="layui-icon">&#xe669;</i></div></div><div class="code-text"><div class="sms-msg">请在上图中点击正确的示例文字：</div><div class="sms-text js_smsText">'+res.data.font+'</div></div><div class="smspic-btn">确认</div></div>';
                    user.pindex = layer.open({type:1,title:false,area:['290px','260px'],content: html});
                }else{
                    $('.code-img span').remove();
                    $('.js_smsImg').attr('src',res.data.img);
                    $('.js_smsText').html(res.data.font);
                }
            }else{
                layer.msg(res.msg,{shift:6});
            }
        },'json');
    },
    code: function(tel){
        var index = layer.load();
        $.post('/index.php/ajax/telcode/'+user.codetype,{tel:tel,ckey:user.ckey,code:JSON.stringify(user.codexy)},function(res){
            layer.close(index);
            if(res.code == 1){
                layer.close(user.pindex);
                layer.msg(res.msg);
                user.codetime();
            }else{
                user.piccode(2);
                layer.msg(res.msg,{shift:6});
            }
        },'json');
    },
    codetime: function(){
        user.time--;
        if(user.time < 1){
            user.time = 60;
            $('.telcode-btn').html('获取验证码');
        }else{
            $('.telcode-btn').html(user.time+'s');
            setTimeout(function(){
                user.codetime();
            },1000);
        }
    },
    pay: function(type){
        user.paytype = type;
        $.post('/index.php/ajax/viplist',{t:1},function(res){
            if(res.code == -1){
                user.login();
            }else if(res.code == 1){
                var payHtml = '<div class="user-pay-box"><h3>在线充值<span class="layui-close"><i class="layui-icon layui-icon-close"></i></span></h3><div class="pay-box"><div class="pay-box-row"><p>开通账号：'+$('.js-unichen').html()+'</p><div class="tab"><span data-type="vip" class="vip'+(type=='vip'?' on':'')+'">购买VIP</span><span data-type="cion" class="cion'+(type=='cion'?' on':'')+'">充值金币</span><span data-type="card" class="card'+(type=='card'?' on':'')+'">点卡兑换</span></div><ul class="pay-vip-box" style="display:block;">';
                for (var i = 0; i < res.data.list.length; i++) {
                    var cls = i == 0 ? ' class="on"' : '';
                    payHtml += '<li'+cls+' data-day="'+res.data.list[i].day+'"><div class="rmb"><b>'+res.data.list[i].rmb+'</b>元</div><div class="txt">'+res.data.list[i].name+'</div></li>';
                }
                payHtml += '</ul><ul class="pay-cion-box">';
                for (var i = 0; i < res.data.cionlist.length; i++) {
                    var cls2 = i == 0 ? ' class="on"' : '';
                    payHtml += '<li'+cls2+' data-cion="'+res.data.cionlist[i].cion+'"><div class="rmb"><b>'+res.data.cionlist[i].rmb+'</b>元</div><div class="txt">'+res.data.cionlist[i].cion+'金币</div></li>';
                }
                payHtml += '<input style="display:none;" type="text" id="pay-cion-val" value="100" class="layui-input" placeholder="请输入购买金币数量"></ul><ul class="pay-card-box"><p>点卡卡密：<input type="text" id="pay-card-val" value="" class="layui-input" placeholder="请输入点卡卡密"></p></ul></div><div id="card-btn-box"><div class="card-btn">立即提交</div></div></div><div id="pay-btn-box" class="pay-type"><p>付款方式：</p><div class="pay-type-row"><span data-pay="alipay">支付宝</span><span data-pay="wxpay">微信支付</span></div></div><div class="pay-qrcode"><p>支付宝扫码支付</p><div class="qrcode"><img src=""></div></div></div>';
                user.tindex = layer.open({
                    type: 1,
                    title: false,
                    closeBtn: 0,
                    area: ['480px', 'auto'],
                    content: payHtml,
                    success: function(layero, index){
                        $('.user-pay-box .pay-box .pay-box-row ul').hide();
                        $('.pay-'+user.paytype+'-box').show();
                        if(user.paytype == 'card'){
                            $('#pay-btn-box').hide();
                            $('#card-btn-box').show();
                        }else{
                            $('#pay-btn-box').show();
                            $('#card-btn-box').hide();
                        }
                    }
                });
                $('body').on('click','.pay-box-row .tab span',function(){
                    $('.pay-box-row .tab span').removeClass('on');
                    $(this).addClass('on');
                    user.paytype = $(this).data('type');
                    $('.user-pay-box .pay-box .pay-box-row ul').hide();
                    $('.pay-'+user.paytype+'-box').show();
                    $('.pay-box-row li,.pay-type-row span').removeClass('on');
                    $('.pay-qrcode').hide();
                    if(user.paytype == 'card'){
                        $('#pay-btn-box').hide();
                        $('#card-btn-box').show();
                    }else{
                        $('#pay-btn-box').show();
                        $('#card-btn-box').hide();
                    }
                });
                //选择vip套餐
                $('body').on('click','.pay-vip-box li',function(){
                    $('.pay-vip-box li').removeClass('on');
                    $(this).addClass('on');
                    if($('.pay-type-row span.on').length > 0){
                        var day = $(this).data('day');
                        var pay = $('.pay-type-row span.on').data('pay');
                        user.get_pay_send(day,user.paytype,pay,$('.pay-type-row span.on'));
                    }
                });
                //选择金币套餐
                $('body').on('click','.pay-cion-box li',function(){
                    $('.pay-cion-box li').removeClass('on');
                    $(this).addClass('on');
                    var cion = $(this).data('cion');
                    $('#pay-cion-val').val(cion);
                    console.log(cion);
                    if($('.pay-type-row span.on').length > 0){
                        var pay = $('.pay-type-row span.on').data('pay');
                        user.get_pay_send(0,user.paytype,pay,$('.pay-type-row span.on'));
                    }
                });
                //选择支付方式
                $('body').on('click','.pay-type-row span',function(){
                    if(user.paytype == 'vip'){
                        var day = $('.pay-vip-box li.on').data('day');
                        user.get_pay_send(day,user.paytype,$(this).data('pay'),$(this));
                    }else{
                        user.get_pay_send(0,user.paytype,$(this).data('pay'),$(this));
                    }
                });
                //兑换点卡
                $('body').on('click','.card-btn',function(){
                    user.get_pay_send(0,user.paytype,'card',null);
                });
            }else{
                layer.msg(res.msg,{shift:6});
            }
        });
    },
    get_pay_send: function(day,type,pay,_this){
        var index = layer.load();
        var cion = $('#pay-cion-val').val();
        var card = $('#pay-card-val').val();
        $.post('/index.php/ajax/pay',{day:day,type:type,paytype:pay,cion:cion,card:card},function(res){
            layer.close(index);
            if(res.code == 1){
                if(user.paytype == 'card'){
                    get_userinfo();
                    layer.msg(res.msg);
                    layer.close(user.tindex);
                }else{
                    if(pay == 'wxpay'){
                        $('.pay-qrcode p').html('微信扫码支付');
                    }else{
                        $('.pay-qrcode p').html('支付宝扫码支付');
                    }
                    $('.pay-type-row span').removeClass('on');
                    _this.addClass('on');
                    $('.pay-type').css('padding-bottom','0px');
                    $('.pay-qrcode img').attr('src',res.data.img);
                    $('.pay-qrcode').show();
                    layer.style(user.tindex, {
                        height: '633px',
                        top: '50%',
                        marginTop: '-316px'
                    });
                }
            }else{
                layer.msg(res.msg,{shift:6});
            }
        },'json');
    },
    teledit: function(){
        var tel = $('#ytel').val();
        var html = '<div class="user-edit-box layui-form"><h3>修改手机<span class="layui-close"><i class="layui-icon layui-icon-close"></i></span></h3><p id="tel-tps">使用手机 '+tel+' 进行验证</p><p id="tel-box" style="display:none;"><input type="text" id="tel" name="tel" placeholder="请输入新手机号码" autocomplete="off" class="layui-input"></p><p><input type="text" id="telcode" name="code" placeholder="请输入手机验证" autocomplete="off" lay-verify="required" autocomplete="off" class="layui-input"><span data-type="tel" class="telcode-btn">获取验证码</span></p><div lay-submit lay-filter="edit-tel-box" class="btn">下一步</div></div>';
        user.tindex = layer.open({
            type: 1,
            title: false,
            closeBtn: 0,
            area: ['480px','310px'],
            content: html
        });
    },
    passedit: function(){
        var tel = $('#ytel').val();
        var html = '<div class="user-edit-box layui-form"><h3>修改密码<span class="layui-close"><i class="layui-icon layui-icon-close"></i></span></h3><p><input lay-verify="required" type="password" name="pass" placeholder="请输入原密码" autocomplete="off" class="layui-input"></p><p><input lay-verify="required" type="password" name="pass1" placeholder="请输入新密码" autocomplete="off" class="layui-input"></p><p><input lay-verify="required" type="password" name="pass2" placeholder="请确认新密码" autocomplete="off" class="layui-input"></p><div lay-submit lay-filter="edit-pass-box" class="btn">立即修改</div></div>';
        user.tindex = layer.open({
            type: 1,
            title: false,
            closeBtn: 0,
            area: ['480px','auto'],
            content: html
        });
    },
    regsave: function(){
        var index = layer.load();
        user.regpost.ckey = user.ckey;
        user.regpost.code = JSON.stringify(user.codexy);
        $.post('/index.php/ajax/reg',user.regpost,function(res){
            layer.close(index);
            if(res.code == 1){
                layer.msg(res.msg);
                layer.close(user.tindex);
                if(_regcode_ == 0) layer.close(user.pindex);
                get_islog();
            }else{
                if(_regcode_ == 0) user.piccode(2);
                layer.msg(res.msg,{shift:6});
            }
        });
    }
};
layui.use(['layer','carousel','laypage','element','form','flow','upload'], function(){
	var carousel = layui.carousel,
    layer = layui.layer,
    laypage = layui.laypage,
    form = layui.form,
    flow = layui.flow,
    upload = layui.upload,
    element = layui.element;
    flow.lazyimg();
    user.init();
    //banner
    carousel.render({
        elem: '#bpics'
        ,width: '100%' //设置容器宽度
        ,height: '223px' //设置容器宽度
        ,arrow: 'none' //始终显示箭头
    });
    form.on('submit(login-box)', function(data){
        var index = layer.load();
        $.post('/index.php/ajax/login',data.field,function(res){
            layer.close(index);
            if(res.code == 1){
                layer.msg(res.msg);
                if(window.location.href.indexOf('/user') > -1){
                    window.location.reload();
                }else{
                    get_islog();
                }
                layer.close(user.tindex);
            }else{
                layer.msg(res.msg,{shift:6});
            }
        });
        return;
    });
    form.on('submit(reg-box)', function(data){
        if(!$('.login-box .tps span').hasClass('on')){
            layer.msg('您需要同意用户服务协议',{shift:6});
            return;
        }
        user.regpost = data.field;
        if(_regcode_ == 0){
            user.piccode(1);
        }else{
            user.regsave();
        }
        return;
    });
    form.on('submit(pass-box)', function(data){
        var index = layer.load();
        $.post('/index.php/ajax/pass',data.field,function(res){
            layer.close(index);
            if(res.code == 1){
                layer.msg(res.msg);
                setTimeout(function(){
                    user.login();
                },1500);
            }else{
                layer.msg(res.msg,{shift:6});
            }
        });
        return;
    });
    form.on('submit(edit-tel-box)', function(data){
        data.field['tkey'] = user.tkey;
        var index = layer.load();
        $.post('/index.php/ajax/teledit',data.field,function(res){
            layer.close(index);
            if(res.code == 1){
                layer.msg(res.msg);
                if(res.data.tkey){
                    user.tkey = res.data.tkey;
                    $('#tel-tps').hide();
                    $('#tel-box').show();
                    if(user.time < 60) user.time = 1;
                    $('#telcode').val('');
                    $('.telcode-btn').data('type','reg');
                }else{
                    setTimeout(function(){
                        window.location.reload();
                    },1000); 
                }
            }else{
                layer.msg(res.msg,{shift:6});
            }
        });
        return false;
    });
    form.on('submit(edit-pass-box)', function(data){
        var index = layer.load();
        $.post('/index.php/ajax/passedit',data.field,function(res){
            layer.close(index);
            if(res.code == 1){
                layer.msg(res.msg);
                layer.close(user.tindex);
            }else{
                layer.msg(res.msg,{shift:6});
            }
        });
        return false;
    });
    form.on('submit(edit-nickname)', function(data){
        var index = layer.load();
        $.post('/index.php/ajax/nicknameedit',data.field,function(res){
            layer.close(index);
            if(res.code == 1){
                layer.msg(res.msg);
            }else{
                layer.msg(res.msg,{shift:6});
            }
        });
        return false;
    });
    upload.render({
        elem: '.uppic',
        url: '/index.php/ajax/uppic',
        accept: 'file',
        acceptMime: 'image/*',
        exts: 'jpg|png|gif|bmp|jpeg',
        done: function(res){
            if(res.code == 1){
                layer.msg(res.msg,{icon: 1});
                $('.uppic img').attr('src',res.data.url);
            }else{
                layer.msg(res.msg,{shift:6});
            }
        }
    });
    $(window).scroll(function(){
        if($(window).scrollTop() >= 60){
            $(".header").addClass('shadow');
        } else{
            $(".header").removeClass('shadow');
        }
    });
    $('body').on('click','.login-btn,.loginbtn',function(){
        user.login();
    });
    $('body').on('click','.js-ulink',function(){
        if(!getcookie('user_token')){
            user.login();
            return false;
        }
    });
	//鼠标悬停显示
    $('.list_hover').children('li').hover(function() {
        $(this).parent().children('li').removeClass('hover');
        $(this).addClass('hover');
    });
    $('.wapcode,.pop').hover(function() {
        $('.pop').show();
    },function() {
        $('.pop').hide();
    });
    $('.app_btn,.pops').hover(function() {
        $('.pops').show();
    },function() {
        $('.pops').hide();
    });
    //历史
    $('.js-read').hover(function() {
        $('.js-read-box').show();
    },function() {
        $('.js-read-box').hide();
    });
    //收藏
    $('.js-cases').hover(function() {
        $('.js-cases-box').show();
    },function() {
        $('.js-cases-box').hide();
    });
    //APP下载
    $('.js-appdown').hover(function() {
        $('.js-appdown-box').show();
    },function() {
        $('.js-appdown-box').hide();
    });
    //用户
    $('.js-user').hover(function() {
        $('.js-uinfo').show();
    },function() {
        $('.js-uinfo').hide();
    });
    $('.js-logout').click(function(){
        $.get('/index.php/ajax/logout',function(res){
            if(res.code == 1){
                window.location.reload();
            }
        });
        return false;
    });
    //判断登录
    if(getcookie('user_token')){
        get_islog();
    }
    //搜索
    $('.search_btn').click(function() {
        var key = $('.search_key').val();
        var _link = $('.search').attr('action');
        if(key == ''){
            layer.msg('请输入搜搜的关键字',{anim:6});
        }else{
            window.location.href = _link+'?key='+key;
        }
    });
    $('.search_key').bind('keyup',function(event){
        if(event.keyCode == 13) {
            $('.search_btn').click();
        }
    });
    //换一换
    var p = 1;
    $('.reco_huan').click(function(){
        p++;
        if(p > 3) p=1;
        $.post('/index.php/index/reco', {p:p}, function(res) {
            if(res.code == 1){
                $('.plist').html(res.html);
            }
        },'json');
    });
    //返回顶部
    var readmore = 0;
    $(window).scroll(function() {
        if ($(window).scrollTop() > 200) {
            $(".return-top").fadeIn(200);
            $('.js-back-top').fadeIn(200);
            $('.opt_nav').addClass('opt_nav_fixed');
        } else {
            $(".return-top").fadeOut(200);
            $('.js-back-top').fadeOut(200);
            $('.opt_nav').removeClass('opt_nav_fixed');
        }
        if($(document).scrollTop() >= $(document).height() - $(window).height()-60) {
            if($('.book_read').length > 0 && $('.book_read').data('pay') == 0 && readmore == 0){
                read.more();
                readmore = 1;
            }
        }
    });
    //当点击跳转链接后，回到页面顶部位置
    $(".return-top,.js-back-top").click(function() {
        $('body,html').animate({scrollTop: 0},500);
        return false;
    });
    //翻转效果
    var $swiper3dCurItem = '', _swiper3dIndex = '', $swiper3dCurTxt = '';
    $('.swiper3d').waterwheelCarousel({
        flankingItems: 2,
        separation: 55,
        sizeMultiplier: .7,
        autoPlay: 3000,
        movedToCenter: function(item){
            $swiper3dCurItem = $(item.context);
            _swiper3dIndex = $swiper3dCurItem.attr('index');
            $swiper3dCurTxt = $swiper3dCurItem.parents('.swiper3d').siblings('.swiper3d_txt');
            $swiper3dCurTxt.css('display','none');
            $swiper3dCurTxt.eq(_swiper3dIndex).css('display','block');
        }
    });
    //左右切换
    $('.more-left').click(function(){
        $(this).parent().children('.more-right').show();
        var _this = $(this).parent().children('ul');
        var _liw = _this.children('li').eq(0).width()+20;
        var width = _this.children('li').length*_liw;
        var marginLeft = Math.abs(parseInt(_this.css('margin-left')))-1200;
        if(marginLeft > -1){
            _this.css('margin-left','-'+marginLeft+'px');
            if(marginLeft-1200 < 0){
                $(this).hide();
            }
        }
    });
    $('.more-right').click(function(){
        $(this).parent().children('.more-left').show();
        var _this = $(this).parent().children('ul');
        var _liw = _this.children('li').eq(0).width()+20;
        var width = _this.children('li').length*_liw;
        var marginLeft = Math.abs(parseInt(_this.css('margin-left')))+1200;
        if(marginLeft < width){
            _this.css('margin-left','-'+marginLeft+'px');
            if(marginLeft+1210 > width){
                $(this).hide();
            }
        }
    });
    //分页
    if($('#pages').length > 0){
        var _link = $('#pages').data('link');
        var limit = $('#pages').data('limit');
        laypage.render({
            elem: 'pages',
            limit: limit != undefined ? limit : 30,
            groups: 10,
            curr: $('#pages').data('page'),
            count: $('#pages').data('count'),
            layout:['count', 'prev', 'page', 'next', 'refresh', 'skip'],
            jump: function(obj, first){
                if(!first){
                    window.location.href = _link.replace('{page}',obj.curr);
                }
            }
        });
    }
    //播放器
    if($('#player-video').length > 0){
        get_play_url();
        var clipboard = new Clipboard('.share-btn');
        clipboard.on('success',function(e) {
            e.clearSelection();
            layer.msg('分享地址复制成功');
        });
        clipboard.on('error',function(e) {
            layer.msg('分享地址复制失败',{shift:6});
        });
        $(function() {
            $('.problem .entry li a').click(function() {
                $(this).parents('li').find('.item').toggle();
            });
        })
        $('.play-zu-btn').click(function(){
            $('.zu-list').toggle();
        });
        $('.zu-list li').click(function(){
            var zid = $(this).data('id');
            $('.zu-list li').removeClass('on');
            $(this).addClass('on');
            $('.zu-vod .scrollbar').hide();
            $('#zu-'+zid).show();
            $('.zu-list').toggle();
        });
        $('.vod-play .vod-box .full-btn').click(function(){
            if($(this).data('full') == 0){
                $('.vod-play .vod-box').css('width','100%');
                $('.vod-play .zu-vod').hide();
                $(this).data('full','1');
                $(this).children('i').removeClass('layui-icon-right').addClass('layui-icon-left');
            }else{
                $('.vod-play .vod-box').css('width','900px');
                $('.vod-play .zu-vod').show();
                $(this).data('full','0');
                $(this).children('i').removeClass('layui-icon-left').addClass('layui-icon-right');
            }
        });
        $('.comment-btn').click(function(){
            var t_a = $(".comment-list").offset().top;
            $("html,body").animate({scrollTop:t_a+"px"},500);
        });
        $('.qrcode-btn').click(function(){
            $(".vod-play .qrcode-img").toggle();
        });
        $('.vod-star-ul li').hover(function(){
            var id = $(this).data('id');
            $('.vod-star-ul li').removeClass('on');
            $(this).addClass('on');
            $('.star-vlist').hide();
            $('#star-li-'+id).show();
        });
    }
    //切换播放组
    $('.zu-box li').click(function(){
        var zid = $(this).data('id');
        $('.zu-box li').removeClass('on');
        $(this).addClass('on');
        $('.ji-box ul').hide();
        $('#zu-'+zid).show();
    });
    //排序
    $('.zu-box .right').click(function(){
        var sort = $(this).data('sort');
        var zid = $('.zu-box li.on').data('id');
        if(sort == 'asc') {
            $(this).data('sort','desc').html('<span><i class="layui-icon">&#xe668;</i></span>倒序');
        } else {
            $(this).data('sort','asc').html('<span><i class="layui-icon">&#xe66b;</i></span>正序');
        }
        $('#zu-'+zid).append($('#zu-'+zid).find('li').get().reverse());
    });
    //收藏视频
    $('.fav-btn').click(function(){
        var vid = $(this).data('id');
        $.post('/index.php/ajax/fav', {vid:vid,type:'vod'}, function(res) {
            layer.msg(res.msg);
            if(res.code == 1){
                if($('.fav-btn').data('fav') == 1){
                    $('.fav-btn').html('<i class="layui-icon layui-icon-heart"></i>收藏').data('fav','0');
                }else{
                    $('.fav-btn').html('<i class="layui-icon layui-icon-heart-fill"></i>已收藏').data('fav','1');
                }
            }else{
                if(res.code == -1) user.login();
            }
        },'json');
    });
    //计算评论字数
    $('.box textarea').keyup(function(){
        var _this = $(this).parent();
        var lenInput = $(this).val().length;
        if(lenInput > 200){
            $(this).val($(this).val().slice(0,200));
            _this.children('.num').children('span').text(200);
        }else{
            _this.children('.num').children('span').text(lenInput);
        }
    });
    //回复评论框显隐
    $('body').on('click','.cmd .one',function(){
        if(!getcookie('user_token')){
            user.login();
            return;
        }
        var nickname = $(this).parent().data('nickname');
        var _this = $(this).parent().parent().find('.box');
        _this.children('textarea').attr('placeholder','回复：'+nickname);
        _this.children('textarea').data('nickname',nickname);
        _this.toggle();
    });
    $('body').on('click','.reply-list .cmd .reply',function(){
        if(!getcookie('user_token')){
            user.login();
            return;
        }
        var nickname = $(this).parent().data('nickname');
        var _this = $(this).parent().parent().parent().parent().parent().parent().find('.box');
        if(_this.css('display') == 'none' || nickname != _this.children('textarea').data('nickname')){
            _this.toggle();
        }
        _this.children('textarea').attr('placeholder','回复：'+nickname);
        _this.children('textarea').data('nickname',nickname);
    });
    //删除评论
    $('body').on('click','.comment-list .del',function(){
        var _this = $(this);
        var _thisparent = $(this).parent().parent();
        layer.confirm('确定要删除吗', {
            title:'删除提示',
            btn: ['确定', '取消'], //按钮
            shade:0.001
        }, function(index) {
            var tindex = layer.load();
            $.post('/index.php/ajax/comment_del', {'id':_this.data('id')}, function(res) {
                layer.close(tindex);
                if(res.code == 1){
                    layer.msg('删除成功...');
                    _this.parent().remove();
                    if(_thisparent.children('li').length == 0){
                        if(_thisparent.hasClass('reply-list')){
                            _thisparent.remove();
                        }else{
                            _thisparent.html('<div class="nodata">暂无评论，快来评论一波吧~!</div>');
                        }
                    }
                }else{
                    layer.msg(res.msg,{shift:6});
                }
            },'json');
        }, function(index) {
            layer.close(index);
        });
    });
    //更多评论
    $('.comment-list .more').click(function(){
        var vid = $(this).data('vid');
        var page = $(this).data('page')+1;
        $(this).data('page',page);
        get_comment(vid,page);
    });
    //更多回复
    $('body').on('click','.comment-list .reply-more',function(){
        var fid = $(this).data('id');
        $(this).remove();
        get_reply(fid,0);
    });
    //发表评论
    $('body').on('click','.comment-list .box .btn',function(){
        var _this = $(this);
        var vid = $(this).parent().children('textarea').data('vid');
        var fid = $(this).parent().children('textarea').data('fid');
        var nickname = $(this).parent().children('textarea').data('nickname');
        var text = $(this).parent().children('textarea').val();
        if(text != ''){
            if(nickname != '') text = '@'+nickname+' '+text;
            var tindex = layer.load();
            $.post('/index.php/ajax/comment_add',{vid:vid,fid:fid,text:text}, function(res) {
                layer.close(tindex);
                if(res.code == 1){
                    _this.parent().children('textarea').val('');
                    if(fid == 0){
                        $('.comment-list .more').data('page','1');
                        get_comment(vid,1);
                    }else{
                        get_reply(fid,3);
                    }
                }else{
                    layer.msg(res.msg,{shift:6});
                }
            },'json');
        }
    });
    $('.comment-list textarea').bind('keyup',function(event){
        if(event.keyCode == 13) {
            $(this).parent().children('.btn').click();
        }
    });
    //评论点赞
    $('body').on('click','.comment-list .cmd .zan',function(){
        if(!getcookie('user_token')){
            user.login();
            return;
        }
        var zan = $(this).parent().data('zan');
        var id = $(this).parent().data('id');
        var num = parseInt($(this).children('font').text());
        var _this = $(this);
        var tindex = layer.load();
        $.post('/index.php/ajax/comment_zan',{id:id}, function(res) {
            layer.close(tindex);
            if(res.code == 1){
                var img = _this.children('img').attr('src');
                if(zan == 0){
                    _this.parent().data('zan','1');
                    _this.children('font').text((num+1));
                    _this.children('img').attr('src',img.replace('zan.png','zan_on.png'));
                }else{
                    _this.parent().data('zan','0');
                    _this.children('font').text((num-1));
                    _this.children('img').attr('src',img.replace('zan_on.png','zan.png'));
                }
            }else{
                layer.msg(res.msg,{shift:6});
            }
        },'json');
    });
    //求片
    $('.forum-btn').click(function(){
        var name = $(this).data('name');
        var tindex = layer.load();
        $.post('/index.php/ajax/forum/search',{name:name}, function(res) {
            layer.close(tindex);
            if(res.code == 1){
                pid = layer.open({
                    type: 1,
                    title: '在线求片',
                    area: '300px',
                    content: res.data.html,
                    success: function(layero, index) {
                        form.render('select');
                        layer.iframeAuto(index);
                    }
                });
            }else{
                layer.msg(res.msg,{shift:6});
            }
        },'json');
    });
    $('body').on('change','#douban',function(){
        var id = $(this).val();
        var tindex = layer.load();
        $.post('/index.php/ajax/forum/info',{id:id}, function(res) {
            layer.close(tindex);
            if(res.code == 1){
                layer.close(pid);
                layer.msg('求片成功，我们会尽快更新');
            }else{
                layer.msg(res.msg,{shift:6});
            }
        },'json');
    });
    //登录状态
    function get_islog(){
        if($('#player-video').length > 0 && $('#video-hls-box').length == 0) get_play_url();
        $('.comment-nolog').hide();
        get_userinfo();
        $.post('/index.php/ajax/my_watch',{t:'1'},function(res){
            if(res.code == 1){
                var html = '';
                for (var i = 0; i < res.data.list.length; i++) {
                    var txt = res.data.list[i].read_chapter_id == 0 ? '观看' : '续看';
                    html+='<div class="li-item"><a href="'+res.data.list[i].url+'"><img class="li-pic" src="'+res.data.list[i].pic+'" alt="'+res.data.list[i].name+'"></a><div class="li-name"><a href="'+res.data.list[i].url+'">'+res.data.list[i].name+'</a></div><div class="li-readat">观看至：'+res.data.list[i].read_chapter_name+'</div><div class="li-update">'+res.data.list[i].news_chapter_name+'</div><a href="'+res.data.list[i].read_url+'" class="li-read"><i class="layui-icon">&#xe630;</i>'+txt+'</a></div>';
                }
                $('.js-read .item-container').html(html);
                if(res.data.list.length > 0){
                    $('.read-empty').hide();
                    $('.js-read-box .check-all').show();
                }else{
                    $('.read-empty').show();
                }
            }
        },'json');
        $.post('/index.php/ajax/my_fav',{t:1},function(res){
            if(res.code == 1){
                var html = '';
                for (var i = 0; i < res.data.list.length; i++) {
                    var txt = res.data.list[i].read_chapter_id == 0 ? '观看' : '续看';
                    html+='<div class="li-item"><a href="'+res.data.list[i].url+'"><img class="li-pic" src="'+res.data.list[i].pic+'" alt="'+res.data.list[i].name+'"></a><div class="li-name"><a href="'+res.data.list[i].url+'">'+res.data.list[i].name+'</a></div><div class="li-readat">观看至：'+res.data.list[i].read_chapter_name+'</div><div class="li-update">'+res.data.list[i].news_chapter_name+'</div><a href="'+res.data.list[i].read_url+'" class="li-read"><i class="layui-icon">&#xe630;</i>'+txt+'</a></div>';
                }
                $('.js-cases .item-container').html(html);
                if(getcookie('user_token') && res.data.list.length == 0) $('.cases-empty').show();
                if(res.data.list.length > 0){
                    $('.js-cases-box .check-all').show();
                }else{
                    $('.case-empty').show();
                }
            }
        },'json');
    }
    //获取播放
    function get_play_url(){
        if(pid == 1) return;
        pid = 1;
        var jid = $('#player-video').data('jid');
        $.post('/index.php/ajax/vodurl',{jid:jid}, function(res) {
            if(res.code == 1){
                var data = res.data;
                player.init({
                    id: 'player-video',
                    type: data.type,
                    url: data.playurl,
                    pay: data.pay,
                    ads: data.ads,
                    nexturl: data.nexturl,
                    voddata: {name:data.vname,xid:data.xid,vid:data.vid,zid:data.zid,jid:data.id},
                    callback: function(res,playercallback){
                        if(res.code == 'time'){
                            $.post('/index.php/ajax/watch',{jid:jid,time:res.time});
                        }else if(res.code == 'ads'){
                            // 登录
                            if(data.uvip == -1){
                                user.login();
                            }else{
                                user.pay('vip');
                            }
                        }else if(res.code == 'pay'){
                            // 登录
                            if(data.pay.init == 1){
                                user.login();
                            }else if(data.pay.init == 2){
                                user.pay('vip');
                            }else if(data.pay.init == 5){
                                window.location.href = '/appdown';
                            }else if(data.pay.init == 3){
                                layer.confirm('消耗'+data.pay.cion+'金币，确定吗', {
                                    title:'购买提示',
                                    btn: ['确定', '取消'], //按钮
                                    shade:0.001
                                }, function(index) {
                                    var tindex = layer.load();
                                    $.post('/index.php/ajax/buy',{jid:jid}, function(res) {
                                        layer.close(tindex);
                                        if(res.code == 1){
                                            window.location.reload();
                                        }else{
                                            layer.msg(res.msg,{shift:6});
                                        }
                                    },'json');
                                }, function(index) {
                                    layer.close(index);
                                });
                            }else{
                                user.pay('cion');
                            }
                        }else if(res.code == 'barrage'){
                            $.post("/index.php/ajax/barrage_send", res.post,function(res) {
                                if (res.code == 1) {
                                    layer.msg(res.msg);
                                    if(playercallback) playercallback('ok');
                                } else if (res.code == -1) {
                                    if(playercallback) playercallback('login');
                                    user.login();
                                } else {
                                    layer.msg(res.msg, {shift: 6});
                                }
                            },"json");
                        }
                    }
                });
            }else{
                layer.msg(res.msg);
            }
        },'json');
    }
    //评论列表
    function get_comment(vid,page){
        var tindex = layer.load();
        $.post('/index.php/ajax/comment',{vid:vid,page:page,size:15}, function(res) {
            layer.close(tindex);
            if(res.code == 2){
                layer.msg(res.msg);
                $('.comment-list .more').remove();
            }else if(res.code == 1){
                if(page == 1){
                    $('#comment-list').html(res.data.html);
                }else{
                    $('#comment-list').append(res.data.html);
                }
            }else{
                layer.msg(res.msg,{shift:6});
            }
        },'json');
    }
    //评论回复列表
    function get_reply(fid,size){
        var tindex = layer.load();
        $.post('/index.php/ajax/comment_reply',{fid:fid,size:size}, function(res) {
            layer.close(tindex);
            if(res.code == 1){
                if(size == 3){
                    $('#reply-list-'+fid).html(res.data.html);
                }else{
                    $('#reply-list-'+fid).append(res.data.html);
                }
            }else{
                layer.msg(res.msg,{shift:6});
            }
        },'json');
    }
});
function get_userinfo(){
    $.get('/index.php/ajax/user',function(res){
        if(res.code == 1){
            $('.js-ulink').attr('href',res.data.ulink);
            $('.login-notice,.nologin,.login-btn').hide();
            $('.js-logout').show(); 
            $('.js-upic').attr('src',res.data.pic);
            $('.js-unichen').html(res.data.name+'<span class="cion">金币:<b>'+res.data.cion+'</b>个</span>');
            $('.js-uviptime').html('会员到期时间：'+res.data.viptime);
            if(res.data.vip == 1){
                $('.js-ubuyvip').hide();
                $('.js-uaginvip').show();
            }else{
                $('.js-ubuyvip').show();
                $('.js-uaginvip').hide();
            }
        }
    },'json');
}
//写入缓存
function setcookie(name,value,day){
    var Days = (day == null || day == '') ? 30 : day;
    var exp = new Date(); 
    exp.setTime(exp.getTime() + Days*24*60*60*1000); 
    document.cookie = name + "="+ escape (value) + ";path=/;expires=" + exp.toGMTString(); 
}
//读取缓存
function getcookie(name){
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
    if(arr=document.cookie.match(reg)){
        return unescape(arr[2]);
    }else{
        return null;
    }
}