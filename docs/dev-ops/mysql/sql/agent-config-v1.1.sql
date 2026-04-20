-- Dynamic agent configuration tables (v1.1)
-- MySQL 8+
SELECT VERSION();

CREATE TABLE IF NOT EXISTS `ai_agent_config` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'pk',
    `agent_id` VARCHAR(64) NOT NULL COMMENT 'business agent id',
    `app_name` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'app name',
    `agent_name` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'agent display name',
    `agent_desc` VARCHAR(512) NOT NULL DEFAULT '' COMMENT 'agent description',
    `config_json` LONGTEXT NOT NULL COMMENT 'full serialized config payload',
    `status` VARCHAR(16) NOT NULL DEFAULT 'DRAFT' COMMENT 'DRAFT|PUBLISHED|OFFLINE',
    `current_version` BIGINT NOT NULL DEFAULT 1 COMMENT 'latest edit version',
    `published_version` BIGINT DEFAULT NULL COMMENT 'currently active runtime version',
    `operator` VARCHAR(64) NOT NULL DEFAULT '' COMMENT 'last operator',
    `owner_user_id` VARCHAR(64) NOT NULL DEFAULT '' COMMENT 'agent owner user id',
    `source_type` VARCHAR(16) NOT NULL DEFAULT 'USER' COMMENT 'USER|OFFICIAL',
    `plaza_status` VARCHAR(16) NOT NULL DEFAULT 'OFF' COMMENT 'ON|OFF',
    `plaza_publish_time` DATETIME DEFAULT NULL COMMENT 'time when published to plaza',
    `is_deleted` TINYINT NOT NULL DEFAULT 0 COMMENT 'soft delete',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uniq_agent_id` (`agent_id`),
    KEY `idx_status` (`status`),
    KEY `idx_owner_user_id` (`owner_user_id`),
    KEY `idx_source_plaza_status` (`source_type`, `plaza_status`, `status`),
    KEY `idx_update_time` (`update_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='dynamic agent config current';

CREATE TABLE IF NOT EXISTS `ai_agent_config_version` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'pk',
    `agent_id` VARCHAR(64) NOT NULL COMMENT 'business agent id',
    `version` BIGINT NOT NULL COMMENT 'snapshot version',
    `status` VARCHAR(16) NOT NULL DEFAULT 'DRAFT' COMMENT 'status at snapshot time',
    `config_json` LONGTEXT NOT NULL COMMENT 'snapshot payload',
    `operator` VARCHAR(64) NOT NULL DEFAULT '' COMMENT 'operator',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uniq_agent_version` (`agent_id`, `version`),
    KEY `idx_agent_id` (`agent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='dynamic agent config version history';

CREATE TABLE IF NOT EXISTS `ai_agent_session_bind` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'pk',
    `session_id` VARCHAR(128) NOT NULL COMMENT 'chat session id',
    `agent_id` VARCHAR(64) NOT NULL COMMENT 'business agent id',
    `config_version` BIGINT NOT NULL COMMENT 'runtime config version for this session',
    `user_id` VARCHAR(64) NOT NULL DEFAULT '' COMMENT 'user id',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uniq_session_id` (`session_id`),
    KEY `idx_agent_version` (`agent_id`, `config_version`),
    KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='session to config-version binding';
