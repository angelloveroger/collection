<style type="text/css">html{background-color: #F9F9F9;}</style>
<!-- tabhead -->
<div class="pageHead betweenX centerY">
	<div class="pageHead-left" onclick="returns()">
		<i class="iconfont icon-xiangzuo"></i>
	</div>
	<div class="pageHead-text">设置</div>
	<div class="pageHead-right">
	</div>
</div>
<div style="height: 54px;"></div>
<div class="upfrom">
	<a href="<?=links('user/edit')?>" class="uplist centerY betweenX" >
		<div class="uplist-left">
			<span class="uplist-title">编辑资料</span>
		</div>
		<div class="uplist-right">
			<img src="<?=_tpldir_?>images/right2.png">
		</div>
	</a>
	<a href="<?=links('user/edit/tel')?>" class="uplist centerY betweenX">
		<div class="uplist-left">
			<span class="uplist-title">更换手机号</span>
		</div>
		<div class="uplist-right">
			<span class="uplist-right-text"><?=$tel?></span>
			<img src="<?=_tpldir_?>images/right2.png" >
		</div>
	</a>
	<a href="<?=links('user/edit/pass')?>" class="uplist centerY betweenX">
		<div class="uplist-left">
			<span class="uplist-title">重置密码</span>
		</div>
		<div class="uplist-right">
			<img src="<?=_tpldir_?>images/right2.png" >
		</div>
	</a>
</div>
<div class="setupout" onclick="signOut()">退出登录</div>
<script type="text/javascript">
	function signOut(){
		layer.confirm('确定要退出吗？？', {
            title: false,
            closeBtn : 0,
            btn: ['确定', '取消'], //按钮
            shade:0.001
        }, function(index) {
            layer.close(index);
            var tindex = layer.load();
            $.get('/index.php/ajax/logout',function(res){
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
	}
</script>