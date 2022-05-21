<script>$('#nav-<?=$fid?>').addClass('on');</script>
<div class="layui-main">
    <div class="layui-container">
        <div class="ads"><script src="<?=_tpldir_?>adv/vod1.js"></script></div>
        <div class="layui-row">
            <ul class="channel">
                <li>
                    <div class="name">频道:</div>
                    <div class="list">
                        <?php
                        $class = $this->mydb->get_select('class',array('fid'=>0),'id,name','xid asc',30);
                        foreach($class as $row){
                            $cls = $row['id'] == $fid ? 'on' : '';
                            echo '<a href="'.links('lists',$row['id']).'" class="'.$cls.'">'.$row['name'].'</a>';
                        }
                        ?>
                    </div>
                </li>
                <li id="cid">
                    <div class="name">分类:</div>
                    <div class="list">
                        <a href="<?=get_vod_url(array('cid'=>$fid))?>" <?php if($cid == 0) echo ' class="on"';?>>全部</a>
                    <?php
                        $class = $this->mydb->get_select('class',array('fid'=>$fid),'id,name','xid asc',50);
                        foreach($class as $row){
                            $cls = $row['id'] == $id ? 'on' :'';
                            echo '<a href="'.get_vod_url(array('cid'=>$row['id'])).'" class="cid '.$cls.'">'.$row['name'].'</a>';
                        }
                    ?>
                    </div>
                </li>
                <script>if($('#cid .cid').length == 0) $('#cid').hide();</script>
                <li>
                    <div class="name">地区:</div>
                    <div class="list">
                        <a href="<?=get_vod_url(array('area'=>''))?>" <?php if($area == '') echo ' class="on"';?>>全部</a>
                    <?php
                        foreach($area_list as $v){
                            $cls = $v == $area ? 'on' :'';
                            echo '<a href="'.get_vod_url(array('area'=>$v)).'" class="'.$cls.'">'.$v.'</a>';
                        }
                    ?>
                    </div>
                </li>
                <li>
                    <div class="name">年份:</div>
                    <div class="list">
                        <a href="<?=get_vod_url(array('year'=>''))?>" <?php if($year == '') echo ' class="on"';?>>全部</a>
                    <?php
                    for($y=date('Y');$y>2006;$y--){
                        $cls = $y == $year ? 'on' :'';
                        echo '<a href="'.get_vod_url(array('year'=>$y)).'" class="'.$cls.'">'.$y.'</a>';
                    }
                    ?>
                    </div>
                </li>
                <li>
                    <div class="name">排序:</div>
                    <div class="list">
                        <a href="<?=get_vod_url(array('sort'=>''))?>"<?php if($sort == 'addtime') echo ' class="on"';?>>更新</a>
                        <a href="<?=get_vod_url(array('sort'=>'hits'))?>"<?php if($sort == 'hits') echo ' class="on"';?>>人气</a>
                        <a href="<?=get_vod_url(array('sort'=>'score'))?>"<?php if($sort == 'score') echo ' class="on"';?>>评分</a>
                    </div>
                </li>
            </ul>
        </div>
        <div class="ads"><script src="<?=_tpldir_?>adv/vod2.js"></script></div>
        <div class="layui-row">
            <ul class="vod_list">
            <?php
            foreach($vod as $row){
                echo '<li><a href="'.links('info',$row['id']).'"><div class="pic"><img src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'"><div class="play"></div><div class="score">'.$row['score'].'分</div><div class="state">'.$row['state'].'</div></div><div class="name">'.$row['name'].'</div><div class="actor">主演：'.$row['actor'].'</div></a></li>';
            }
            ?>
            </ul>
        </div>
        <?php if($pagejs > 1){ ?>
        <div class="layui-row">
            <div id="pages" data-count="<?=$nums?>" data-limit="48" data-page="<?=$page?>" data-link="<?=get_vod_url(array('page'=>'{page}'))?>"></div>
        </div>
        <?php } ?>
        <div class="ads"><script src="<?=_tpldir_?>adv/vod3.js"></script></div>
    </div>
</div>