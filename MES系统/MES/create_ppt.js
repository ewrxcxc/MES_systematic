const pptxgen = require("pptxgenjs");
const fs = require("fs");

const pres = new pptxgen();
pres.layout = "LAYOUT_16x9";
pres.author = "MES Team";
pres.title = "MES制造执行系统";

// Color palette - Industrial Steel
const C = {
  navy:      "1B2A4A",
  steel:     "0F4C81",
  teal:      "00A896",
  lightBg:   "F0F4F8",
  white:     "FFFFFF",
  dark:      "121926",
  gray:      "64748B",
  lightGray: "CBD5E1",
  accent:    "F59E0B",
  red:       "EF4444",
  green:     "10B981",
};

// Helper: make shadow factory to avoid reuse bug
const mkShadow = () => ({ type: "outer", color: "000000", blur: 6, offset: 2, angle: 135, opacity: 0.10 });

// ==================== SLIDE 1: Title ====================
let s1 = pres.addSlide();
s1.background = { color: C.navy };
// Decorative shapes
s1.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.08, fill: { color: C.teal } });
s1.addShape(pres.shapes.RECTANGLE, { x: 0, y: 5.545, w: 10, h: 0.08, fill: { color: C.teal } });
// Large accent circle
s1.addShape(pres.shapes.OVAL, { x: 7.2, y: 0.8, w: 4.5, h: 4.5, fill: { color: C.steel, transparency: 70 } });
// Title
s1.addText("MES 制造执行系统", {
  x: 0.8, y: 1.2, w: 8, h: 1.2, fontSize: 44, fontFace: "Arial Black",
  color: C.white, bold: true, margin: 0
});
// Subtitle
s1.addText("Manufacturing Execution System", {
  x: 0.8, y: 2.4, w: 8, h: 0.6, fontSize: 18, fontFace: "Calibri",
  color: C.lightGray, margin: 0
});
// Tagline
s1.addText("智能制造 · 数据驱动 · 全链路追溯", {
  x: 0.8, y: 3.3, w: 8, h: 0.5, fontSize: 16, fontFace: "Calibri",
  color: C.teal, margin: 0
});
// Divider line
s1.addShape(pres.shapes.LINE, { x: 0.8, y: 3.9, w: 2.5, h: 0, line: { color: C.teal, width: 2 } });
// Bottom info
s1.addText([
  { text: "Spring Boot + MyBatis + Thymeleaf + ECharts + DeepSeek AI", options: { fontSize: 12, color: C.gray } }
], { x: 0.8, y: 4.5, w: 8, h: 0.4, margin: 0 });

// ==================== SLIDE 2: 系统概述 ====================
let s2 = pres.addSlide();
s2.background = { color: C.lightBg };
// Top bar
s2.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.06, fill: { color: C.teal } });
s2.addText("系统概述", { x: 0.6, y: 0.3, w: 9, h: 0.7, fontSize: 32, fontFace: "Arial Black", color: C.dark, bold: true, margin: 0 });

// Left: description
s2.addText([
  { text: "MES制造执行系统", options: { bold: true, fontSize: 18, color: C.steel, breakLine: true } },
  { text: "", options: { fontSize: 10, breakLine: true } },
  { text: "基于RuoYi-Vue框架构建，面向中小型制造企业的生产管理平台。", options: { fontSize: 14, color: C.dark, breakLine: true } },
  { text: "", options: { fontSize: 10, breakLine: true } },
  { text: "覆盖从销售订单到产品发货的全业务流程，实现生产数据实时监控、质量全链路追溯、AI智能分析辅助决策。", options: { fontSize: 14, color: C.dark } }
], { x: 0.6, y: 1.3, w: 5.2, h: 2.5, valign: "top", margin: 0 });

