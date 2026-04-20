# AI Agent 脚手架（agent-scaffold-lite）

一个基于 Java + Spring + DDD 的 AI Agent 开发脚手架，支持通过 YML 配置 Agent、工作流编排与插件扩展，适合快速搭建多 Agent 场景应用。

## 项目能力

- YML 配置化 Agent（模型、提示词、工具、工作流）
- 支持多种编排模式：`sequential` / `parallel` / `loop` / `supervisor`
- 提供标准 HTTP 接口：`chat` / `chat_stream`
- 插件机制（日志、监控、自定义扩展）

## v1.1 更新（简略）

v1.1 重点引入 Supervisor 动态路由能力和标准化流式事件：

- 新增 `SupervisorRoutingAgent`，支持主 Agent 根据上下文动态选择子 Agent
- `chat_stream` 支持 `thinking / route / reply / final` 事件类型
- 支持主 Agent 阶段性回复与最终回复的流式输出

详细内容请查看：

- [v1.1 详细更新日志](./docs/changelog/v1.1.md)

## 目录建议

- `agent-scaffold-lite-app`：应用与配置
- `agent-scaffold-lite-domain`：领域与工作流编排
- `agent-scaffold-lite-trigger`：HTTP 触发层（含 SSE）
- `agent-scaffold-lite-api`：接口与 DTO
- `agent-scaffold-lite-types`：通用类型与常量

## License

按项目实际 License 文件为准。
