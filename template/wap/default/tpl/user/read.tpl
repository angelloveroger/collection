<!-- tabhead -->
<div class="pageHead betweenX centerY">
    <div class="pageHead-left" onclick="returns()">
        <i class="iconfont icon-xiangzuo"></i>
    </div>
    <div class="pageHead-text">观看历史</div>
    <div class="pageHead-right">
        <a href="javascript:;" class="functions">编辑</a>
    </div>
</div>
<div style="height: 54px;"></div>
<form class="cache-form watchHistory" id="pagejs">
<?php
foreach($list as $row){
    echo '<a class="cache-form-li" href="'.$row['link'].'"><div class="cache-form-checkbox"><input type="checkbox" id="checkboxs'.$row['vid'].'" value="'.$row['vid'].'"><label for="checkboxs'.$row['vid'].'" ></label></div><div class="cache-form-cont"><div class="cache-form-img"><img src="'.getpic($row['pic']).'" ></div><div class="cache-form-info"> <p class="cache-form-deom">'.$row['name'].'</p><div class="cache-form-dosut"><img src="'._tpldir_.'images/guankan.png" ><span>'.$row['duration'].'</span></div></div></div></a>';
}
?>
</form>
<div class="editChoice-box" style="height: 40px;"></div>
<div class="editChoice-box editChoice">
    <div class="editChoice-cent">
        <a href="javascript:get_xuan();">全选/反选</a>
        <a href="javascript:get_del();">删除</a>
    </div>
</div>
<script>
isloading = false,page = 1;
$(window).bind("scroll", function () {
    if($(document).scrollTop() + $(window).height() 
          > $(document).height() - 10 && !isloading) {
    	page++;
        isloading = true;
    	var tindex = layer.load();
        $.post('<?=links('user/read')?>',{page:page}, function(res) {
            layer.close(tindex);
            if(res.code == 1){
                var html = '';
                for (var i = 0; i < res.data.list.length; i++) {
					html+='<a class="cache-form-li" href="'+res.data.list[i].link+'"><div class="cache-form-checkbox"><input type="checkbox" id="checkboxs'+res.data.list[i].vid+'" value="'+res.data.list[i].vid+'"><label for="checkboxs'+res.data.list[i].vid+'" ></label></div><div class="cache-form-cont"><div class="cache-form-img"><img src="'+res.data.list[i].pic+'" ></div><div class="cache-form-info"> <p class="cache-form-deom">'+res.data.list[i].name+'</p><div class="cache-form-dosut"><img src="'+_tpldir_+'images/guankan.png" ><span>'+res.data.list[i].duration+'</span></div></div></div></a>';
                }
                $('#pagejs').append(html);
                if(res.data.page < res.data.pagejs) isloading = false;
            }
        },'json');
    }
});
$(".pageHead-fu p").click(function(){
     $(this).addClass('activefu').siblings().removeClass('activefu');
    $('.pageHead-tab form').eq($(this).index()).show().siblings().hide()
});
$(".functions").click(function(){
    var text=$(this).text()
    if(text=='编辑'){
        $(this).text('取消')
        $(".cache-form-checkbox").show()
        $(".editChoice-box").show()
        
    }
    if(text=='取消'){
        $(this).text('编辑')
        $(".cache-form-checkbox").hide()
        $(".editChoice-box").hide()
    }
});
function get_xuan(){
    if(!$('.cache-form-checkbox input').is(':checked')){
        $('.cache-form-checkbox input').attr('checked',true);
    }else{
        $('.cache-form-checkbox input').attr('checked',false);
    }
}
function get_del(){
    var did = [];
    $('.cache-form-checkbox input:checked').each(function(){
        did.push($(this).val());
    });
    if(did.length == 0){
        layer.msg('请选择要删除的记录',{shift:6});
    }else{
        layer.confirm('不可恢复，确定吗？', {
            title: false,
            closeBtn : 0,
            btn: ['确定', '取消'], //按钮
            shade:0.001
        }, function(index) {
            layer.close(index);
            var tindex = layer.load();
            $.post('/index.php/ajax/delwatch',{ids:did.join(',')},function(res){
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
</script>