// Right: key stats cards
const stats = [
  { num: "15+", label: "功能模块" },
  { num: "7步", label: "标准工序流程" },
  { num: "100%", label: "真实数据驱动" },
  { num: "AI", label: "智能分析引擎" }
];
stats.forEach((st, i) => {
  let x = 6.2 + (i % 2) * 1.85;
  let y = 1.3 + Math.floor(i / 2) * 1.7;
  s2.addShape(pres.shapes.RECTANGLE, {
    x: x, y: y, w: 1.65, h: 1.5,
    fill: { color: C.white }, shadow: mkShadow()
  });
  s2.addText(st.num, { x: x, y: y + 0.25, w: 1.65, h: 0.6, fontSize: 26, fontFace: "Arial Black", color: C.teal, align: "center", bold: true, margin: 0 });
  s2.addText(st.label, { x: x, y: y + 0.9, w: 1.65, h: 0.4, fontSize: 11, color: C.gray, align: "center", margin: 0 });
});

// Bottom: tech stack tags
s2.addText("技术栈", { x: 0.6, y: 4.1, w: 2, h: 0.4, fontSize: 14, fontFace: "Arial Black", color: C.steel, bold: true, margin: 0 });
const tags = ["Spring Boot 4.0", "MyBatis", "Apache Shiro", "Thymeleaf", "Bootstrap 3", "jQuery", "ECharts 5", "MySQL 8", "DeepSeek API"];
let tagX = 0.6;
tags.forEach(t => {
  s2.addShape(pres.shapes.RECTANGLE, { x: tagX, y: 4.6, w: 1.55, h: 0.4, fill: { color: C.white } });
  s2.addText(t, { x: tagX, y: 4.6, w: 1.55, h: 0.4, fontSize: 10, color: C.steel, align: "center", valign: "middle", margin: 0 });
  tagX += 1.65;
});

// ==================== SLIDE 3: 核心模块全景 ====================
let s3 = pres.addSlide();
s3.background = { color: C.lightBg };
s3.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.06, fill: { color: C.teal } });
s3.addText("核心模块全景", { x: 0.6, y: 0.3, w: 9, h: 0.7, fontSize: 32, fontFace: "Arial Black", color: C.dark, bold: true, margin: 0 });

const modules = [
  { icon: "📋", name: "销售订单", desc: "订单录入、状态追踪、交期管理" },
  { icon: "🏭", name: "工单中心", desc: "生产工单生成、派发、进度跟踪" },
  { icon: "⚙️", name: "工序任务", desc: "7步标准工序，逐级流转" },
  { icon: "📊", name: "生产报工", desc: "报工录入、质检一体化" },
  { icon: "🔍", name: "质量追溯", desc: "SO→WO→工序→质检全链路" },
  { icon: "📦", name: "入库管理", desc: "完工入库、库存同步" },
  { icon: "🚚", name: "发货管理", desc: "发货记录、物流追踪" },
  { icon: "🖥️", name: "设备管理", desc: "设备监控、工序设备映射" },
  { icon: "🤖", name: "AI分析", desc: "DeepSeek智能生产分析" },
  { icon: "📈", name: "生产看板", desc: "ECharts实时数据可视化" },
];

modules.forEach((m, i) => {
  let col = i % 5;
  let row = Math.floor(i / 5);
  let x = 0.4 + col * 1.88;
  let y = 1.2 + row * 2.1;
  s3.addShape(pres.shapes.RECTANGLE, { x: x, y: y, w: 1.72, h: 1.85, fill: { color: C.white }, shadow: mkShadow() });
  s3.addText(m.icon, { x: x, y: y + 0.15, w: 1.72, h: 0.55, fontSize: 28, align: "center", margin: 0 });
  s3.addText(m.name, { x: x + 0.1, y: y + 0.7, w: 1.52, h: 0.4, fontSize: 13, fontFace: "Arial Black", color: C.steel, align: "center", margin: 0 });
  s3.addText(m.desc, { x: x + 0.1, y: y + 1.1, w: 1.52, h: 0.6, fontSize: 9.5, color: C.gray, align: "center", margin: 0 });
});

// ==================== SLIDE 4: 生产管理流程 ====================
let s4 = pres.addSlide();
s4.background = { color: C.lightBg };
s4.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.06, fill: { color: C.teal } });
s4.addText("生产管理流程", { x: 0.6, y: 0.3, w: 9, h: 0.7, fontSize: 32, fontFace: "Arial Black", color: C.dark, bold: true, margin: 0 });

