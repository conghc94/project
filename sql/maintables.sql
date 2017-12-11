DROP TABLE IF EXISTS `base_of_members`;
CREATE TABLE IF NOT EXISTS `base_of_members` (
`id` int(11) NOT NULL,
  `published`  tinyint(4) DEFAULT NULL,
  `type`  tinyint(4) DEFAULT NULL,
  `profile_flag`  tinyint(4) DEFAULT NULL,
  `name` varchar(256) DEFAULT NULL,
  `name_kana` varchar(256) DEFAULT NULL,
  `name_eng` varchar(256) DEFAULT NULL,
  `description` varchar(4000) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `deleted_at` int(11) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE `base_of_members`
 ADD PRIMARY KEY (`id`);

 ALTER TABLE `base_of_members`
 MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;


DROP TABLE IF EXISTS `members`;
CREATE TABLE IF NOT EXISTS `members` (
`id` int(11) NOT NULL,
  `member_id`  int(11) DEFAULT NULL,
  `attendance_of_meeting`  tinyint(4) DEFAULT NULL,
  `proxy_of_meeting`  tinyint(4) DEFAULT NULL,
  `note` varchar(4000) DEFAULT NULL,
  `edited_history` TEXT DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `deleted_at` int(11) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE `members`
 ADD PRIMARY KEY (`id`);

 ALTER TABLE `members`
 MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `officers`;
CREATE TABLE IF NOT EXISTS `officers` (
`id` int(11) NOT NULL,
  `member_id`  int(11) DEFAULT NULL,
  `officer_in_group`  tinyint(4) DEFAULT NULL,
  `note` varchar(4000) DEFAULT NULL,
  `edited_history` TEXT DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `deleted_at` int(11) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE `officers`
 ADD PRIMARY KEY (`id`);

 ALTER TABLE `officers`
 MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `members_of_committees`;
CREATE TABLE IF NOT EXISTS `members_of_committees` (
`id` int(11) NOT NULL,
  `committee_id`  int(11) DEFAULT NULL,
  `member_id`  int(11) DEFAULT NULL,
  `officer_in_commitee` varchar(256) DEFAULT NULL,
  `request_of_cost`  tinyint(4) DEFAULT NULL,
  `receipt_of_cost`  tinyint(4) DEFAULT NULL,
  `cumstom_input01` TEXT DEFAULT NULL,
  `cumstom_input02` TEXT DEFAULT NULL,
  `cumstom_input03` TEXT DEFAULT NULL,
  `cumstom_input04` TEXT DEFAULT NULL,
  `cumstom_input05` TEXT DEFAULT NULL,
  `cumstom_input06` TEXT DEFAULT NULL,
  `cumstom_input07` TEXT DEFAULT NULL,
  `cumstom_input08` TEXT DEFAULT NULL,
  `cumstom_input09` TEXT DEFAULT NULL,
  `cumstom_input10` TEXT DEFAULT NULL,
  `cumstom_input11` TEXT DEFAULT NULL,
  `cumstom_input12` TEXT DEFAULT NULL,
  `cumstom_input13` TEXT DEFAULT NULL,
  `cumstom_input14` TEXT DEFAULT NULL,
  `cumstom_input15` TEXT DEFAULT NULL,
  `cumstom_input16` TEXT DEFAULT NULL,
  `cumstom_input17` TEXT DEFAULT NULL,
  `cumstom_input18` TEXT DEFAULT NULL,
  `cumstom_input19` TEXT DEFAULT NULL,
  `cumstom_input20` TEXT DEFAULT NULL,
  `note` TEXT DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `deleted_at` int(11) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE `members_of_committees`
 ADD PRIMARY KEY (`id`);

 ALTER TABLE `members_of_committees`
 MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;


DROP TABLE IF EXISTS `user_key_tables`;
CREATE TABLE IF NOT EXISTS `user_key_tables` (
`id` int(11) NOT NULL,
  `connect_type`  tinyint(4) DEFAULT NULL,
  `person_id`  int(11) DEFAULT NULL,
  `committee_id`  int(11) DEFAULT NULL,
  `member_id`  int(11) DEFAULT NULL,
  `sort_number`  tinyint(4) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `deleted_at` int(11) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE `user_key_tables`
 ADD PRIMARY KEY (`id`);

 ALTER TABLE `user_key_tables`
 MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `persons`;
CREATE TABLE IF NOT EXISTS `persons` (
`id` int(11) NOT NULL,
  `published`  tinyint(4) DEFAULT NULL,
  `department` varchar(256) DEFAULT NULL,
  `name` varchar(256) DEFAULT NULL,
  `name_kana` varchar(256) DEFAULT NULL,
  `email` varchar(256) DEFAULT NULL,
  `tel` varchar(256) DEFAULT NULL,
  `fax` varchar(256) DEFAULT NULL,
  `zip` varchar(256) DEFAULT NULL,
  `address01` varchar(256) DEFAULT NULL,
  `address02` varchar(256) DEFAULT NULL,
  `published_site_id`  tinyint(4) DEFAULT NULL,
  `type_of_ml` varchar(256) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `deleted_at` int(11) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE `persons`
 ADD PRIMARY KEY (`id`);

 ALTER TABLE `persons`
 MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `committees`;
CREATE TABLE IF NOT EXISTS `committees` (
`id` int(11) NOT NULL,
  `parent_committee_id`  int(11) DEFAULT NULL,
  `committee_name` varchar(256) DEFAULT NULL,
  `committee_name_kana` varchar(256) DEFAULT NULL,
  `committee_name_eng` varchar(256) DEFAULT NULL,
  `selectable_officer` varchar(256) DEFAULT NULL,
  `custom_input_name01` varchar(256) DEFAULT NULL,
  `custom_input_type01`  tinyint(4) DEFAULT NULL,
  `custom_input_selectable01` varchar(500) DEFAULT NULL,
  `custom_input_name02` varchar(256) DEFAULT NULL,
  `custom_input_type02`  tinyint(4) DEFAULT NULL,
  `custom_input_selectable02` varchar(500) DEFAULT NULL,
  `custom_input_name03` varchar(256) DEFAULT NULL,
  `custom_input_type03`  tinyint(4) DEFAULT NULL,
  `custom_input_selectable03` varchar(500) DEFAULT NULL,
  `custom_input_name04` varchar(256) DEFAULT NULL,
  `custom_input_type04`  tinyint(4) DEFAULT NULL,
  `custom_input_selectable04` varchar(500) DEFAULT NULL,
  `custom_input_name05` varchar(256) DEFAULT NULL,
  `custom_input_type05`  tinyint(4) DEFAULT NULL,
  `custom_input_selectable05` varchar(500) DEFAULT NULL,
  `custom_input_name06` varchar(256) DEFAULT NULL,
  `custom_input_type06`  tinyint(4) DEFAULT NULL,
  `custom_input_selectable06` varchar(500) DEFAULT NULL,
  `custom_input_name07` varchar(256) DEFAULT NULL,
  `custom_input_type07`  tinyint(4) DEFAULT NULL,
  `custom_input_selectable07` varchar(500) DEFAULT NULL,
  `custom_input_name08` varchar(256) DEFAULT NULL,
  `custom_input_type08`  tinyint(4) DEFAULT NULL,
  `custom_input_selectable08` varchar(500) DEFAULT NULL,
  `custom_input_name09` varchar(256) DEFAULT NULL,
  `custom_input_type09`  tinyint(4) DEFAULT NULL,
  `custom_input_selectable09` varchar(500) DEFAULT NULL,
  `custom_input_name10` varchar(256) DEFAULT NULL,
  `custom_input_type10`  tinyint(4) DEFAULT NULL,
  `custom_input_selectable10` varchar(500) DEFAULT NULL,
  `custom_input_name11` varchar(256) DEFAULT NULL,
  `custom_input_type11`  tinyint(4) DEFAULT NULL,
  `custom_input_selectable11` varchar(500) DEFAULT NULL,
  `custom_input_name12` varchar(256) DEFAULT NULL,
  `custom_input_type12`  tinyint(4) DEFAULT NULL,
  `custom_input_selectable12` varchar(500) DEFAULT NULL,
  `custom_input_name13` varchar(256) DEFAULT NULL,
  `custom_input_type13`  tinyint(4) DEFAULT NULL,
  `custom_input_selectable13` varchar(500) DEFAULT NULL,
  `custom_input_name14` varchar(256) DEFAULT NULL,
  `custom_input_type14`  tinyint(4) DEFAULT NULL,
  `custom_input_selectable14` varchar(500) DEFAULT NULL,
  `custom_input_name15` varchar(256) DEFAULT NULL,
  `custom_input_type15`  tinyint(4) DEFAULT NULL,
  `custom_input_selectable15` varchar(500) DEFAULT NULL,
  `custom_input_name16` varchar(256) DEFAULT NULL,
  `custom_input_type16`  tinyint(4) DEFAULT NULL,
  `custom_input_selectable16` varchar(500) DEFAULT NULL,
  `custom_input_name17` varchar(256) DEFAULT NULL,
  `custom_input_type17`  tinyint(4) DEFAULT NULL,
  `custom_input_selectable17` varchar(500) DEFAULT NULL,
  `custom_input_name18` varchar(256) DEFAULT NULL,
  `custom_input_type18`  tinyint(4) DEFAULT NULL,
  `custom_input_selectable18` varchar(500) DEFAULT NULL,
  `custom_input_name19` varchar(256) DEFAULT NULL,
  `custom_input_type19`  tinyint(4) DEFAULT NULL,
  `custom_input_selectable19` varchar(500) DEFAULT NULL,
  `custom_input_name20` varchar(256) DEFAULT NULL,
  `custom_input_type20`  tinyint(4) DEFAULT NULL,
  `custom_input_selectable20` varchar(500) DEFAULT NULL,
  `edited_history` TEXT DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `deleted_at` int(11) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE `committees`
 ADD PRIMARY KEY (`id`);

 ALTER TABLE `committees`
 MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;





