DROP TABLE IF EXISTS `[dbprefix]qrcode_log`;
CREATE TABLE `[dbprefix]qrcode_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) DEFAULT '',
  `ip` varchar(30) DEFAULT '',
  `uid` int(11) DEFAULT '0',
  `init` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]admin`;
CREATE TABLE `[dbprefix]admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT '',
  `pass` varchar(64) DEFAULT '',
  `logip` varchar(64) DEFAULT '',
  `lognum` int(11) DEFAULT '0',
  `logtime` int(11) DEFAULT '0',
  `qx` text,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]agent`;
CREATE TABLE `[dbprefix]agent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT '',
  `pass` varchar(64) DEFAULT '',
  `rmb` decimal(8,2) DEFAULT '0.00',
  `cfee` smallint(3) DEFAULT '70',
  `pay_name` varchar(64) DEFAULT '',
  `pay_card` varchar(64) DEFAULT '',
  `pay_bank` varchar(64) DEFAULT '',
  `pay_bank_city` varchar(64) DEFAULT '',
  `sid` tinyint(1) DEFAULT '0',
  `logtime` int(11) DEFAULT '0',
  `addtime` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]agent_withdrawal`;
CREATE TABLE `[dbprefix]agent_withdrawal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dd` varchar(32) DEFAULT '',
  `aid` int(11) DEFAULT '0',
  `rmb` decimal(8,2) DEFAULT '0.00',
  `pid` tinyint(1) DEFAULT '0',
  `pay_name` varchar(64) DEFAULT '',
  `pay_card` varchar(64) DEFAULT '',
  `pay_bank` varchar(64) DEFAULT '',
  `pay_bank_city` varchar(64) DEFAULT '',
  `msg` varchar(128) DEFAULT '',
  `paytime` int(11) DEFAULT '0',
  `addtime` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `dd` (`dd`),
  KEY `aid` (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]class`;
CREATE TABLE `[dbprefix]class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` int(11) DEFAULT '0' COMMENT '上级ID',
  `name` varchar(64) DEFAULT '' COMMENT '名字',
  `xid` int(11) DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `fid` (`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]comment`;
CREATE TABLE `[dbprefix]comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` int(11) DEFAULT '0' COMMENT '上级ID',
  `vid` int(11) DEFAULT '0' COMMENT '视频ID',
  `bid` int(11) DEFAULT '0' COMMENT '帖子ID',
  `did` int(11) DEFAULT '0' COMMENT '短视ID',
  `uid` int(11) DEFAULT '0' COMMENT '用户ID',
  `text` varchar(255) DEFAULT '' COMMENT '内容',
  `zan` int(11) DEFAULT '0' COMMENT '被赞次数',
  `yid` tinyint(1) DEFAULT '0' COMMENT '0正常，1审核中',
  `addtime` int(11) DEFAULT '0' COMMENT '时间',
  PRIMARY KEY (`id`),
  KEY `fid` (`fid`),
  KEY `uid` (`uid`),
  KEY `yid` (`yid`),
  KEY `vid` (`vid`),
  KEY `bid` (`bid`),
  KEY `did` (`did`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论';
DROP TABLE IF EXISTS `[dbprefix]comment_report`;
CREATE TABLE `[dbprefix]comment_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0' COMMENT '用户ID',
  `did` int(11) DEFAULT '0' COMMENT '评论ID',
  `type` varchar(64) DEFAULT '',
  `text` varchar(255) DEFAULT '' COMMENT '举报内容',
  `addtime` int(11) DEFAULT '0' COMMENT '时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `did` (`did`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论举报';
DROP TABLE IF EXISTS `[dbprefix]comment_zan`;
CREATE TABLE `[dbprefix]comment_zan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `did` int(11) DEFAULT '0' COMMENT '评论ID',
  `uid` int(11) DEFAULT '0' COMMENT '用户ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `did_uid` (`did`,`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COMMENT='评论点赞';
DROP TABLE IF EXISTS `[dbprefix]down`;
CREATE TABLE `[dbprefix]down` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0',
  `vid` int(11) DEFAULT '0',
  `zid` int(11) DEFAULT '0',
  `jid` int(11) DEFAULT '0',
  `down_size` bigint(20) DEFAULT '0',
  `size` bigint(20) DEFAULT '0',
  `progress` decimal(6,2) DEFAULT '0.00' COMMENT '进度百分比',
  `zt` tinyint(1) DEFAULT '0',
  `addtime` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `vid` (`vid`),
  KEY `zid` (`zid`),
  KEY `jid` (`jid`),
  KEY `progress` (`progress`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]fav`;
CREATE TABLE `[dbprefix]fav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vid` int(11) DEFAULT '0' COMMENT '视频ID',
  `uid` int(11) DEFAULT '0' COMMENT '用户ID',
  `addtime` int(11) DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`id`),
  KEY `vid` (`vid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收藏记录';
