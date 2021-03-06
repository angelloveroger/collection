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
  `fid` int(11) DEFAULT '0' COMMENT '??????ID',
  `name` varchar(64) DEFAULT '' COMMENT '??????',
  `xid` int(11) DEFAULT '0' COMMENT '??????',
  PRIMARY KEY (`id`),
  KEY `fid` (`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]comment`;
CREATE TABLE `[dbprefix]comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` int(11) DEFAULT '0' COMMENT '??????ID',
  `vid` int(11) DEFAULT '0' COMMENT '??????ID',
  `bid` int(11) DEFAULT '0' COMMENT '??????ID',
  `did` int(11) DEFAULT '0' COMMENT '??????ID',
  `uid` int(11) DEFAULT '0' COMMENT '??????ID',
  `text` varchar(255) DEFAULT '' COMMENT '??????',
  `zan` int(11) DEFAULT '0' COMMENT '????????????',
  `yid` tinyint(1) DEFAULT '0' COMMENT '0?????????1?????????',
  `addtime` int(11) DEFAULT '0' COMMENT '??????',
  PRIMARY KEY (`id`),
  KEY `fid` (`fid`),
  KEY `uid` (`uid`),
  KEY `yid` (`yid`),
  KEY `vid` (`vid`),
  KEY `bid` (`bid`),
  KEY `did` (`did`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='??????';
DROP TABLE IF EXISTS `[dbprefix]comment_report`;
CREATE TABLE `[dbprefix]comment_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0' COMMENT '??????ID',
  `did` int(11) DEFAULT '0' COMMENT '??????ID',
  `type` varchar(64) DEFAULT '',
  `text` varchar(255) DEFAULT '' COMMENT '????????????',
  `addtime` int(11) DEFAULT '0' COMMENT '??????',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `did` (`did`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='????????????';
DROP TABLE IF EXISTS `[dbprefix]comment_zan`;
CREATE TABLE `[dbprefix]comment_zan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `did` int(11) DEFAULT '0' COMMENT '??????ID',
  `uid` int(11) DEFAULT '0' COMMENT '??????ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `did_uid` (`did`,`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COMMENT='????????????';
DROP TABLE IF EXISTS `[dbprefix]down`;
CREATE TABLE `[dbprefix]down` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0',
  `vid` int(11) DEFAULT '0',
  `zid` int(11) DEFAULT '0',
  `jid` int(11) DEFAULT '0',
  `down_size` bigint(20) DEFAULT '0',
  `size` bigint(20) DEFAULT '0',
  `progress` decimal(6,2) DEFAULT '0.00' COMMENT '???????????????',
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
  `vid` int(11) DEFAULT '0' COMMENT '??????ID',
  `uid` int(11) DEFAULT '0' COMMENT '??????ID',
  `addtime` int(11) DEFAULT '0' COMMENT '????????????',
  PRIMARY KEY (`id`),
  KEY `vid` (`vid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='????????????';
DROP TABLE IF EXISTS `[dbprefix]feedback`;
CREATE TABLE `[dbprefix]feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0' COMMENT '??????ID',
  `type` varchar(128) DEFAULT '',
  `text` varchar(255) DEFAULT '' COMMENT '????????????',
  `reply_text` varchar(255) DEFAULT '' COMMENT '????????????',
  `reply_time` int(11) DEFAULT '0' COMMENT '????????????',
  `pics` text COMMENT '??????',
  `addtime` int(11) DEFAULT '0' COMMENT '????????????',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `reply_time` (`reply_time`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='????????????';
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
  `name` varchar(64) DEFAULT '' COMMENT '??????',
  `alias` varchar(64) DEFAULT '' COMMENT '??????',
  `text` varchar(255) DEFAULT '' COMMENT '??????',
  `jxurl` text COMMENT '????????????',
  `type` varchar(64) DEFAULT '' COMMENT '????????????',
  `yid` tinyint(1) DEFAULT '0' COMMENT '?????????1?????????',
  `xid` int(11) DEFAULT '0' COMMENT '??????ID',
  PRIMARY KEY (`id`),
  KEY `xid` (`xid`),
  KEY `yid` (`yid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='?????????';
DROP TABLE IF EXISTS `[dbprefix]star`;
CREATE TABLE `[dbprefix]star` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT '0' COMMENT '??????ID',
  `tid` tinyint(1) DEFAULT '0' COMMENT '???????????????0??????1???',
  `name` varchar(128) DEFAULT '' COMMENT '??????',
  `yname` varchar(128) DEFAULT '' COMMENT '?????????',
  `pic` varchar(255) DEFAULT '' COMMENT '????????????',
  `weight` varchar(64) DEFAULT '' COMMENT '??????',
  `height` varchar(64) DEFAULT '' COMMENT '??????',
  `alias` varchar(128) DEFAULT '' COMMENT '??????',
  `nationality` varchar(64) DEFAULT '' COMMENT '??????',
  `ethnic` varchar(64) DEFAULT '' COMMENT '??????',
  `professional` varchar(128) DEFAULT '' COMMENT '??????',
  `blood_type` varchar(20) DEFAULT '' COMMENT '??????',
  `birthday` varchar(30) DEFAULT '' COMMENT '??????',
  `city` varchar(64) DEFAULT '' COMMENT '??????',
  `constellation` varchar(20) DEFAULT '' COMMENT '??????',
  `company` varchar(128) DEFAULT '' COMMENT '????????????',
  `production` varchar(255) DEFAULT '' COMMENT '????????????',
  `academy` varchar(255) DEFAULT '' COMMENT '????????????',
  `text` text COMMENT '??????',
  `hits` int(11) DEFAULT '0' COMMENT '??????',
  `addtime` int(11) DEFAULT '0' COMMENT '????????????',
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
  `tid` int(11) DEFAULT '0' COMMENT '??????ID',
  `uid` int(11) DEFAULT '0' COMMENT '??????ID',
  `addtime` int(11) DEFAULT '0' COMMENT '????????????',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `tid` (`tid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='????????????';
DROP TABLE IF EXISTS `[dbprefix]user`;
CREATE TABLE `[dbprefix]user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aid` int(11) DEFAULT '0' COMMENT '??????ID',
  `fid` int(11) DEFAULT '0' COMMENT '?????????ID',
  `tel` varchar(20) DEFAULT '' COMMENT '?????????',
  `pass` varchar(64) DEFAULT '' COMMENT '??????',
  `nickname` varchar(64) DEFAULT '' COMMENT '??????',
  `pic` varchar(255) DEFAULT '' COMMENT '????????????',
  `sex` tinyint(1) DEFAULT '0',
  `vip` tinyint(1) DEFAULT '0' COMMENT '??????VIP',
  `viptime` int(11) DEFAULT '0',
  `cion` int(11) DEFAULT '0' COMMENT '??????',
  `qdnum` int(11) DEFAULT '0' COMMENT '????????????',
  `qdznum` int(11) DEFAULT '0' COMMENT '???????????????',
  `qddate` int(11) DEFAULT '0' COMMENT '????????????',
  `duration` int(11) DEFAULT '0' COMMENT '?????????????????????',
  `facility` varchar(30) DEFAULT '' COMMENT '??????',
  `deviceid` varchar(128) DEFAULT '' COMMENT '??????ID',
  `share_num` int(11) DEFAULT '0' COMMENT '??????????????????',
  `addtime` int(11) DEFAULT '0' COMMENT '????????????',
  `logtime` int(11) DEFAULT '0' COMMENT '????????????',
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
  `uid` int(11) DEFAULT '0' COMMENT '??????ID',
  `fid` int(11) DEFAULT '0' COMMENT '??????ID',
  `deviceid` varchar(64) DEFAULT '' COMMENT '??????id',
  `date` int(11) DEFAULT '0' COMMENT '????????????',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceid` (`deviceid`),
  KEY `uid` (`uid`),
  KEY `fid` (`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]user_card`;
CREATE TABLE `[dbprefix]user_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aid` int(11) DEFAULT '0' COMMENT '??????ID',
  `pass` varchar(128) DEFAULT '',
  `nums` int(11) DEFAULT '0',
  `rmb` decimal(8,2) DEFAULT '0.00',
  `type` tinyint(1) DEFAULT '1' COMMENT '1VIP???2??????',
  `uid` int(11) DEFAULT '0',
  `paytime` int(11) DEFAULT '0',
  `endtime` int(11) DEFAULT '0' COMMENT '????????????',
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
  `cid` tinyint(1) DEFAULT '1' COMMENT '1?????????2??????',
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
  `tel` varchar(20) DEFAULT '' COMMENT '?????????',
  `code` int(11) DEFAULT '0' COMMENT '?????????',
  `addtime` int(11) DEFAULT '0' COMMENT '????????????',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tel` (`tel`) USING BTREE,
  KEY `fid` (`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='???????????????';
DROP TABLE IF EXISTS `[dbprefix]user_ios`;
CREATE TABLE `[dbprefix]user_ios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0' COMMENT '??????ID',
  `fid` int(11) DEFAULT '0' COMMENT '??????ID',
  `deviceid` varchar(64) DEFAULT '' COMMENT '??????id',
  `date` int(11) DEFAULT '0' COMMENT '????????????',
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
  `aid` int(11) DEFAULT '0' COMMENT '??????ID',
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
  `type` varchar(64) DEFAULT '' COMMENT '??????',
  `name` varchar(64) DEFAULT '',
  `text` varchar(64) DEFAULT '',
  `day` int(1) DEFAULT '0' COMMENT '?????????????????????0?????????',
  `cion` int(11) DEFAULT '0' COMMENT '????????????????????????',
  `duration` int(11) DEFAULT '0' COMMENT '??????',
  `xid` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `xid` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]user_task_list`;
CREATE TABLE `[dbprefix]user_task_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0',
  `did` int(11) DEFAULT '0',
  `cion` int(11) DEFAULT '0' COMMENT '??????????????????',
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
  `cid` int(11) DEFAULT '0' COMMENT '??????ID',
  `reco` tinyint(1) DEFAULT '0' COMMENT '?????????????????????',
  `tid` tinyint(1) DEFAULT '0' COMMENT '????????????',
  `ztid` int(11) DEFAULT '0' COMMENT '??????ID',
  `name` varchar(255) DEFAULT '' COMMENT '??????',
  `pic` varchar(255) DEFAULT '' COMMENT '????????????',
  `picx` varchar(255) DEFAULT '' COMMENT '????????????',
  `director` varchar(255) DEFAULT '' COMMENT '??????',
  `actor` varchar(255) DEFAULT '' COMMENT '??????',
  `tags` varchar(255) DEFAULT '' COMMENT 'TAGS??????',
  `year` int(11) DEFAULT '2021' COMMENT '??????',
  `area` varchar(64) DEFAULT '' COMMENT '??????',
  `lang` varchar(34) DEFAULT '' COMMENT '??????',
  `state` varchar(64) DEFAULT '' COMMENT '??????',
  `score` decimal(4,1) DEFAULT '10.1' COMMENT '??????',
  `text` varchar(255) DEFAULT '' COMMENT '??????',
  `sohits` int(11) DEFAULT '0' COMMENT '????????????',
  `rhits` int(11) DEFAULT '0' COMMENT '?????????',
  `zhits` int(11) DEFAULT '0' COMMENT '?????????',
  `yhits` int(11) DEFAULT '0' COMMENT '?????????',
  `hits` int(11) DEFAULT '0' COMMENT '?????????',
  `shits` int(11) DEFAULT '0' COMMENT '????????????',
  `dhits` int(11) DEFAULT '0' COMMENT '????????????',
  `pay` tinyint(1) DEFAULT '0' COMMENT '0?????????1VIP???2??????',
  `app` tinyint(1) DEFAULT '0' COMMENT '??????APP?????????0???1???',
  `addtime` int(11) DEFAULT '0' COMMENT '????????????',
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
  `vid` int(11) DEFAULT '0' COMMENT '??????ID',
  `pid` int(11) DEFAULT '0' COMMENT '?????????ID',
  `zid` int(11) DEFAULT '0' COMMENT '???ID',
  `name` varchar(64) DEFAULT '' COMMENT '??????',
  `playurl` varchar(255) DEFAULT '' COMMENT '????????????',
  `xid` int(11) DEFAULT '0' COMMENT '??????ID',
  `pay` tinyint(1) DEFAULT '0' COMMENT '0?????????1VIP???2??????',
  `cion` int(11) DEFAULT '0' COMMENT '????????????',
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
  `vid` int(11) DEFAULT '0' COMMENT '??????ID',
  `pid` int(11) DEFAULT '0' COMMENT '?????????ID',
  `xid` int(11) DEFAULT '0' COMMENT '??????ID',
  PRIMARY KEY (`id`),
  KEY `vid` (`vid`),
  KEY `pid` (`pid`),
  KEY `xid` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `[dbprefix]watch`;
CREATE TABLE `[dbprefix]watch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '??????ID',
  `cid` int(11) DEFAULT '0',
  `vid` int(11) DEFAULT '0' COMMENT '??????ID',
  `zid` int(11) DEFAULT '0' COMMENT '???ID',
  `jid` int(11) DEFAULT '0' COMMENT '??????ID',
  `duration` decimal(8,2) DEFAULT '0.00' COMMENT '????????????',
  `addtime` int(11) DEFAULT '0' COMMENT '????????????',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_vid_zid_jid` (`uid`,`vid`,`zid`,`jid`),
  KEY `uid` (`uid`),
  KEY `addtime` (`addtime`),
  KEY `cid` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='????????????';
DROP TABLE IF EXISTS `[dbprefix]bbs`;
CREATE TABLE `[dbprefix]bbs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '??????ID',
  `cid` int(11) DEFAULT '0' COMMENT '??????ID',
  `ding` tinyint(1) DEFAULT '0' COMMENT '????????????',
  `reco` tinyint(1) DEFAULT '0' COMMENT '????????????',
  `name` varchar(128) DEFAULT '' COMMENT '??????',
  `text` text COMMENT '??????',
  `zan` int(11) DEFAULT '0' COMMENT '????????????',
  `hits` int(11) DEFAULT '0' COMMENT '????????????',
  `yid` tinyint(1) DEFAULT '0' COMMENT '????????????',
  `addtime` int(11) DEFAULT '0' COMMENT '????????????',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `cid` (`cid`),
  KEY `addtime` (`addtime`),
  KEY `ding` (`ding`),
  KEY `reco` (`reco`),
  KEY `zan` (`zan`),
  KEY `hits` (`hits`),
  KEY `yid` (`yid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='????????????';
DROP TABLE IF EXISTS `[dbprefix]bbs_pic`;
CREATE TABLE `[dbprefix]bbs_pic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '??????ID',
  `bid` int(11) DEFAULT '0' COMMENT '??????ID',
  `url` varchar(255) DEFAULT '' COMMENT '????????????',
  `addtime` int(11) DEFAULT '0' COMMENT '????????????',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `bid` (`bid`),
  KEY `addtime` (`addtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='??????????????????';
DROP TABLE IF EXISTS `[dbprefix]bbs_class`;
CREATE TABLE `[dbprefix]bbs_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT '' COMMENT '????????????',
  `pic` varchar(255) DEFAULT '' COMMENT '????????????',
  `yid` tinyint(1) DEFAULT '0' COMMENT '????????????',
  `xid` int(11) DEFAULT '0' COMMENT '??????ID',
  PRIMARY KEY (`id`),
  KEY `yid` (`yid`),
  KEY `xid` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='??????????????????';
DROP TABLE IF EXISTS `[dbprefix]bbs_zan`;
CREATE TABLE `[dbprefix]bbs_zan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `did` int(11) DEFAULT '0' COMMENT '??????ID',
  `uid` int(11) DEFAULT '0' COMMENT '??????ID',
  `addtime` int(11) DEFAULT '0' COMMENT '??????',
  PRIMARY KEY (`id`),
  UNIQUE KEY `did_uid` (`did`,`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COMMENT='????????????';
DROP TABLE IF EXISTS `[dbprefix]myopia`;
CREATE TABLE `[dbprefix]myopia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0' COMMENT '??????ID',
  `nickname` varchar(64) DEFAULT '' COMMENT '????????????',
  `upic` varchar(255) DEFAULT '' COMMENT '????????????',
  `cid` int(11) DEFAULT '0' COMMENT '??????ID',
  `tid` tinyint(1) DEFAULT '0' COMMENT '????????????',
  `pic` varchar(255) DEFAULT '' COMMENT '????????????',
  `text` varchar(255) DEFAULT '' COMMENT '??????',
  `playurl` varchar(255) DEFAULT '' COMMENT '????????????',
  `type` tinyint(1) DEFAULT '0' COMMENT '0?????????1??????',
  `pay` tinyint(1) DEFAULT '0' COMMENT '???????????????0?????????1VIP???2??????',
  `cion` int(11) DEFAULT '0' COMMENT '????????????',
  `zan` int(11) DEFAULT '0' COMMENT '????????????',
  `hits` int(11) DEFAULT '0' COMMENT '????????????',
  `share` int(11) DEFAULT '0' COMMENT '????????????',
  `md5` varchar(64) DEFAULT '' COMMENT '??????ID',
  `yid` tinyint(1) DEFAULT '0' COMMENT '????????????',
  `addtime` int(11) DEFAULT '0' COMMENT '????????????',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='???????????????';
DROP TABLE IF EXISTS `[dbprefix]myopia_class`;
CREATE TABLE `[dbprefix]myopia_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT '' COMMENT '????????????',
  `xid` int(11) DEFAULT '0' COMMENT '??????ID',
  `yid` tinyint(1) DEFAULT '0' COMMENT '????????????',
  PRIMARY KEY (`id`),
  KEY `yid` (`yid`),
  KEY `xid` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='???????????????';
DROP TABLE IF EXISTS `[dbprefix]myopia_zan`;
CREATE TABLE `[dbprefix]myopia_zan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `did` int(11) DEFAULT '0' COMMENT '??????ID',
  `uid` int(11) DEFAULT '0' COMMENT '??????ID',
  `addtime` int(11) DEFAULT '0' COMMENT '??????',
  PRIMARY KEY (`id`),
  UNIQUE KEY `did_uid` (`did`,`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COMMENT='????????????';
DROP TABLE IF EXISTS `[dbprefix]user_fans`;
CREATE TABLE `[dbprefix]user_fans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0' COMMENT '??????ID',
  `fuid` int(11) DEFAULT '0' COMMENT '????????????ID',
  `addtime` int(11) DEFAULT '0' COMMENT '????????????',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fuid_uid` (`fuid`,`uid`),
  KEY `addtime` (`addtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='????????????';
DROP TABLE IF EXISTS `[dbprefix]user_message`;
CREATE TABLE `[dbprefix]user_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0' COMMENT '??????ID',
  `fuid` int(11) DEFAULT '0' COMMENT '????????????ID',
  `sid` tinyint(1) DEFAULT '0' COMMENT '?????????0?????????1????????????2????????????3?????????4?????????5??????',
  `did` int(11) DEFAULT '0' COMMENT '??????ID',
  `text` text COMMENT '??????',
  `look` tinyint(1) DEFAULT '0' COMMENT '????????????',
  `addtime` int(11) DEFAULT '0' COMMENT '????????????',
  PRIMARY KEY (`id`),
  KEY `sid` (`sid`),
  KEY `uid` (`uid`),
  KEY `fuid` (`fuid`),
  KEY `look` (`look`),
  KEY `addtime` (`addtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='????????????'