// Flow: SO → Plan → WO → Process → Report → QC → Warehouse → Ship
const steps = [
  { name: "销售订单", sub: "SO" },
  { name: "生产计划", sub: "Plan" },
  { name: "工单生成", sub: "WO" },
  { name: "工序执行", sub: "7 Steps" },
  { name: "生产报工", sub: "Report" },
  { name: "质量检验", sub: "QC" },
  { name: "入库管理", sub: "Store" },
  { name: "发货出库", sub: "Ship" },
];

// Flow arrows
const startX = 0.3, stepW = 1.08, gap = 0.12;
steps.forEach((s, i) => {
  let x = startX + i * (stepW + gap);
  let isEven = i % 2 === 0;
  let yMain = 1.6;
  s4.addShape(pres.shapes.RECTANGLE, {
    x: x, y: yMain, w: stepW, h: 1.5, fill: { color: isEven ? C.steel : C.teal }, shadow: mkShadow()
  });
  s4.addText(s.sub, { x: x, y: yMain + 0.15, w: stepW, h: 0.5, fontSize: 18, fontFace: "Arial Black", color: C.white, align: "center", bold: true, margin: 0 });
  s4.addText(s.name, { x: x, y: yMain + 0.7, w: stepW, h: 0.5, fontSize: 12, color: C.white, align: "center", margin: 0 });
  // Arrow (except last)
  if (i < steps.length - 1) {
    s4.addText("▶", { x: x + stepW, y: yMain + 0.35, w: gap, h: 0.6, fontSize: 12, color: C.gray, align: "center", margin: 0 });
  }
});

// Bottom detail cards
const details = [
  { title: "工序标准化", desc: "7步工序模板：领料→CNC加工→打磨→喷砂氧化→组装→功能检测→包装入库" },
  { title: "报工质检一体化", desc: "报工即录入良品/不良品数量，支持在线质检(PASS/FAIL)，状态自动流转" },
  { title: "数据全链路贯通", desc: "销售订单→工单→工序→报工→质检→设备，六层数据关联查询" },
];
details.forEach((d, i) => {
  let x = 0.4 + i * 3.15;
  s4.addShape(pres.shapes.RECTANGLE, { x: x, y: 3.5, w: 3.0, h: 1.8, fill: { color: C.white }, shadow: mkShadow() });
  s4.addShape(pres.shapes.RECTANGLE, { x: x, y: 3.5, w: 0.06, h: 1.8, fill: { color: C.teal } });
  s4.addText(d.title, { x: x + 0.25, y: 3.65, w: 2.6, h: 0.4, fontSize: 15, fontFace: "Arial Black", color: C.dark, margin: 0 });
  s4.addText(d.desc, { x: x + 0.25, y: 4.15, w: 2.6, h: 0.9, fontSize: 12, color: C.gray, margin: 0 });
});

// ==================== SLIDE 5: 质量追溯 ====================
let s5 = pres.addSlide();
s5.background = { color: C.navy };
s5.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.06, fill: { color: C.teal } });
s5.addText("质量全链路追溯", { x: 0.6, y: 0.3, w: 9, h: 0.7, fontSize: 32, fontFace: "Arial Black", color: C.white, bold: true, margin: 0 });
s5.addText("SO → 工单 → 工序执行 → 质检记录 → 设备信息 → 全链路可查", {
  x: 0.6, y: 1.0, w: 9, h: 0.4, fontSize: 13, color: C.lightGray, margin: 0
});

// Data chain visualization
const chain = [
  { label: "SALES\nORDER", color: C.teal },
  { label: "WORK\nORDER", color: C.steel },
  { label: "PROCESS\nTASK", color: C.accent },
  { label: "QUALITY\nRECORD", color: C.green },
  { label: "EQUIP\nMENT", color: C.red },
];
chain.forEach((c, i) => {
  let x = 0.5 + i * 1.85;
  s5.addShape(pres.shapes.RECTANGLE, { x: x, y: 1.7, w: 1.6, h: 1.4, fill: { color: c.color }, shadow: mkShadow() });
  s5.addText(c.label, { x: x, y: 1.9, w: 1.6, h: 1.0, fontSize: 16, fontFace: "Arial Black", color: C.white, align: "center", valign: "middle", bold: true, margin: 0 });
  if (i < chain.length - 1) {
    s5.addText("→", { x: x + 1.55, y: 2.0, w: 0.35, h: 0.7, fontSize: 20, color: C.white, align: "center", valign: "middle", margin: 0 });
  }
});

