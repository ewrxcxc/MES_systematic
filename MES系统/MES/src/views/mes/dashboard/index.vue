<template>
  <div class="mes-dashboard">
    <div class="dashboard-header">
      <div class="header-left">
        <span class="header-title">MES 生产驾驶舱</span>
        <span class="header-subtitle">智能制造执行系统</span>
      </div>
      <div class="header-right">
        <span class="header-time">{{ currentTime }}</span>
        <el-tag type="success" effect="dark" size="large">系统运行中</el-tag>
      </div>
    </div>

    <el-row :gutter="12" class="kpi-row">
      <el-col :span="4" v-for="(kpi, index) in kpiCards" :key="kpi.label">
        <div class="kpi-card" :style="{borderTopColor: kpi.color}">
          <div class="kpi-icon"><i :class="kpi.icon" :style="{color: kpi.color}"></i></div>
          <div class="kpi-body">
            <div class="kpi-value" :style="{color: kpi.color}">{{ kpi.value }}</div>
            <div class="kpi-label">{{ kpi.label }}</div>
            <div class="kpi-sub" v-if="kpi.sub">{{ kpi.sub }}</div>
          </div>
        </div>
      </el-col>
    </el-row>

    <el-row :gutter="12" class="chart-row">
      <el-col :span="14">
        <div class="panel">
          <div class="panel-header">
            <span class="panel-title"><i class="el-icon-pie-chart"></i> 工单状态分布</span>
          </div>
          <div v-if="orderStatusData.length > 0" ref="orderStatusChart" class="panel-chart"></div>
          <div v-else class="empty-data"><i class="el-icon-warning-outline"></i> 暂无工单数据</div>
        </div>
      </el-col>
      <el-col :span="10">
        <div class="panel">
          <div class="panel-header">
            <span class="panel-title"><i class="el-icon-data-line"></i> 良率趋势 (近7天)</span>
          </div>
          <div v-if="yieldTrendData.length > 0" ref="yieldTrendChart" class="panel-chart"></div>
          <div v-else class="empty-data"><i class="el-icon-warning-outline"></i> 暂无良率数据</div>
        </div>
      </el-col>
    </el-row>

    <el-row :gutter="12" class="chart-row">
      <el-col :span="10">
        <div class="panel">
          <div class="panel-header">
            <span class="panel-title"><i class="el-icon-set-up"></i> 设备运行状态</span>
          </div>
          <div v-if="equipStatusData.length > 0" ref="equipStatusChart" class="panel-chart"></div>
          <div v-else class="empty-data"><i class="el-icon-warning-outline"></i> 暂无设备数据</div>
        </div>
      </el-col>
      <el-col :span="14">
        <div class="panel">
          <div class="panel-header">
            <span class="panel-title"><i class="el-icon-box"></i> 库存统计</span>
          </div>
          <div v-if="inventoryData.length > 0" ref="inventoryChart" class="panel-chart"></div>
          <div v-else class="empty-data"><i class="el-icon-warning-outline"></i> 暂无库存数据</div>
        </div>
      </el-col>
    </el-row>

    <el-row :gutter="12" class="chart-row">
      <el-col :span="24">
        <div class="panel">
          <div class="panel-header">
            <span class="panel-title"><i class="el-icon-video-play"></i> 运行中工单实时进度</span>
            <el-button link type="primary" @click="refreshAll" :loading="loading">刷新数据</el-button>
          </div>
          <el-table v-if="runningOrders.length > 0" :data="runningOrders" border stripe class="mes-table" size="small">
            <el-table-column label="工单号" prop="workOrderNo" width="180" />
            <el-table-column label="关联订单" prop="orderNo" width="160" />
            <el-table-column label="工序进度" min-width="300">
              <template #default="{row}">
                <div class="progress-cell">
                  <el-progress :percentage="row.progress||0" :color="progressColor(row.progress)" :stroke-width="18">
                    <span style="font-size:12px">{{ row.currentStep||1 }}/{{ row.totalSteps||7 }} 工序</span>
                  </el-progress>
                </div>
              </template>
            </el-table-column>
            <el-table-column label="完成率" width="120" align="center">
              <template #default="{row}">{{ row.completedQty||0 }}/{{ row.plannedQty||0 }}</template>
            </el-table-column>
            <el-table-column label="状态" width="100" align="center">
              <template #default="{row}"><el-tag :type="statusTag(row.status)" effect="dark" size="small">{{ statusText(row.status) }}</el-tag></template>
            </el-table-column>
            <el-table-column label="开始时间" prop="startTime" width="160" />
          </el-table>
          <div v-else class="empty-data"><i class="el-icon-warning-outline"></i> 暂无运行中的工单</div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script setup name="MesDashboard">
