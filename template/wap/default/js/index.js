var isloading = false;
var page = 1;
var end = 0;
var jiheight = 0;
layui.use(['layer','carousel','laypage','element','form','flow','upload'], function(){
	var carousel = layui.carousel,
    layer = layui.layer,
    laypage = layui.laypage,
    form = layui.form,
    flow = layui.flow,
    upload = layui.upload,
    element = layui.element;
    flow.lazyimg();
    var user = {
	    tindex: null,
	    pindex: null,
	    codetype: 'reg',
	    time: 60,
	    codecid: 0,
	    ckey: '',
	    codexy: [],
	    tkey: '',
	    init: function(){
	        $('body').on('click','.reg-btn',function(){
	        	if(_regcode_ == 0){
	            	user.piccode(1);
	        	}else{
	            	user.reg();
	        	}
	        });
	        $('body').on('click','.pass-btn',function(){
	            user.pass();
	        });
	        $('body').on('click','.login-btn',function(){
	            user.login();
	        });
	        $('body').on('click','.telcode-btn',function(){
	            var tel = $('#tel').val();
	            user.codetype = $(this).data('type');
	            if(tel == '' && user.codetype != 'tel'){
	                layer.msg('请填写正确的手机号码',{shift:6});
	            }else{
	                if($(this).val()=='获取验证码') user.piccode(1);
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
	        $('body').on('click','#smspic-btn',function(){
	            var tel = $('#tel').val();
	            if(user.codecid < 2){
	                layer.msg('请在图片上点击正确的文字',{shift:6});
	            }else{
	            	if(_regcode_ == 0 && $('.reg-btn').length > 0){
	            		user.reg();
	                }else{
	                	user.code(tel);
	                }
	            }
	        });
	        $('body').on('click','.editdata-head',function(){
	        	var sex = $(this).data('sex');
	        	var index = layer.load();
	    		$.post('/index.php/ajax/sexedit',{sex:sex},function(res){
	    			layer.close(index);
	    			if(res.code == 1){
	    				layer.msg('设置成功');
	    				if(sex == 1){
	    					$('.sex-text').html('男');
	    				}else{
	    					$('.sex-text').html('女');
	    				}
	    				$(".comment-popup").hide();
	    			}else{
	    				layer.msg(res.msg,{shift:6});
	    			}
	    		},'json');
	        });
	        $('body').on('click','.nickname-btn',function(){
	        	var nickname = $('#nickname').val();
	        	if(nickname == ''){
	        		layer.msg('请填写昵称',{shift:6});
	        	}else{
		        	var index = layer.load();
		    		$.post('/index.php/ajax/nicknameedit',{nickname:nickname},function(res){
		    			layer.close(index);
		    			if(res.code == 1){
		    				layer.msg('设置成功');
		    			}else{
		    				layer.msg(res.msg,{shift:6});
		    			}
		    		},'json');
		    	}
	        });
	        $('body').on('click','.teledit-btn',function(){
	        	var sid = $(this).data('sid');
	        	var tel = $('#tel').val();
	        	var code = $('#code').val();
	        	if(sid == 1){
	        		if(tel == ''){
	        			layer.msg('请填写正确的新手机号',{shift:6});
	        		}else if(code == ''){
	        			layer.msg('请填写手机验证码',{shift:6});
	        		}else{
			        	var index = layer.load();
			    		$.post('/index.php/ajax/teledit',{code:code,tel:tel,tkey:user.tkey},function(res){
			    			layer.close(index);
			    			if(res.code == 1){
			    				layer.msg('修改成功');
			    				setTimeout(function(){
					                returns();
					            },1000);
			    			}else{
			    				layer.msg(res.msg,{shift:6});
			    			}
			    		},'json');
	        		}
	        	}else{
		        	var index = layer.load();
		    		$.post('/index.php/ajax/teledit',{code:code},function(res){
		    			layer.close(index);
		    			if(res.code == 1){
		    				user.time = 1;
		    				user.tkey = res.data.tkey;
		    				$('.telcode-btn').data('type','reg');
		    				$('.teledit-btn').data('sid','1');
		    				$('.signin-phonetitle').hide();
		    				$('.up-list').show();
		    				$('#code').val('');
		    			}else{
		    				layer.msg(res.msg,{shift:6});
		    			}
		    		},'json');
		    	}
	        });
	        $('.pawsub').click(function(){
	        	var pass1 = $('#pass1').val();
	        	var pass2 = $('#pass2').val();
	        	var pass3 = $('#pass3').val();
	        	if(pass1 == ''){
	        		layer.msg('请填写原密码',{shift:6});
	        	}else if(pass2 == ''){
	        		layer.msg('请填写新密码',{shift:6});
	        	}else if(pass3 != pass2){
	        		layer.msg('两次密码不一致',{shift:6});
	        	}else{
		        	var index = layer.load();
	        		$.post('/index.php/ajax/passedit',{pass:pass1,pass1:pass2,pass2:pass3},function(res){
		    			layer.close(index);
		    			if(res.code == 1){
		    				layer.msg('修改成功');
		    				setTimeout(function(){
				                returns();
				            },1000);
		    			}else{
		    				layer.msg(res.msg,{shift:6});
		    			}
		    		},'json');
	        	}
	        });
	        $('.exchange-btn').click(function(){
	        	var day = $(this).data('day');
	        	var cion = $(this).data('cion');
	        	layer.confirm('需要消耗'+cion+'金币，确定兑换吗？', {
		            title: false,
		            closeBtn : 0,
		            btn: ['确定', '取消'], //按钮
		            shade:0.001
		        }, function(index) {
		            layer.close(index);
		            var tindex = layer.load();
		            $.post('/index.php/user/exchange/send',{day:day},function(res){
		                layer.close(tindex);
		                if(res.code == 1){
		                	layer.msg('兑换成功');
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
	        });
		    upload.render({
		        elem: '.uppic',
		        url: '/index.php/ajax/uppic',
		        accept: 'file',
		        acceptMime: 'image/*',
		        exts: 'jpg|png|gif|bmp|jpeg',
		        before: function(obj){
		            layer.load();
		        },
		        done: function(res){
		        	layer.closeAll('loading');
		            if(res.code == 1){
		                layer.msg(res.msg);
		                $('.uplogo').attr('src',res.data.url);
		            }else{
		                layer.msg(res.msg,{shift:6});
		            }
		        }
		    });
		    upload.render({
		        elem: '.feedback-file',
		        url: '/index.php/user/feedback/uppic',
		        accept: 'file',
		        acceptMime: 'image/*',
		        exts: 'jpg|png|gif|bmp|jpeg',
		        before: function(obj){
		            layer.load();
		        },
		        done: function(res){
		        	layer.closeAll('loading');
		            if(res.code == 1){
		        		pics.push(res.data.pic_path);
		        		if(pics.length > 2) $('.feedback-file').hide();
		                $('.image-cent').prepend('<div><img src="'+res.data.pic_path+'"></div>');
		            }else{
		                layer.msg(res.msg,{shift:6});
		            }
		        }
		    });
	    },
	    login: function(){
	    	var tel = $('#tel').val();
	    	var pass = $('#pass').val();
	    	if(tel == ''){
	    		layer.msg('请输入手机号码',{shift:6});
	    	}else if(pass == ''){
	    		layer.msg('请输入登录密码',{shift:6});
	    	}else if(!$('#check').is(':checked')){
	    		layer.msg('请同意用户协议',{shift:6});
	    	}else{
	    		var index = layer.load();
	    		$.post('/index.php/ajax/login',{tel:tel,pass:pass},function(res){
	    			layer.close(index);
	    			if(res.code == 1){
	    				window.location.href = '/index.php/user';
	    			}else{
	    				layer.msg(res.msg,{shift:6});
	    			}
	    		},'json');
	    	}
	    },
	    reg: function(){
	    	var tel = $('#tel').val();
	    	var pass = $('#pass').val();
	    	var code = $('#code').val();
	    	if(tel == ''){
	    		layer.msg('请输入手机号码',{shift:6});
	    	}else if(code == ''){
	    		layer.msg('请输入验证码',{shift:6});
	    	}else if(pass == ''){
	    		layer.msg('请输入登录密码',{shift:6});
	    	}else if(!$('#check').is(':checked')){
	    		layer.msg('请同意用户协议',{shift:6});
	    	}else{
	    		var index = layer.load();
	    		$.post('/index.php/ajax/reg',{tel:tel,tcode:code,pass:pass,ckey:user.ckey,code:JSON.stringify(user.codexy)},function(res){
	    			layer.close(index);
	    			if(res.code == 1){
	    				window.location.href = '/index.php/user';
	    			}else{
	    				if(_regcode_ == 0) user.piccode(2);
	    				layer.msg(res.msg,{shift:6});
	    			}
	    		},'json');
	    	}
	    },
	    pass: function(){
	    	var tel = $('#tel').val();
	    	var pass = $('#pass').val();
	    	var code = $('#code').val();
	    	if(tel == ''){
	    		layer.msg('请输入手机号码',{shift:6});
	    	}else if(code == ''){
	    		layer.msg('请输入验证码',{shift:6});
	    	}else if(pass == ''){
	    		layer.msg('请输入新密码',{shift:6});
	    	}else{
	    		var index = layer.load();
	    		$.post('/index.php/ajax/pass',{tel:tel,code:code,pass:pass},function(res){
	    			layer.close(index);
	    			if(res.code == 1){
	    				window.location.href = '/index.php/user/login';
	    			}else{
	    				layer.msg(res.msg,{shift:6});
	    			}
	    		},'json');
	    	}
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
	                    var html = '<div class="sms-code-box"><div class="code-img"><img class="js_smsImg" alt="获取图片验证码失败，刷新重新获取" src="'+res.data.img+'"><div class="refresh js_refresh"><i class="layui-icon">&#xe669;</i></div></div><div class="code-text"><div class="sms-msg">请在上图中点击正确的示例文字：</div><div class="sms-text js_smsText">'+res.data.font+'</div></div><div class="smspic-btn" id="smspic-btn">确认</div></div>';
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
	            $('.telcode-btn').val('获取验证码');
	        }else{
	            $('.telcode-btn').val(user.time+'s');
	            setTimeout(function(){
	                user.codetime();
	            },1000);
	        }
	    }
	};
	user.init();
    //上拉加载更多
    if($('#page-more').length > 0){
		$(window).bind("scroll", function () {
		    if($(document).scrollTop() + $(window).height() 
		          > $(document).height() - 10 && !isloading) {
		        isloading = true;
		    	var post = $('#page-more').data('json');
		        get_data(post);
		    }
		});
    }
    //上拉加载更多
    if($('#star-page-more').length > 0){
		$(window).bind("scroll", function () {
		    if($(document).scrollTop() + $(window).height() 
		          > $(document).height() - 10 && !isloading) {
		        isloading = true;
		    	var post = $('#star-page-more').data('json');
		        get_star_data(post);
		    }
		});
    }
    if($('.ranking-nav').length > 0){
    	var post = {cid:0,sort:'rhits'};
    	$('.ranking-nav p').click(function(){
    		$('.ranking-nav p').removeClass('active');
    		$(this).addClass('active');
    		post.sort = $(this).data('sort');
    		get_hot_data(post,flow);
    	});
    	$('.rankingul-nav a').click(function(){
    		$('.rankingul-nav a').removeClass('rankingul-navactive');
    		$(this).addClass('rankingul-navactive');
    		post.cid = $(this).data('id');
    		get_hot_data(post,flow);
    	});
    }
    //返回顶部
    var readmore = 0;
    $(window).scroll(function() {
        if ($(window).scrollTop() > 200) {
            $(".return-top").fadeIn(200);
        } else {
            $(".return-top").fadeOut(200);
        }
    });
    //当点击跳转链接后，回到页面顶部位置
    $(".return-top").click(function() {
        $('body,html').animate({scrollTop: 0},500);
        return false;
    });
    //收藏
    $('.fav-btn').click(function(){
    	var _this = $(this);
    	var id = $(this).data('id');
    	var type = $(this).data('type');
    	var fav = $(this).data('fav');
    	get_is_log();
    	var index = layer.load();
    	$.post('/index.php/ajax/fav',{vid:id,type:type},function(res){
    		layer.close(index);
    		if(res.code == 1){
    			layer.msg(res.msg);
    			if(type == 'topic'){
	    			if(fav == 0){
	    				_this.data('fav','1');
	    				_this.html('<span>已收藏</span>');
	    			}else{
	    				_this.data('fav','0');
	    				_this.html('<img src="'+_tpldir_+'images/sc-add.png"><span>收藏</span>');
	    			}
	    		}else{
	    			if($('#player-video').length > 0){
	    				if(fav == 0){
		    				_this.data('fav','1').addClass('on').html('<i class="layui-icon layui-icon-heart-fill"></i>已收藏');
		    			}else{
		    				_this.data('fav','0').removeClass('on').html('<i class="layui-icon layui-icon-heart"></i>收藏');
		    			}
		    		}else{
						if(fav == 0){
		    				_this.data('fav','1');
		    				_this.children('img').attr('src',_tpldir_+'images/ranking-sck.png');
		    			}else{
		    				_this.data('fav','0');
		    				_this.children('img').attr('src',_tpldir_+'images/ranking-sc.png');
		    			}
	    			}
	    		}
    		}else{
    			layer.msg(res.msg,{shift:6});
    		}
    	},'json');
    	return false;
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
    if($('#player-video').length > 0){
    	if($('#play-ji-box ul').length < 2 && $('#play-ji-box ul li').length < 2){
    		$('#play-ji-box').hide();
    	}
    	get_vod_play();
    	$('.play-nav span').click(function(){
    		var type = $(this).data('type');
    		if(type == 'vod'){
    			$('.play-info').show();
    			$('.comment-list').hide();
    			$('#play-zu-box').hide();
    		}else if(type == 'zu'){
    			$('.play-info').show();
    			$('.comment-list').hide();
    			$('#play-zu-box').show();
    		}else{
    			$('.play-info').hide();
    			$('.comment-list').show();
    			$('#play-zu-box').hide();
    		}
    		$('.play-nav span').removeClass('on');
    		$(this).addClass('on');
    	});
    	$('.comment-show-btn').click(function(){
    		$('.play-nav span').removeClass('on');
    		$('.play-nav span').eq(1).addClass('on');
			$('.play-info').hide();
			$('.comment-list').show();
			$('#comment-input').focus();
		});
		$('.text-btn').click(function(){
			$('.play-info-text').show();
		});
		$('.play-info-close').click(function(){
			$('.play-info-text').hide();
		});
		$('.play-zu-ul li').click(function(){
			$('.play-zu-ul li').removeClass('on');
			$(this).addClass('on');
			var zid = $(this).data('id');
			$('.play-ji-ul').hide();
			$('#zu-'+zid).show();
			var isWidth = $('.play-info').width();
			var tempIndex2 = $(this).index() - 2;
		    tempIndex2 = tempIndex2 <= 0 ? 0 : tempIndex2;
		    var left = tempIndex2 * (isWidth / 4);
		    $(".play-zu-ul").animate({scrollLeft: left},500);
		});
		$('.ji-btn').click(function(){
			var zid = $('.play-zu-ul li.on').data('id');
			$('.play-info-ji-ul').html($('#zu-'+zid).html());
			if(jiheight == 0){
				$('.play-info-ji-box').show();
			}else{
				$('.play-info-ji-box').show();
			}
			var height = document.documentElement.clientHeight;
			$('.play-info').css('height',(height-350)+'px').css('overflow','auto');
		});
		$('.play-info-ji-close').click(function(){
			$('.play-info-ji-box').hide();
			$('.play-info').css('height','auto');
		});
		//回复评论框显隐
	    $('body').on('click','.cmd .one,.reply-list .cmd .reply',function(){
	        get_is_log();
	        var nickname = $(this).parent().data('nickname');
	        var fid = $(this).parent().data('fid');
	        if(nickname != '') $('#comment-input').attr('placeholder','回复：'+nickname);
	        $('#comment-input').data('nickname',nickname);
	        $('#comment-input').data('fid',fid);
	        $('#comment-input').val('').focus();
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
	    $('body').on('click','.comment-btn',function(){
	    	get_is_log();
	        var vid = $('#comment-input').data('vid');
	        var fid = $('#comment-input').data('fid');
	        var nickname = $('#comment-input').data('nickname');
	        var text = $('#comment-input').val();
	        if(text != ''){
	            if(nickname != '') text = '@'+nickname+' '+text;
	            var tindex = layer.load();
	            $.post('/index.php/ajax/comment_add',{vid:vid,fid:fid,text:text}, function(res) {
	                layer.close(tindex);
	                if(res.code == 1){
	                   $('#comment-input').val('');
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
	    $('#comment-input').bind('keyup',function(event){
	        if(event.keyCode == 13) {
	            $('.comment-btn').click();
	        }
	    });
	    //评论点赞
	    $('body').on('click','.comment-list .cmd .zan',function(){
	        get_is_log();
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
	    function get_vod_play(){
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
		                            get_is_log();
		                        }else{
		                            window.location.href = '/index.php/user/pay';
		                        }
		                    }else if(res.code == 'pay'){
				                // 登录
				                if(data.pay.init == 1){
				                    get_is_log();
				                }else if(data.pay.init == 2){
				                    window.location.href = '/index.php/user/pay';
			                    }else if(data.pay.init == 5){
			                        window.location.href = '/index.php/appdown';
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
				                    	get_is_log();
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
    }
});
function get_is_log(a){
	if(!getcookie('user_token')){
        if(a == 1) return false;
        window.location.href = '/user/login';
    }else{
		return true;
    }
}
function get_hot_data(post,flow){
	post.hot = 1;
	post.size = 50;
	var index = layer.load();
	$.post('/index.php/ajax/vod',post,function(res) {
		layer.close(index);
    	if(res.code == 1){
    		var html = '';
    		for (var i = 0; i < res.data.list.length; i++) {
    			var k = i+1,pid = i > 2 ? 4 : i+1;
    			var pay =  res.data.list[i].pay > 0 ? '<img class="videoul-vip" src="/packs/images/load.gif" lay-src="'+_tpldir_+'images/pay'+res.data.list[i].pay+'.png">' : '';
    			html += '<div class="rankingul-cont"><a href="'+res.data.list[i].info_url+'" class="rankingul-cover"><img class="rankingul-cover-img" src="/packs/images/load.gif" lay-src="'+res.data.list[i].pic+'" >'+pay+'<div class="rankingul-rank"><img src="'+_tpldir_+'images/ranking-'+pid+'.png" alt=""><span>'+k+'</span></div></a><div class="rankingul-info flex1"><div class="rankingul-info-head centerY betweenX"><p><a href="'+res.data.list[i].info_url+'">'+res.data.list[i].name+'</a></p><span>'+res.data.list[i].score+'</span></div><p class="rankingul-info-per">'+res.data.list[i].actor+'</p><p class="rankingul-info-tips"><a href="'+res.data.list[i].info_url+'" style="color:#999;">'+res.data.list[i].text+'</a></p><div class="rankingul-infofun centerY betweenX"><div class="rankingul-degree"><img src="'+_tpldir_+'images/ranking-redu.png" alt=""><span>'+res.data.list[i].hits+'</span><span>热度值</span></div><div class="centerY"><div data-type="vod" data-fav="'+res.data.list[i].fav+'" data-id="'+res.data.list[i].id+'" class="rankingul-collection centerXY fav-btn"><img src="'+_tpldir_+'images/ranking-sc'+(res.data.list[i].fav==1?'k':'')+'.png" ></div><a href="'+res.data.list[i].play_url+'" class="rankingul-play centerXY"><img src="'+_tpldir_+'images/ranking-bf.png"><span>播放</span></a></div></div></div></div>';
    		}
    		if(res.data.list.length == 0) html = '<div class="nodata"><img src="'+_tpldir_+'images/noviedo.png"><p>没有数据~!</p></div>';
    		$("#hot-vod-list").html(html);
    		flow.lazyimg();
    		$(".return-top").click();
    	}
    },'json');
}
function get_data(post){
	if(end == 0){
    	page++;
    	post.page = page;
		$.post('/index.php/ajax/vod',post,function(res) {
	    	if(res.code == 1){
	    		var html = '';
	    		for (var i = 0; i < res.data.list.length; i++) {
	    			var pay =  res.data.list[i].pay > 0 ? '<img class="videoul-vip" src="/packs/images/load.gif" lay-src="'+_tpldir_+'images/pay'+res.data.list[i].pay+'.png">' : '';
	    			html += '<li class="videoul-li"><a href="'+res.data.list[i].info_url+'" class="videoul-a"><div class="videoul-conet"><img class="videoul-img" src="'+res.data.list[i].pic+'">'+pay+'<p class="videoul-tips pone"><span class="pone videoul-tips1">'+res.data.list[i].state+'</span></p></div><p class="pone videoul-title">'+res.data.list[i].name+'</p></a></li>';
	    		}
	    		if(res.data.page >= res.data.pagejs){
	    			end = 1;
	    			html+='<p class="nopage">没有更多了~!</p>';
	    		}
	    		$("#page-more").append(html);
	    		isloading = false;
	    	}
	    },'json');
	}
}
function get_star_data(post){
	if(end == 0){
    	page++;
    	post.page = page;
		$.post('/index.php/ajax/star',post,function(res) {
	    	if(res.code == 1){
	    		var html = '';
	    		for (var i = 0; i < res.data.list.length; i++) {
	    			html += '<li><a href="'+res.data.list[i].url+'"><img src="/packs/images/load.gif" lay-src="'+res.data.list[i].pic+'" class="pic"><div class="name">'+res.data.list[i].name+'</div></a></li>';
	    		}
	    		if(res.data.page >= res.data.pagejs){
	    			end = 1;
	    			html+='<p class="nopage">没有更多了~!</p>';
	    		}
	    		$("#star-page-more").append(html);
	    		isloading = false;
	    	}
	    },'json');
	}
}
function returns() {
	window.location.href = "javascript:history.go(-1)";
}
var clock = '';
var nums = 60;
var btn;
function sendCode(thisBtn) {
	var tel = $('#tel').val();
	if(tel == ''){
		layer.msg('请输入正确的手机号码',{shift:6});
		return;
	}
	$.post('/index.php/ajax/telcode/reg',{tel:tel},function(res) {
	    if(res.code == 1){
	    	layer.msg('验证码已发送');
			btn = thisBtn;
			btn.disabled = true; //将按钮置为不可点击
			btn.value = '重试'+nums+'s';
			clock = setInterval(doLoop, 1000); //一秒执行一次
	    }else{
	    	layer.msg(res.msg,{shift:6});
	    }
	},'json');
}
function doLoop() {
	nums--;
	if (nums > 0) {
		btn.value ='重试'+nums+'s';
	} else {
		clearInterval(clock); //清除js定时器
		btn.disabled = false;
		btn.text = '获取验证码';
		nums = 60; //重置时间
	}
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