CREATE TABLE IF NOT EXISTS `domainmetadata` (
`id` int(11) NOT NULL,
  `domain_id` int(11) NOT NULL,
  `kind` varchar(32) DEFAULT NULL,
  `content` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `domains` (
`id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `master` varchar(128) DEFAULT NULL,
  `last_check` int(11) DEFAULT NULL,
  `type` varchar(6) NOT NULL,
  `notified_serial` int(11) DEFAULT NULL,
  `account` varchar(40) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `records` (
`id` int(11) NOT NULL,
  `domain_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `content` varchar(64000) DEFAULT NULL,
  `ttl` int(11) DEFAULT NULL,
  `prio` int(11) DEFAULT NULL,
  `change_date` int(11) DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT '0',
  `ordername` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `auth` tinyint(1) DEFAULT '1',
  `ident` varchar(255) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

ALTER TABLE `domainmetadata`
 ADD PRIMARY KEY (`id`), ADD KEY `domainmetadata_idx` (`domain_id`,`kind`);

ALTER TABLE `domains`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `name_index` (`name`);

ALTER TABLE `records`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `ident` (`ident`), ADD KEY `nametype_index` (`name`,`type`), ADD KEY `domain_id` (`domain_id`), ADD KEY `recordorder` (`domain_id`,`ordername`);


ALTER TABLE `domainmetadata`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `domains`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `records`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;