DROP TABLE IF EXISTS `[dbprefix]feedback`;
CREATE TABLE `[dbprefix]feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0' COMMENT '用户ID',
  `type` varchar(128) DEFAULT '',
  `text` varchar(255) DEFAULT '' COMMENT '留言内容',
  `reply_text` varchar(255) DEFAULT '' COMMENT '回复内容',
  `reply_time` int(11) DEFAULT '0' COMMENT '回复时间',
  `pics` text COMMENT '图片',
  `addtime` int(11) DEFAULT '0' COMMENT '留言时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `reply_time` (`reply_time`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='用户反馈';
DROP TABLE IF EXISTS `[dbprefix]links`;
CREATE TABLE `[dbprefix]links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT '',
  `url` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]player`;
CREATE TABLE `[dbprefix]player` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT '' COMMENT '名称',
  `alias` varchar(64) DEFAULT '' COMMENT '别名',
  `text` varchar(255) DEFAULT '' COMMENT '介绍',
  `jxurl` text COMMENT '解析地址',
  `type` varchar(64) DEFAULT '' COMMENT '播放方式',
  `yid` tinyint(1) DEFAULT '0' COMMENT '状态：1不显示',
  `xid` int(11) DEFAULT '0' COMMENT '排序ID',
  PRIMARY KEY (`id`),
  KEY `xid` (`xid`),
  KEY `yid` (`yid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='播放器';
DROP TABLE IF EXISTS `[dbprefix]star`;
CREATE TABLE `[dbprefix]star` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT '0' COMMENT '分类ID',
  `tid` tinyint(1) DEFAULT '0' COMMENT '是否推荐：0未，1已',
  `name` varchar(128) DEFAULT '' COMMENT '名字',
  `yname` varchar(128) DEFAULT '' COMMENT '英文名',
  `pic` varchar(255) DEFAULT '' COMMENT '图片地址',
  `weight` varchar(64) DEFAULT '' COMMENT '体重',
  `height` varchar(64) DEFAULT '' COMMENT '身高',
  `alias` varchar(128) DEFAULT '' COMMENT '别名',
  `nationality` varchar(64) DEFAULT '' COMMENT '国籍',
  `ethnic` varchar(64) DEFAULT '' COMMENT '民族',
  `professional` varchar(128) DEFAULT '' COMMENT '职业',
  `blood_type` varchar(20) DEFAULT '' COMMENT '血型',
  `birthday` varchar(30) DEFAULT '' COMMENT '生日',
  `city` varchar(64) DEFAULT '' COMMENT '地区',
  `constellation` varchar(20) DEFAULT '' COMMENT '星座',
  `company` varchar(128) DEFAULT '' COMMENT '经纪公司',
  `production` varchar(255) DEFAULT '' COMMENT '代表作品',
  `academy` varchar(255) DEFAULT '' COMMENT '毕业院校',
  `text` text COMMENT '简介',
  `hits` int(11) DEFAULT '0' COMMENT '人气',
  `addtime` int(11) DEFAULT '0' COMMENT '发布时间',
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`),
  KEY `hits` (`hits`),
  KEY `addtime` (`addtime`),
  KEY `tid` (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
DROP TABLE IF EXISTS `[dbprefix]star_class`;
CREATE TABLE `[dbprefix]star_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT '',
  `fid` int(11) DEFAULT '0',
  `xid` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fid` (`fid`),
  KEY `xid` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
DROP TABLE IF EXISTS `[dbprefix]topic`;
CREATE TABLE `[dbprefix]topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` tinyint(1) DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `pic` varchar(255) DEFAULT '',
  `text` text,
  `hits` int(11) DEFAULT '0',
  `addtime` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]topic_fav`;
CREATE TABLE `[dbprefix]topic_fav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) DEFAULT '0' COMMENT '专题ID',
  `uid` int(11) DEFAULT '0' COMMENT '用户ID',
  `addtime` int(11) DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `tid` (`tid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收藏记录';
