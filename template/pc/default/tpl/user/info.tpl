
<div class="user-data-box">
    <div class="layui-container">
        <div class="layui-row">
            <form class="user-info-edit layui-form layui-form-pane">
                <fieldset class="layui-elem-field layui-field-title">
                    <legend>头像修改</legend>
                </fieldset>
                <div class="pic uppic">
                    <img src="<?=getpic($pic)?>"> 点击头像即可修改
                </div>
                <fieldset class="layui-elem-field layui-field-title">
                    <legend>昵称修改</legend>
                </fieldset>
                <div class="layui-form-item">
                    <label class="layui-form-label">昵称</label>
                    <div class="layui-input-block">
                        <input type="text" name="nickname" value="<?=$nickname?>" autocomplete="off" placeholder="请输入昵称" class="layui-input">
                        <button type="submit" class="layui-btn edit" lay-submit="" lay-filter="edit-nickname">立即提交</button>
                    </div>
                </div>
                <fieldset class="layui-elem-field layui-field-title">
                    <legend>安全设置</legend>
                </fieldset>
                <div class="layui-form-item">
                    <label class="layui-form-label">手机</label>
                    <div class="layui-input-block">
                        <input type="text" id="ytel" name="tel" value="<?=$tel?>" autocomplete="off" class="layui-input" disabled="">
                        <div class="edit user-edit-btn"><span data-type="tel">修改手机</span><span data-type="pass">重置密码</span></div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>