// Feature cards
const features = [
  { title: "多入口追溯", desc: "支持按订单号、工单号、产品ID、批次号多种方式精确追溯" },
  { title: "跨表关联查询", desc: "一条SQL JOIN 7张表，真实数据链路，无Mock数据" },
  { title: "设备信息联动", desc: "工序→设备映射表自动维护，每道工序显示对应设备" },
  { title: "质检结果展示", desc: "关联mes_quality_record表，实时展示PASS/FAIL结果" },
];
features.forEach((f, i) => {
  let x = 0.4 + i * 2.4;
  s5.addShape(pres.shapes.RECTANGLE, { x: x, y: 3.5, w: 2.25, h: 1.75, fill: { color: C.steel, transparency: 40 } });
  s5.addText(f.title, { x: x + 0.15, y: 3.65, w: 1.95, h: 0.4, fontSize: 14, fontFace: "Arial Black", color: C.teal, margin: 0 });
  s5.addText(f.desc, { x: x + 0.15, y: 4.1, w: 1.95, h: 0.9, fontSize: 11, color: C.lightGray, margin: 0 });
});

// ==================== SLIDE 6: AI智能分析 ====================
let s6 = pres.addSlide();
s6.background = { color: C.lightBg };
s6.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.06, fill: { color: C.teal } });
s6.addText("AI 智能分析", { x: 0.6, y: 0.3, w: 9, h: 0.7, fontSize: 32, fontFace: "Arial Black", color: C.dark, bold: true, margin: 0 });

// Left: description
s6.addShape(pres.shapes.RECTANGLE, { x: 0.5, y: 1.2, w: 4.5, h: 3.8, fill: { color: C.white }, shadow: mkShadow() });
s6.addShape(pres.shapes.RECTANGLE, { x: 0.5, y: 1.2, w: 4.5, h: 0.06, fill: { color: C.teal } });
s6.addText("DeepSeek 驱动", { x: 0.7, y: 1.4, w: 4, h: 0.4, fontSize: 18, fontFace: "Arial Black", color: C.steel, margin: 0 });
s6.addText([
  { text: "AI分析工作流程：", options: { bold: true, fontSize: 13, color: C.dark, breakLine: true } },
  { text: "", options: { fontSize: 8, breakLine: true } },
  { text: "1. 选择销售订单", options: { fontSize: 12, color: C.dark, breakLine: true } },
  { text: "2. 系统自动聚合工单、工序、质检、设备数据", options: { fontSize: 12, color: C.dark, breakLine: true } },
  { text: "3. 构建结构化Prompt（Markdown表格）", options: { fontSize: 12, color: C.dark, breakLine: true } },
  { text: "4. 调用DeepSeek API生成分析报告", options: { fontSize: 12, color: C.dark, breakLine: true } },
  { text: "5. 返回：进度分析/瓶颈识别/质量风险/改进建议", options: { fontSize: 12, color: C.dark, breakLine: true } },
  { text: "", options: { fontSize: 8, breakLine: true } },
  { text: "特点：纯只读分析，不写入任何业务数据", options: { fontSize: 12, color: C.teal, italic: true } },
], { x: 0.7, y: 1.9, w: 4.1, h: 3, valign: "top", margin: 0 });

