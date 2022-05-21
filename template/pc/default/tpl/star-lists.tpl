<script>$('#nav-star').addClass('on');</script>
<div class="layui-main">
    <div class="layui-container star-box" style="margin-top:0;">
        <div class="layui-row">
            <ul class="channel">
                <li>
                    <div class="name">明星分类:</div>
                    <div class="list">
                        <?php
                        $class = $this->mydb->get_select('star_class',array(),'id,name','xid asc',30);
                        foreach($class as $row){
                            $cls = $row['id'] == $id ? 'on' : '';
                            echo '<a href="'.links('starlists',$row['id']).'" class="'.$cls.'">'.$row['name'].'</a>';
                        }
                        ?>
                    </div>
                </li>
            </ul>
        </div>
        <div class="layui-row">
            <h3><?=$name?>列表</h3>
            <ul class="star-list">
            <?php
            foreach($star as $k=>$row){
                echo '<li><a href="'.links('starinfo',$row['id']).'"><div class="pic"><img alt="'.$row['name'].'" src="/packs/images/load.gif" lay-src="'.getpic($row['pic']).'"></div><div class="name">'.$row['name'].'</div></a></li>';
            }
            ?>
            </ul>
        </div>
        <?php if($pagejs > 1){ ?>
        <div class="layui-row">
            <div id="pages" data-count="<?=$nums?>" data-limit="48" data-page="<?=$page?>" data-link="<?=links('starlists',$id,'{page}')?>"></div>
        </div>
        <?php } ?>
    </div>
</div>