import { ref, onMounted, onUnmounted, nextTick } from 'vue'
import * as echarts from 'echarts'
import { getDashboardStats, getOrderStatus, getEquipStatus, getInventoryStats, getYieldTrend } from '@/api/mes/dashboard'
import { listWorkOrder } from '@/api/mes/workorder'
import { getTasksByWorkOrder } from '@/api/mes/process'

const orderStatusChart = ref(null)
const yieldTrendChart = ref(null)
const equipStatusChart = ref(null)
const inventoryChart = ref(null)
const runningOrders = ref([])
const currentTime = ref('')
const loading = ref(false)

const orderStatusData = ref([])
const equipStatusData = ref([])
const inventoryData = ref([])
const yieldTrendData = ref([])

let timer = null

const kpiCards = ref([
  { label:'今日工单数', value:0, sub:'', icon:'el-icon-document-copy', color:'#409EFF' },
  { label:'运行中工单', value:0, sub:'', icon:'el-icon-loading', color:'#E6A23C' },
  { label:'今日完工数', value:0, sub:'', icon:'el-icon-circle-check', color:'#67C23A' },
  { label:'今日良率', value:'--%', sub:'', icon:'el-icon-data-analysis', color:'#00D4FF' },
  { label:'库存预警', value:0, sub:'项', icon:'el-icon-warning', color:'#F56C6C' },
  { label:'设备运行率', value:'--%', sub:'', icon:'el-icon-cpu', color:'#9B59B6' },
])

function statusTag(s) {
  const m = { FINISHED:'success', RUNNING:'warning', WAITING:'info', READY:'', PAUSED:'danger' }
  return m[s] || 'info'
}

function statusText(s) {
  const m = { FINISHED:'已完成', RUNNING:'运行中', WAITING:'等待中', READY:'就绪', PAUSED:'已暂停' }
  return m[s] || s
}

function progressColor(p) {
  if (p >= 80) return '#67C23A'
  if (p >= 40) return '#E6A23C'
  return '#409EFF'
}

function initOrderStatusChart() {
  if (!orderStatusChart.value || !orderStatusData.value.length) return
  const chart = echarts.init(orderStatusChart.value)
  const option = {
    tooltip: { trigger: 'item', formatter: '{b}: {c} ({d}%)' },
    legend: { bottom: 10, textStyle: { color: '#c0c4cc' } },
    color: ['#67C23A', '#E6A23C', '#409EFF', '#F56C6C', '#909399'],
    series: [{
      type: 'pie',
      radius: ['45%', '75%'],
      center: ['50%', '45%'],
      avoidLabelOverlap: false,
      itemStyle: { borderRadius: 6, borderColor: '#0f1535', borderWidth: 2 },
      label: { show: true, color: '#c0c4cc', formatter: '{b}\n{c}' },
      emphasis: { label: { show: true, fontSize: 14, fontWeight: 'bold' } },
      data: orderStatusData.value.map(d => ({ name: d.status, value: d.cnt }))
    }]
  }
  chart.setOption(option)
}

function initEquipStatusChart() {
  if (!equipStatusChart.value || !equipStatusData.value.length) return
  const chart = echarts.init(equipStatusChart.value)
  const option = {
    tooltip: { trigger: 'item', formatter: '{b}: {c} ({d}%)' },
    legend: { bottom: 10, textStyle: { color: '#c0c4cc' } },
    color: ['#67C23A', '#E6A23C', '#F56C6C', '#909399'],
    series: [{
      type: 'pie',
      radius: ['45%', '75%'],
      center: ['50%', '45%'],
      avoidLabelOverlap: false,
      itemStyle: { borderRadius: 6, borderColor: '#0f1535', borderWidth: 2 },
      label: { show: true, color: '#c0c4cc', formatter: '{b}\n{c}' },
      emphasis: { label: { show: true, fontSize: 14, fontWeight: 'bold' } },
      data: equipStatusData.value.map(d => ({ name: d.status, value: d.cnt }))
    }]
  }
  chart.setOption(option)
}