// Right: analysis dimensions
s6.addText("分析维度", { x: 5.5, y: 1.2, w: 4, h: 0.4, fontSize: 18, fontFace: "Arial Black", color: C.steel, margin: 0 });
const dims = [
  { icon: "📊", title: "生产进度", desc: "整体完成率、各工单对比" },
  { icon: "⚠️", title: "瓶颈识别", desc: "耗时最长工序、等待队列" },
  { icon: "✅", title: "质量风险", desc: "合格率趋势、NG原因归因" },
  { icon: "🔧", title: "设备负载", desc: "设备使用率、异常分析" },
  { icon: "💡", title: "改进建议", desc: "可执行的优化方案" },
];
dims.forEach((d, i) => {
  let y = 1.8 + i * 0.78;
  s6.addShape(pres.shapes.RECTANGLE, { x: 5.5, y: y, w: 4.1, h: 0.65, fill: { color: C.white }, shadow: mkShadow() });
  s6.addText(d.icon + "  " + d.title, { x: 5.7, y: y + 0.02, w: 3.7, h: 0.3, fontSize: 13, fontFace: "Arial Black", color: C.dark, margin: 0 });
  s6.addText(d.desc, { x: 5.7, y: y + 0.32, w: 3.7, h: 0.25, fontSize: 10, color: C.gray, margin: 0 });
});

// ==================== SLIDE 7: 生产看板 ====================
let s7 = pres.addSlide();
s7.background = { color: C.lightBg };
s7.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.06, fill: { color: C.teal } });
s7.addText("生产数据看板", { x: 0.6, y: 0.3, w: 9, h: 0.7, fontSize: 32, fontFace: "Arial Black", color: C.dark, bold: true, margin: 0 });

// KPI cards
const kpis = [
  { num: "实时", label: "数据刷新", color: C.teal },
  { num: "6", label: "统计指标", color: C.steel },
  { num: "4", label: "可视化图表", color: C.accent },
  { num: "7天", label: "趋势分析", color: C.green },
];
kpis.forEach((k, i) => {
  let x = 0.4 + i * 2.4;
  s7.addShape(pres.shapes.RECTANGLE, { x: x, y: 1.2, w: 2.2, h: 1.1, fill: { color: C.white }, shadow: mkShadow() });
  s7.addText(k.num, { x: x, y: 1.3, w: 2.2, h: 0.5, fontSize: 28, fontFace: "Arial Black", color: k.color, align: "center", bold: true, margin: 0 });
  s7.addText(k.label, { x: x, y: 1.8, w: 2.2, h: 0.3, fontSize: 12, color: C.gray, align: "center", margin: 0 });
});

// Chart mockups
const charts = [
  { title: "工单状态分布", type: "饼图" },
  { title: "产量趋势 (7天)", type: "折线图" },
  { title: "设备状态占比", type: "环形图" },
  { title: "工单趋势", type: "柱状图" },
];
charts.forEach((c, i) => {
  let x = 0.4 + i * 2.4;
  s7.addShape(pres.shapes.RECTANGLE, { x: x, y: 2.6, w: 2.2, h: 2.2, fill: { color: C.white }, shadow: mkShadow() });
  s7.addText(c.title, { x: x + 0.1, y: 2.7, w: 2.0, h: 0.35, fontSize: 13, fontFace: "Arial Black", color: C.dark, margin: 0 });
  // Chart placeholder
  s7.addShape(pres.shapes.RECTANGLE, { x: x + 0.25, y: 3.2, w: 1.7, h: 1.4, fill: { color: C.lightBg } });
  s7.addText(c.type, { x: x + 0.25, y: 3.8, w: 1.7, h: 0.4, fontSize: 11, color: C.gray, align: "center", margin: 0 });
});

// Stack info
s7.addText("技术实现：ECharts 5 + AJAX实时请求 + Bootstrap响应式布局", {
  x: 0.6, y: 5.05, w: 9, h: 0.35, fontSize: 11, color: C.gray, margin: 0
});

// ==================== SLIDE 8: 技术架构 ====================
let s8 = pres.addSlide();
s8.background = { color: C.navy };
s8.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.06, fill: { color: C.teal } });
s8.addText("技术架构", { x: 0.6, y: 0.3, w: 9, h: 0.7, fontSize: 32, fontFace: "Arial Black", color: C.white, bold: true, margin: 0 });

