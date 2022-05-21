<!-- tabhead -->
<div class="pageHead betweenX centerY">
    <div class="pageHead-left" onclick="returns()">
        <i class="iconfont icon-xiangzuo"></i>
    </div>
    <div class="pageHead-text">充值记录</div>
    <div class="pageHead-right">
    </div>
</div>
<div style="height: 54px;"></div>
<div  class="collzt" id="pagejs">
    <?php
    foreach($list as $row){
        echo '<div class="record-list centerY betweenX"><div><div class="record-title">'.$row['text'].'</div><div class="record-item">'.$row['addtime'].'</div></div><div class="record-pirce">-'.$row['rmb'].'元</div></div>';
    } 
    if(empty($list)) echo '<div class="nodata"><img src="'._tpldir_.'images/noviedo.png"><p>没有数据~!</p></div>';
    ?>
</div>
<script>
isloading = false,page = 1;
$(window).bind("scroll", function () {
    if($(document).scrollTop() + $(window).height() 
          > $(document).height() - 10 && !isloading) {
    	page++;
        isloading = true;
    	var tindex = layer.load();
        $.post('<?=links('user/pay/lists')?>',{page:page}, function(res) {
            layer.close(tindex);
            if(res.code == 1){
                var html = '';
                for (var i = 0; i < res.data.list.length; i++) {
					html+='<div class="record-list centerY betweenX"><div><div class="record-title">'+res.data.list[i].text+'</div><div class="record-item">'+res.data.list[i].addtime+'</div></div><div class="record-pirce">-'+res.data.list[i].rmb+'元</div></div>';
                }
                $('#pagejs').append(html);
                if(res.data.page < res.data.pagejs) isloading = false;
            }
        },'json');
    }
});
</script>