function initInventoryChart() {
  if (!inventoryChart.value || !inventoryData.value.length) return
  const chart = echarts.init(inventoryChart.value)
  const option = {
    tooltip: { trigger: 'axis' },
    grid: { left: 60, right: 30, top: 20, bottom: 40 },
    xAxis: {
      type: 'category',
      data: inventoryData.value.map(d => d.inventory_type),
      axisLabel: { color: '#909399', rotate: 15 },
      axisLine: { lineStyle: { color: '#2d2d3f' } }
    },
    yAxis: {
      type: 'value',
      axisLabel: { color: '#909399' },
      splitLine: { lineStyle: { color: '#2d2d3f' } },
      axisLine: { lineStyle: { color: '#2d2d3f' } }
    },
    series: [{
      name: '库存量',
      type: 'bar',
      data: inventoryData.value.map(d => d.total_qty),
      itemStyle: {
        borderRadius: [4, 4, 0, 0],
        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
          { offset: 0, color: '#409EFF' },
          { offset: 1, color: '#1a3a5c' }
        ])
      },
      barWidth: '50%'
    }]
  }
  chart.setOption(option)
}

function initYieldTrendChart() {
  if (!yieldTrendChart.value || !yieldTrendData.value.length) return
  const chart = echarts.init(yieldTrendChart.value)
  const option = {
    tooltip: { trigger: 'axis', axisPointer: { type: 'shadow' } },
    legend: { bottom: 10, textStyle: { color: '#c0c4cc' }, data: ['良品', '不良品'] },
    grid: { left: 50, right: 20, top: 20, bottom: 50 },
    xAxis: {
      type: 'category',
      data: yieldTrendData.value.map(d => d.dt),
      axisLabel: { color: '#909399', rotate: 15 },
      axisLine: { lineStyle: { color: '#2d2d3f' } }
    },
    yAxis: {
      type: 'value',
      axisLabel: { color: '#909399' },
      splitLine: { lineStyle: { color: '#2d2d3f' } },
      axisLine: { lineStyle: { color: '#2d2d3f' } }
    },
    series: [
      {
        name: '良品',
        type: 'bar',
        stack: 'total',
        data: yieldTrendData.value.map(d => d.good || 0),
        itemStyle: { color: '#67C23A', borderRadius: [0, 0, 0, 0] },
        barWidth: '60%'
      },
      {
        name: '不良品',
        type: 'bar',
        stack: 'total',
        data: yieldTrendData.value.map(d => d.bad || 0),
        itemStyle: { color: '#F56C6C', borderRadius: [4, 4, 0, 0] },
        barWidth: '60%'
      }
    ]
  }
  chart.setOption(option)
}

async function refreshAll() {
  loading.value = true
  try {
    const statsRes = await getDashboardStats()
    if (statsRes.data) {
      const stats = statsRes.data
      kpiCards.value[0].value = stats.todayOrders || 0
      kpiCards.value[1].value = stats.runningOrders || 0
      kpiCards.value[2].value = stats.todayFinished || 0
      kpiCards.value[3].value = (stats.yieldRate || 0) + '%'
      kpiCards.value[4].value = stats.lowStock || 0
      kpiCards.value[5].value = (stats.equipRunningRate || 0) + '%'
    }

    const orderStatusRes = await getOrderStatus()
    orderStatusData.value = orderStatusRes.data || []
    initOrderStatusChart()

    const equipStatusRes = await getEquipStatus()
    equipStatusData.value = equipStatusRes.data || []
    initEquipStatusChart()

    const invRes = await getInventoryStats()
    inventoryData.value = invRes.data || []
    initInventoryChart()

    const yieldRes = await getYieldTrend()
    yieldTrendData.value = yieldRes.data || []
    initYieldTrendChart()

    const woRes = await listWorkOrder({ status: 'RUNNING', pageNum: 1, pageSize: 20 })
    const orders = woRes.data?.rows || []
    for (const wo of orders) {
      try {
        const ptRes = await getTasksByWorkOrder(wo.workOrderId)
        const pt = ptRes.data
        if (pt) {
          wo.progress = pt.progress || Math.round((wo.completedQty / wo.plannedQty) * 100) || 0
          const runningTask = pt.tasks?.find(t => t.status === 'RUNNING')
          wo.currentStep = runningTask?.processSeq || wo.currentStep || 1
          wo.totalSteps = wo.totalSteps || pt.tasks?.length || 7
        } else {
          wo.progress = Math.round((wo.completedQty / wo.plannedQty) * 100) || 0
          wo.currentStep = wo.currentStep || 1
          wo.totalSteps = wo.totalSteps || 7
        }
      } catch (e) {
        wo.progress = Math.round((wo.completedQty / wo.plannedQty) * 100) || 0
        wo.currentStep = wo.currentStep || 1
        wo.totalSteps = wo.totalSteps || 7
      }
    }
    runningOrders.value = orders
  } catch (e) {
    console.error('Dashboard load error:', e)
  } finally {
    loading.value = false
  }
}