// Architecture layers
const layers = [
  { name: "前端层", tech: "Thymeleaf + Bootstrap 3 + jQuery + Bootstrap Table + ECharts 5", color: C.teal, y: 1.3 },
  { name: "安全层", tech: "Apache Shiro (RBAC权限) + CSRF防护 + Session管理", color: C.accent, y: 2.1 },
  { name: "业务层", tech: "Spring Boot 4.0 + 19个Controller + REST API", color: C.steel, y: 2.9 },
  { name: "数据层", tech: "MyBatis + MySQL 8 + Druid连接池 + PageHelper", color: C.green, y: 3.7 },
  { name: "AI 层", tech: "DeepSeek API + RestTemplate + Markdown渲染", color: C.red, y: 4.5 },
];
layers.forEach(l => {
  s8.addShape(pres.shapes.RECTANGLE, { x: 0.6, y: l.y, w: 8.8, h: 0.6, fill: { color: l.color }, shadow: mkShadow() });
  s8.addText(l.name, { x: 0.8, y: l.y, w: 1.5, h: 0.6, fontSize: 14, fontFace: "Arial Black", color: C.white, valign: "middle", margin: 0 });
  s8.addText(l.tech, { x: 2.4, y: l.y, w: 6.8, h: 0.6, fontSize: 12, color: C.white, valign: "middle", margin: 0 });
});

// ==================== SLIDE 9: 总结与展望 ====================
let s9 = pres.addSlide();
s9.background = { color: C.navy };
s9.addShape(pres.shapes.RECTANGLE, { x: 0, y: 0, w: 10, h: 0.06, fill: { color: C.teal } });
s9.addShape(pres.shapes.RECTANGLE, { x: 0, y: 5.545, w: 10, h: 0.06, fill: { color: C.teal } });

s9.addText("总结与展望", { x: 0.6, y: 0.4, w: 9, h: 0.8, fontSize: 36, fontFace: "Arial Black", color: C.white, bold: true, margin: 0 });

// Achievements
s9.addText("已实现能力", { x: 0.6, y: 1.4, w: 4, h: 0.4, fontSize: 16, fontFace: "Arial Black", color: C.teal, margin: 0 });
const achievements = [
  "15+功能模块，覆盖制造全流程",
  "SO→WO→工序→质检 全链路追溯",
  "真实数据库驱动，零Mock数据",
  "DeepSeek AI智能分析集成",
  "ECharts可视化生产看板",
  "RBAC权限 + CSRF安全防护",
];
achievements.forEach((a, i) => {
  s9.addText("✓  " + a, { x: 0.6, y: 1.9 + i * 0.38, w: 4.5, h: 0.35, fontSize: 12, color: C.lightGray, margin: 0 });
});

// Future
s9.addText("未来规划", { x: 5.5, y: 1.4, w: 4.5, h: 0.4, fontSize: 16, fontFace: "Arial Black", color: C.accent, margin: 0 });
const futureItems = [
  "生产效率分析（OEE指标）",
  "质量趋势预测（AI预警）",
  "移动端适配（小程序/H5）",
  "MES与ERP数据对接",
  "实时设备数据采集（MQTT）",
  "数字孪生产线可视化",
];
futureItems.forEach((f, i) => {
  s9.addText("→  " + f, { x: 5.5, y: 1.9 + i * 0.38, w: 4.2, h: 0.35, fontSize: 12, color: C.lightGray, margin: 0 });
});

// Bottom quote
s9.addShape(pres.shapes.LINE, { x: 2, y: 4.5, w: 6, h: 0, line: { color: C.teal, width: 1 } });
s9.addText("智能制造 · 数据驱动 · 持续迭代", {
  x: 0.5, y: 4.7, w: 9, h: 0.5, fontSize: 16, color: C.gray, align: "center", margin: 0
});

// ==================== SAVE ====================
const outPath = "/d/JAVA/MES (2)/MES/MES制造执行系统_系统介绍.pptx";
pres.writeFile({ fileName: outPath }).then(() => {
  // Copy to desktop
  const desktop = process.env.USERPROFILE + "\\Desktop\\MES制造执行系统_系统介绍.pptx";
  fs.copyFileSync(outPath, desktop);
  console.log("PPT saved to: " + desktop);
});