DROP TABLE IF EXISTS `[dbprefix]user`;
CREATE TABLE `[dbprefix]user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aid` int(11) DEFAULT '0' COMMENT '代理ID',
  `fid` int(11) DEFAULT '0' COMMENT '邀请人ID',
  `tel` varchar(20) DEFAULT '' COMMENT '手机号',
  `pass` varchar(64) DEFAULT '' COMMENT '密码',
  `nickname` varchar(64) DEFAULT '' COMMENT '昵称',
  `pic` varchar(255) DEFAULT '' COMMENT '头像地址',
  `sex` tinyint(1) DEFAULT '0',
  `vip` tinyint(1) DEFAULT '0' COMMENT '是否VIP',
  `viptime` int(11) DEFAULT '0',
  `cion` int(11) DEFAULT '0' COMMENT '金币',
  `qdnum` int(11) DEFAULT '0' COMMENT '签到天数',
  `qdznum` int(11) DEFAULT '0' COMMENT '签到总天数',
  `qddate` int(11) DEFAULT '0' COMMENT '签到日期',
  `duration` int(11) DEFAULT '0' COMMENT '每天看视频时长',
  `facility` varchar(30) DEFAULT '' COMMENT '来源',
  `deviceid` varchar(128) DEFAULT '' COMMENT '设备ID',
  `share_num` int(11) DEFAULT '0' COMMENT '当日邀请次数',
  `addtime` int(11) DEFAULT '0' COMMENT '加入时间',
  `logtime` int(11) DEFAULT '0' COMMENT '活跃时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tel` (`tel`) USING BTREE,
  KEY `channel` (`facility`),
  KEY `deviceid` (`deviceid`),
  KEY `aid` (`aid`),
  KEY `fid` (`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]user_android`;
CREATE TABLE `[dbprefix]user_android` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0' COMMENT '用户ID',
  `fid` int(11) DEFAULT '0' COMMENT '上级ID',
  `deviceid` varchar(64) DEFAULT '' COMMENT '设备id',
  `date` int(11) DEFAULT '0' COMMENT '访问日期',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceid` (`deviceid`),
  KEY `uid` (`uid`),
  KEY `fid` (`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]user_card`;
CREATE TABLE `[dbprefix]user_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aid` int(11) DEFAULT '0' COMMENT '代理ID',
  `pass` varchar(128) DEFAULT '',
  `nums` int(11) DEFAULT '0',
  `rmb` decimal(8,2) DEFAULT '0.00',
  `type` tinyint(1) DEFAULT '1' COMMENT '1VIP，2金币',
  `uid` int(11) DEFAULT '0',
  `paytime` int(11) DEFAULT '0',
  `endtime` int(11) DEFAULT '0' COMMENT '到期时间',
  PRIMARY KEY (`id`),
  KEY `pass` (`pass`),
  KEY `uid` (`uid`),
  KEY `aid` (`aid`),
  KEY `paytime` (`paytime`),
  KEY `endtime` (`endtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]user_cion_list`;
CREATE TABLE `[dbprefix]user_cion_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` tinyint(1) DEFAULT '1' COMMENT '1收入，2消费',
  `uid` int(11) DEFAULT '0',
  `text` varchar(255) DEFAULT '',
  `cion` int(11) DEFAULT '0',
  `addtime` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]user_code`;