function updateTime() {
  const now = new Date()
  currentTime.value = now.toLocaleString('zh-CN', { hour12: false })
}

onMounted(async () => {
  updateTime()
  timer = setInterval(updateTime, 1000)
  await nextTick()
  await refreshAll()

  window.addEventListener('resize', () => {
    initOrderStatusChart()
    initEquipStatusChart()
    initInventoryChart()
    initYieldTrendChart()
  })
})

onUnmounted(() => {
  clearInterval(timer)
  window.removeEventListener('resize', () => {})
})
</script>

<style scoped>
.mes-dashboard { padding: 12px; background: #0a0e27; min-height: calc(100vh - 80px); color: #c0c4cc; font-family: 'Microsoft YaHei', sans-serif; }

.dashboard-header { display: flex; justify-content: space-between; align-items: center; padding: 12px 20px; margin-bottom: 12px; background: linear-gradient(135deg, #0f1535, #1a1f4a); border-radius: 6px; border: 1px solid #1e2a5a; }
.header-title { font-size: 24px; font-weight: bold; color: #e0e6ff; letter-spacing: 3px; }
.header-subtitle { font-size: 13px; color: #6b7db3; margin-left: 16px; }
.header-right { display: flex; align-items: center; gap: 12px; }
.header-time { font-size: 14px; color: #8b9dc3; font-family: monospace; }

.kpi-row { margin-bottom: 12px; }
.kpi-card { display: flex; align-items: center; padding: 16px 14px; background: linear-gradient(135deg, #0f1535, #151940); border-radius: 6px; border: 1px solid #1e2a5a; border-top: 3px solid #409EFF; cursor: pointer; transition: all 0.3s; }
.kpi-card:hover { transform: translateY(-2px); box-shadow: 0 4px 16px rgba(64, 158, 255, 0.2); }
.kpi-icon { font-size: 32px; margin-right: 14px; width: 48px; text-align: center; }
.kpi-body { flex: 1; }
.kpi-value { font-size: 28px; font-weight: bold; }
.kpi-label { font-size: 13px; color: #8b9dc3; margin-top: 4px; }
.kpi-sub { font-size: 11px; color: #5a6a8a; margin-top: 2px; }

.chart-row { margin-bottom: 12px; }
.panel { background: linear-gradient(135deg, #0f1535, #151940); border-radius: 6px; border: 1px solid #1e2a5a; min-height: 340px; }
.panel-header { display: flex; justify-content: space-between; align-items: center; padding: 10px 16px; border-bottom: 1px solid #1e2a5a; }
.panel-title { font-size: 14px; font-weight: bold; color: #c8d6e5; }
.panel-title i { margin-right: 6px; color: #409EFF; }
.panel-chart { height: 300px; }

.empty-data { height: 300px; display: flex; flex-direction: column; justify-content: center; align-items: center; color: #606266; font-size: 14px; }
.empty-data i { font-size: 48px; margin-bottom: 12px; color: #909399; }

.mes-table { background: transparent; }
.mes-table :deep(.el-table__header th) { background: #1a1f3a; color: #8b9dc3; border-color: #1e2a5a; font-weight: normal; }
.mes-table :deep(.el-table__body td) { background: transparent; color: #c0c4cc; border-color: #1e2a5a; }
.mes-table :deep(.el-table__body tr:hover > td) { background: #1a1f3a !important; }
.mes-table :deep(.el-table) { background: transparent; }
.mes-table :deep(.el-table__empty-text) { color: #606266; }
.progress-cell { padding: 4px 0; }
</style>
