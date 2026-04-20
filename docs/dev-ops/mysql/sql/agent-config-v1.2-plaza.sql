-- Dynamic agent plaza extension (v1.2)
-- 增加“我的Agent/Agent广场”隔离所需字段

ALTER TABLE `ai_agent_config`
    ADD COLUMN `owner_user_id` VARCHAR(64) NOT NULL DEFAULT '' COMMENT 'agent owner user id' AFTER `operator`,
    ADD COLUMN `source_type` VARCHAR(16) NOT NULL DEFAULT 'USER' COMMENT 'USER|OFFICIAL' AFTER `owner_user_id`,
    ADD COLUMN `plaza_status` VARCHAR(16) NOT NULL DEFAULT 'OFF' COMMENT 'ON|OFF' AFTER `source_type`,
    ADD COLUMN `plaza_publish_time` DATETIME NULL COMMENT 'time when published to plaza' AFTER `plaza_status`;
UPDATE `ai_agent_config`
SET `owner_user_id` = CASE
    WHEN `owner_user_id` IS NULL OR `owner_user_id` = '' THEN `operator`
    ELSE `owner_user_id`
END;

UPDATE `ai_agent_config`
SET `source_type` = 'USER'
WHERE `source_type` IS NULL OR `source_type` = '';

UPDATE `ai_agent_config`
SET `plaza_status` = 'OFF'
WHERE `plaza_status` IS NULL OR `plaza_status` = '';

CREATE INDEX `idx_owner_user_id` ON `ai_agent_config` (`owner_user_id`);
CREATE INDEX `idx_source_plaza_status` ON `ai_agent_config` (`source_type`, `plaza_status`, `status`);