CREATE TABLE `[dbprefix]user_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` int(11) DEFAULT '0',
  `tel` varchar(20) DEFAULT '' COMMENT '手机号',
  `code` int(11) DEFAULT '0' COMMENT '验证码',
  `addtime` int(11) DEFAULT '0' COMMENT '发送时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tel` (`tel`) USING BTREE,
  KEY `fid` (`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手机验证码';
DROP TABLE IF EXISTS `[dbprefix]user_ios`;
CREATE TABLE `[dbprefix]user_ios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0' COMMENT '用户ID',
  `fid` int(11) DEFAULT '0' COMMENT '上级ID',
  `deviceid` varchar(64) DEFAULT '' COMMENT '设备id',
  `date` int(11) DEFAULT '0' COMMENT '访问日期',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceid` (`deviceid`),
  KEY `uid` (`uid`),
  KEY `fid` (`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]user_nums`;
CREATE TABLE `[dbprefix]user_nums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `android_add` int(11) DEFAULT '0',
  `android_num` int(11) DEFAULT '0',
  `ios_add` int(11) DEFAULT '0',
  `ios_num` int(11) DEFAULT '0',
  `date` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `date` (`date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]user_order`;
CREATE TABLE `[dbprefix]user_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aid` int(11) DEFAULT '0' COMMENT '代理ID',
  `uid` int(11) DEFAULT '0',
  `dd` varchar(128) DEFAULT '',
  `trade_no` varchar(128) DEFAULT '',
  `rmb` decimal(8,2) DEFAULT '0.00',
  `day` int(11) DEFAULT '0',
  `cion` int(11) DEFAULT '0',
  `pid` tinyint(1) DEFAULT '0',
  `paytype` varchar(64) DEFAULT '',
  `facility` varchar(64) DEFAULT '',
  `addtime` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `dd` (`dd`) USING BTREE,
  KEY `uid` (`uid`),
  KEY `aid` (`aid`),
  KEY `pid` (`pid`),
  KEY `facility` (`facility`),
  KEY `paytype` (`paytype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]user_task`;
CREATE TABLE `[dbprefix]user_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(64) DEFAULT '' COMMENT '类型',
  `name` varchar(64) DEFAULT '',
  `text` varchar(64) DEFAULT '',
  `day` int(1) DEFAULT '0' COMMENT '每天任务次数，0不限制',
  `cion` int(11) DEFAULT '0' COMMENT '单次赠送金币数量',
  `duration` int(11) DEFAULT '0' COMMENT '时长',
  `xid` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `xid` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]user_task_list`;
CREATE TABLE `[dbprefix]user_task_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0',
  `did` int(11) DEFAULT '0',
  `cion` int(11) DEFAULT '0' COMMENT '获得金币数量',
  `addtime` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `uid_did` (`uid`,`did`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]user_vod_buy`;
CREATE TABLE `[dbprefix]user_vod_buy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0',
  `vid` int(11) DEFAULT '0',
  `zid` int(11) DEFAULT '0',
  `jid` int(11) DEFAULT '0',
  `cion` int(11) DEFAULT '0',
  `addtime` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `vid` (`vid`),
  KEY `zid` (`zid`),
  KEY `jid` (`jid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]vod`;
CREATE TABLE `[dbprefix]vod` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT '0' COMMENT '分类ID',
  `reco` tinyint(1) DEFAULT '0' COMMENT '是否主页幻灯图',
  `tid` tinyint(1) DEFAULT '0' COMMENT '是否推荐',
  `ztid` int(11) DEFAULT '0' COMMENT '专题ID',
  `name` varchar(255) DEFAULT '' COMMENT '名字',
  `pic` varchar(255) DEFAULT '' COMMENT '封面图片',
  `picx` varchar(255) DEFAULT '' COMMENT '横图封面',
  `director` varchar(255) DEFAULT '' COMMENT '导演',
  `actor` varchar(255) DEFAULT '' COMMENT '演员',
  `tags` varchar(255) DEFAULT '' COMMENT 'TAGS标签',
  `year` int(11) DEFAULT '2021' COMMENT '年份',
  `area` varchar(64) DEFAULT '' COMMENT '地区',
  `lang` varchar(34) DEFAULT '' COMMENT '国语',
  `state` varchar(64) DEFAULT '' COMMENT '状态',
  `score` decimal(4,1) DEFAULT '10.1' COMMENT '评分',
  `text` varchar(255) DEFAULT '' COMMENT '介绍',
  `sohits` int(11) DEFAULT '0' COMMENT '搜索次数',
  `rhits` int(11) DEFAULT '0' COMMENT '日人气',
  `zhits` int(11) DEFAULT '0' COMMENT '周人气',
  `yhits` int(11) DEFAULT '0' COMMENT '月人气',
  `hits` int(11) DEFAULT '0' COMMENT '总人气',
  `shits` int(11) DEFAULT '0' COMMENT '收藏人气',
  `dhits` int(11) DEFAULT '0' COMMENT '被顶次数',
  `pay` tinyint(1) DEFAULT '0' COMMENT '0免费，1VIP，2点播',
  `app` tinyint(1) DEFAULT '0' COMMENT '是否APP专属，0否1是',
  `addtime` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`),
  KEY `addtime` (`addtime`),
  KEY `score` (`score`),
  KEY `hits` (`hits`),
  KEY `rhits` (`rhits`),
  KEY `zhits` (`zhits`),
  KEY `yhits` (`yhits`),
  KEY `dhits` (`dhits`),
  KEY `lang` (`lang`),
  KEY `area` (`area`),
  KEY `year` (`year`),
  KEY `reco` (`reco`),
  KEY `tid` (`tid`),
  KEY `shits` (`shits`),
  FULLTEXT KEY `name_director_actor` (`name`,`director`,`actor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]vod_barrage`;
CREATE TABLE `[dbprefix]vod_barrage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vid` int(11) DEFAULT '0',
  `jid` int(11) DEFAULT '0',
  `zid` int(11) DEFAULT '0',
  `text` varchar(255) DEFAULT '',
  `uid` int(11) DEFAULT '0',
  `duration` int(11) DEFAULT '0',
  `color` varchar(20) DEFAULT '',
  `addtime` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `vid_zid_jid` (`vid`,`zid`,`jid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]vod_ji`;
CREATE TABLE `[dbprefix]vod_ji` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vid` int(11) DEFAULT '0' COMMENT '视频ID',
  `pid` int(11) DEFAULT '0' COMMENT '播放器ID',
  `zid` int(11) DEFAULT '0' COMMENT '组ID',
  `name` varchar(64) DEFAULT '' COMMENT '名称',
  `playurl` varchar(255) DEFAULT '' COMMENT '播放地址',
  `xid` int(11) DEFAULT '0' COMMENT '排序ID',
  `pay` tinyint(1) DEFAULT '0' COMMENT '0免费，1VIP，2点播',
  `cion` int(11) DEFAULT '0' COMMENT '点播金币',
  PRIMARY KEY (`id`),
  KEY `vid` (`vid`),
  KEY `xid` (`xid`),
  KEY `zid` (`zid`) USING BTREE,
  KEY `pid` (`pid`),
  KEY `pay` (`pay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]vod_zu`;
CREATE TABLE `[dbprefix]vod_zu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vid` int(11) DEFAULT '0' COMMENT '视频ID',
  `pid` int(11) DEFAULT '0' COMMENT '播放器ID',
  `xid` int(11) DEFAULT '0' COMMENT '排序ID',
  PRIMARY KEY (`id`),
  KEY `vid` (`vid`),
  KEY `pid` (`pid`),
  KEY `xid` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]watch`;
CREATE TABLE `[dbprefix]watch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '用户ID',
  `cid` int(11) DEFAULT '0',
  `vid` int(11) DEFAULT '0' COMMENT '视频ID',
  `zid` int(11) DEFAULT '0' COMMENT '组ID',
  `jid` int(11) DEFAULT '0' COMMENT '集数ID',
  `duration` decimal(8,2) DEFAULT '0.00' COMMENT '观看时长',
  `addtime` int(11) DEFAULT '0' COMMENT '观看时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_vid_zid_jid` (`uid`,`vid`,`zid`,`jid`),
  KEY `uid` (`uid`),
  KEY `addtime` (`addtime`),
  KEY `cid` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='观看记录';
DROP TABLE IF EXISTS `[dbprefix]bbs`;
CREATE TABLE `[dbprefix]bbs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '用户ID',
  `cid` int(11) DEFAULT '0' COMMENT '分类ID',
  `ding` tinyint(1) DEFAULT '0' COMMENT '是否置顶',
  `reco` tinyint(1) DEFAULT '0' COMMENT '是否推荐',
  `name` varchar(128) DEFAULT '' COMMENT '标题',
  `text` text COMMENT '内容',
  `zan` int(11) DEFAULT '0' COMMENT '被赞次数',
  `hits` int(11) DEFAULT '0' COMMENT '浏览次数',
  `yid` tinyint(1) DEFAULT '0' COMMENT '是否审核',
  `addtime` int(11) DEFAULT '0' COMMENT '发布时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `cid` (`cid`),
  KEY `addtime` (`addtime`),
  KEY `ding` (`ding`),
  KEY `reco` (`reco`),
  KEY `zan` (`zan`),
  KEY `hits` (`hits`),
  KEY `yid` (`yid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帖子记录';
DROP TABLE IF EXISTS `[dbprefix]bbs_pic`;
CREATE TABLE `[dbprefix]bbs_pic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '用户ID',
  `bid` int(11) DEFAULT '0' COMMENT '帖子ID',
  `url` varchar(255) DEFAULT '' COMMENT '图片地址',
  `addtime` int(11) DEFAULT '0' COMMENT '上传时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `bid` (`bid`),
  KEY `addtime` (`addtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帖子关联图片';
DROP TABLE IF EXISTS `[dbprefix]bbs_class`;
CREATE TABLE `[dbprefix]bbs_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT '' COMMENT '分类名字',
  `pic` varchar(255) DEFAULT '' COMMENT '图片地址',
  `yid` tinyint(1) DEFAULT '0' COMMENT '是否显示',
  `xid` int(11) DEFAULT '0' COMMENT '排序ID',
  PRIMARY KEY (`id`),
  KEY `yid` (`yid`),
  KEY `xid` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帖子标签分类';
DROP TABLE IF EXISTS `[dbprefix]bbs_zan`;
CREATE TABLE `[dbprefix]bbs_zan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `did` int(11) DEFAULT '0' COMMENT '帖子ID',
  `uid` int(11) DEFAULT '0' COMMENT '用户ID',
  `addtime` int(11) DEFAULT '0' COMMENT '时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `did_uid` (`did`,`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COMMENT='帖子点赞';
DROP TABLE IF EXISTS `[dbprefix]myopia`;
CREATE TABLE `[dbprefix]myopia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0' COMMENT '用户ID',
  `nickname` varchar(64) DEFAULT '' COMMENT '用户昵称',
  `upic` varchar(255) DEFAULT '' COMMENT '用户头像',
  `cid` int(11) DEFAULT '0' COMMENT '分类ID',
  `tid` tinyint(1) DEFAULT '0' COMMENT '是否推荐',
  `pic` varchar(255) DEFAULT '' COMMENT '封面地址',
  `text` varchar(255) DEFAULT '' COMMENT '内容',
  `playurl` varchar(255) DEFAULT '' COMMENT '视频地址',
  `type` tinyint(1) DEFAULT '0' COMMENT '0直链，1解析',
  `pay` tinyint(1) DEFAULT '0' COMMENT '是否收费，0免费，1VIP，2金币',
  `cion` int(11) DEFAULT '0' COMMENT '需要金币',
  `zan` int(11) DEFAULT '0' COMMENT '被赞次数',
  `hits` int(11) DEFAULT '0' COMMENT '播放次数',
  `share` int(11) DEFAULT '0' COMMENT '分享次数',
  `md5` varchar(64) DEFAULT '' COMMENT '唯一ID',
  `yid` tinyint(1) DEFAULT '0' COMMENT '是否审核',
  `addtime` int(11) DEFAULT '0' COMMENT '发布时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `md5` (`md5`),
  KEY `uid` (`uid`),
  KEY `cid` (`cid`),
  KEY `type` (`type`),
  KEY `pay` (`pay`),
  KEY `addtime` (`addtime`),
  KEY `tid` (`tid`),
  KEY `hits` (`hits`),
  KEY `zan` (`zan`),
  KEY `yid` (`yid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='短视频记录';
DROP TABLE IF EXISTS `[dbprefix]myopia_class`;
CREATE TABLE `[dbprefix]myopia_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT '' COMMENT '分类名字',
  `xid` int(11) DEFAULT '0' COMMENT '排序ID',
  `yid` tinyint(1) DEFAULT '0' COMMENT '是否显示',
  PRIMARY KEY (`id`),
  KEY `yid` (`yid`),
  KEY `xid` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='短视频分类';
DROP TABLE IF EXISTS `[dbprefix]myopia_zan`;
CREATE TABLE `[dbprefix]myopia_zan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `did` int(11) DEFAULT '0' COMMENT '短视ID',
  `uid` int(11) DEFAULT '0' COMMENT '用户ID',
  `addtime` int(11) DEFAULT '0' COMMENT '时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `did_uid` (`did`,`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COMMENT='短视点赞';
DROP TABLE IF EXISTS `[dbprefix]user_fans`;
CREATE TABLE `[dbprefix]user_fans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0' COMMENT '用户ID',
  `fuid` int(11) DEFAULT '0' COMMENT '对象用户ID',
  `addtime` int(11) DEFAULT '0' COMMENT '发布时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fuid_uid` (`fuid`,`uid`),
  KEY `addtime` (`addtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='粉丝关注';
DROP TABLE IF EXISTS `[dbprefix]user_message`;
CREATE TABLE `[dbprefix]user_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0' COMMENT '用户ID',
  `fuid` int(11) DEFAULT '0' COMMENT '对象用户ID',
  `sid` tinyint(1) DEFAULT '0' COMMENT '类型：0系统，1长视频，2短视频，3帖子，4评论，5点赞',
  `did` int(11) DEFAULT '0' COMMENT '数据ID',
  `text` text COMMENT '内容',
  `look` tinyint(1) DEFAULT '0' COMMENT '是否已读',
  `addtime` int(11) DEFAULT '0' COMMENT '发布时间',
  PRIMARY KEY (`id`),
  KEY `sid` (`sid`),
  KEY `uid` (`uid`),
  KEY `fuid` (`fuid`),
  KEY `look` (`look`),
  KEY `addtime` (`addtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息通知'