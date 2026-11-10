# MES 制造执行系统

基于 **RuoYi v4.8.3**（Spring Boot 单体版）二次开发的制造执行系统课程设计项目，覆盖从销售订单、生产计划、工单、BOM、领料、工序任务、设备联动、生产报工、质量检验与追溯、入库到发货的业务闭环，并提供生产看板与基于 DeepSeek 的 AI 分析功能。

本仓库包含完整的后端源码、MySQL 数据库快照（`ry.sql`）、设备接口服务（.NET 8）以及开发过程中使用的 SQL 与辅助脚本。

---

## 功能模块

| 分类 | 主要内容 |
| :--- | :--- |
| 基础资料 | 产品、BOM、客户、设备、产线、工序设备映射 |
| 销售与计划 | 销售订单、生产计划、排程（Schedule） |
| 生产执行 | 工单、工单拆分、工序任务、领料、生产报工 |
| 库存与物流 | 库存、入库、发货记录 |
| 质量管理 | 质量记录、质量追溯、批次信息、缺陷记录 |
| 看板与智能 | 生产看板（Dashboard）、DeepSeek AI 分析、质量追溯页面 |
| 系统管理 | RuoYi 内置的用户、角色、菜单、字典、参数、通知、操作/登录日志、在线用户、定时任务、代码生成、服务与缓存监控 |

## 技术栈

| 层次 | 技术 |
| :--- | :--- |
| 后端框架 | RuoYi 4.8.3 / Spring Boot 4.0.3 / JDK 17 / Maven 多模块 |
| 持久层 | MyBatis + Druid 连接池 + MySQL + PageHelper 分页 |
| 权限与会话 | Apache Shiro 2.1.0（登录验证码、会话、菜单与按钮权限） |
| 页面 | Thymeleaf 模板 + Hplus(H+) 后台主题，服务端渲染 |
| 接口文档 | springdoc-openapi 3.0.2 |
| 设备接口 | ASP.NET Core 8（`MES.ProcessAPI`，端口 5000，可选） |
| AI 能力 | DeepSeek Chat Completions API（可选） |

## 目录结构

```text
.
├── README.md                  # 本说明
├── .gitignore
└── MES系统/
    ├── ry.sql                 # MySQL 完整库快照（schema: ry，60 张表，含初始化数据）
    └── MES/                   # RuoYi 工程根目录
        ├── pom.xml            # 父 POM，聚合 4 个模块
        ├── ruoyi-admin/       # Web 入口：Controller、Thymeleaf 页面、配置、静态资源
        ├── ruoyi-framework/   # 框架层：Shiro、拦截器、数据源、会话等
        ├── ruoyi-system/      # 系统管理业务
        ├── ruoyi-common/      # 通用工具类
        ├── sql/               # 开发过程中的增量/修复/备份 SQL 与 PDM 文件
        ├── MES.ProcessAPI/    # .NET 8 设备接口服务（可选）
        ├── src/               # 开发过程中的 Vue 页面与 API 片段（参考用，非独立前端工程）
        ├── bin/ · ry.bat · ry.sh   # 打包与启动脚本
        ├── README.md          # RuoYi 框架自带说明（官方原文）
        └── compile_and_patch.py · patch_jar.py · create_ppt.js   # 开发辅助脚本
```

> `ruoyi-admin/target/` 编译产物、日志、上传目录、本地工具配置均已由 `.gitignore` 排除，不在仓库中。

## 快速启动

### 1. 准备环境

- JDK 17+
- Maven 3.8+
- MySQL 8.0+（`ry.sql` 导出自 MySQL 9.6），本地 3306 可连接
- 可选：.NET 8 SDK（设备接口服务）、DeepSeek API Key（AI 分析功能）

### 2. 导入数据库

```sql
CREATE DATABASE IF NOT EXISTS ry DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE ry;
SOURCE ry.sql;   -- 或用 Navicat / 命令行客户端直接导入 MES系统/ry.sql
```

`ry.sql` 是**完整快照**：60 张表并附带菜单、字典、管理员账号等初始化数据，一次导入即可运行。`MES系统/MES/sql/` 下的脚本是开发过程中的增量建表、菜单修复与备份，**不需要重复执行**，仅在追溯变更或补充模块时参考。

### 3. 修改配置

`MES系统/MES/ruoyi-admin/src/main/resources/application-druid.yml`

