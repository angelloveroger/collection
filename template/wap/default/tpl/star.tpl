<!-- tabhead -->
<div class="pageHead betweenX centerY">
	<div class="pageHead-left">
		<a style="display:block;" href="/"><i class="iconfont icon-xiangzuo"></i></a>
	</div>
	<div class="pageHead-text">明星库</div>
	<div class="pageHead-right"></div>
</div>
<div style="height: 54px;"></div>
<div class="index-boxhead centerY betweenX">
	<div>热门明星</div>
	<a href="<?=links('starhot')?>" class="centerY">
		<span>查看更多</span>
		<i class="iconfont icon-xiangyou"></i>
	</a>
</div>
<div class="starbox">
	<ul class="starul">
		<?php
		$star = $this->mydb->get_select('star',array(),'id,name,pic','hits desc',30);
		foreach($star as $row){
			echo '<li><a href="'.links('starinfo',$row['id']).'"><img alt="'.$row['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'" class="pic"><div class="name">'.$row['name'].'</div></a></li>';
		}
		?>
	</ul>
</div>
<?php
$star_class = $this->mydb->get_select('star_class',array(),'id,name','xid asc',10);
foreach($star_class as $rowc){
?>
<div class="index-boxhead centerY betweenX">
	<div>最新<?=$rowc['name']?></div>
	<a href="<?=links('starlists',$rowc['id'])?>" class="centerY">
		<span>查看更多</span>
		<i class="iconfont icon-xiangyou"></i>
	</a>
</div>
<ul class="starlist">
	<?php
    $star = $this->mydb->get_select('star',array('cid'=>$rowc['id']),'id,name,pic','id desc',12);
    foreach($star as $k=>$row){
		echo '<li><a href="'.links('starinfo',$row['id']).'"><img alt="'.$row['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'" class="pic"><div class="name">'.$row['name'].'</div></a></li>';
	}
	?>
</ul>
<?php } ?>