- `master.url`：指向你的 MySQL，库名保持 `ry`
- `master.username` / `master.password`：改成你本地的账号（仓库内为示例值 `root` / `123456`）

`MES系统/MES/ruoyi-admin/src/main/resources/application.yml`

- `server.port`：默认 `8080`
- `ruoyi.profile`：文件上传目录，默认 `D:/mes/uploadPath`，非 Windows 环境需改为可写路径
- `mes.equipment.api.base-url`：设备接口地址，默认 `http://localhost:5000`
- `deepseek.api-key`：源码中已改为 `${DEEPSEEK_API_KEY:}`，通过环境变量注入；未配置时 AI 分析会提示"API Key 未配置"，其余功能不受影响

### 4. 构建与运行

```bash
cd "MES系统/MES"
mvn clean package -DskipTests
java -jar ruoyi-admin/target/ruoyi-admin.jar
```

Windows 下也可把构建出的 jar 放到 `ry.bat` 同目录，用 `ry.bat` 菜单启动 / 停止 / 重启 / 查看状态；Linux / macOS 可用 `ry.sh`。

浏览器访问 **http://localhost:8080**（登录页 `/login`）。默认管理员为 `admin`，RuoYi 默认口令 `admin123`；若导入的 `ry.sql` 中已修改口令，则以库内数据为准。

### 5. 可选：设备接口服务

```bash
cd "MES系统/MES/MES.ProcessAPI"
dotnet run
```

服务监听 `http://0.0.0.0:5000`，Swagger 位于 `/swagger`，`wwwroot/mes-console.html` 提供简易调试控制台，`ProcessController` 暴露设备启动、停止、抓取、固化、铺层等指令接口。不启动该服务时，设备联动相关功能不可用，主系统仍可正常运行。

### 6. 可选：启用 AI 分析

```bash
# Windows PowerShell
$env:DEEPSEEK_API_KEY = "sk-你的密钥"
# Linux / macOS
export DEEPSEEK_API_KEY=sk-你的密钥
```

在同一终端启动后端即可生效。密钥不写入源码，避免随公开仓库泄漏。

## 数据库表概览

`ry.sql` 共 60 张表，主要分为两类：

- **业务表**：`sales_order`、`production_plan`、`work_order`、`mes_work_order_split`、`mes_process_task`、`bom`、`product`、`customer`、`equipment`、`mes_production_line`、`process_route` / `process_step`、`mes_material_picking(_detail)`、`mes_process_report`、`production_report`、`inventory`、`mes_warehousing(_detail)`、`shipment_record`、`mes_quality_record` / `mes_quality_trace` / `mes_batch_info` / `mes_defect_record`、`mes_production_schedule`、`schedule`、`mes_process_equipment_mapping` 等。
- **系统表**：`sys_*`（用户、角色、菜单、字典、日志等）、`qrtz_*`（定时任务）、`gen_table*`（代码生成）。

## 开发辅助脚本

| 文件 | 用途 |
| :--- | :--- |
| `compile_and_patch.py` | 单文件编译后把 class 打进已构建的 jar，用于快速热修 |
| `patch_jar.py` | 针对指定 ServiceImpl 的 jar 补丁脚本 |
| `create_ppt.js` | 基于 pptxgenjs 生成项目答辩演示文稿 |
| `MES/sql/*.sql` | 增量表结构、菜单与数据修复脚本 |

注意：部分脚本内写死了原开发机路径（如 `d:/JAVA/MES`），换机使用时需改成自己的工程路径。

## 已知注意事项

- `application-druid.yml` 中是**示例数据库口令**和 Druid 监控台口令，部署到真实环境前请全部替换。
- DeepSeek API Key 不写入源码；历史提交中曾出现明文密钥，已通过重写提交历史清理。
- `MES/src/` 下的 `.vue` / `.js` 是开发过程中的页面与 API 片段，**实际运行页面**是 `ruoyi-admin/src/main/resources/templates/mes/` 下的 Thymeleaf 模板，不需要 `npm install`。
- 课设环境中的设备接口地址与上传路径为本地默认值，跨机器运行需按上文调整。

## 许可与致谢

- 业务代码为本课程设计实现；框架部分基于 [RuoYi v4.8.3](https://gitee.com/y_project/RuoYi)，遵循其 MIT 许可，详见 `MES系统/MES/LICENSE`。
- 框架官方文档：http://doc.ruoyi.vip
