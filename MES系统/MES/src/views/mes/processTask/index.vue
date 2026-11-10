<template>
  <div class="mes-process">
    <div class="page-header">
      <span class="page-title"><i class="fa fa-cogs"></i> 工序任务执行中心</span>
      <div class="header-actions">
        <el-select v-model="selectedWorkOrderId" placeholder="选择工单" filterable style="width:280px" @change="loadTasks">
          <el-option v-for="wo in workOrderOptions" :key="wo.workOrderId" :label="wo.workOrderNo + ' - ' + (wo.orderNo||'')" :value="wo.workOrderId"/>
        </el-select>
        <el-button type="primary" @click="loadTasks" :loading="loading">加载工序</el-button>
      </div>
    </div>

    <!-- 整体进度 -->
    <div class="overall-progress" v-if="tasks.length">
      <div class="progress-label">工单整体进度</div>
      <el-progress :percentage="progress" :color="progressColor" :stroke-width="22">
        <span style="font-size:13px;font-weight:bold">{{ progress }}%</span>
      </el-progress>
    </div>

    <!-- 工序卡片流 -->
    <div class="process-flow" v-if="tasks.length">
      <div class="flow-line"></div>
      <div v-for="(task, idx) in tasks" :key="task.taskId" class="process-node-row">
        <div class="process-card" :class="['status-'+task.status.toLowerCase()]">
          <div class="card-seq">{{ idx + 1 }}</div>
          <div class="card-body">
            <div class="card-name">{{ task.processName }}</div>
            <div class="card-status">
              <el-tag :type="statusTag(task.status)" effect="dark" size="small">{{ statusLabel(task.status) }}</el-tag>
            </div>
            <div class="card-meta">
              <span>计划: {{ task.plannedQty }}</span>
              <span>良品: {{ task.goodQty||0 }}</span>
              <span>不良: {{ task.badQty||0 }}</span>
            </div>
            <div class="card-meta" v-if="task.startTime">
              <span>开始: {{ task.startTime }}</span>
              <span v-if="task.endTime">结束: {{ task.endTime }}</span>
            </div>
          </div>
          <div class="card-actions">
            <el-button v-if="task.status==='WAITING'||task.status==='READY'" type="success" size="small" @click="doStart(task)">开工</el-button>
            <el-button v-if="task.status==='RUNNING'" type="warning" size="small" @click="doFinish(task)">完工</el-button>
            <span v-if="task.status==='FINISHED'" style="color:#67C23A;font-size:13px">已完成</span>
          </div>
        </div>
        <div v-if="idx < tasks.length-1" class="process-arrow">
          <i class="fa fa-arrow-down"></i>
        </div>
      </div>
    </div>

    <!-- 完工弹窗 -->
    <el-dialog v-model="finishVisible" title="完工报工" width="400px" append-to-body>
      <el-form :model="finishForm" label-width="80px">
        <el-form-item label="良品数量"><el-input-number v-model="finishForm.goodQty" :min="0" style="width:100%"/></el-form-item>
        <el-form-item label="不良品数量"><el-input-number v-model="finishForm.badQty" :min="0" style="width:100%"/></el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="finishVisible=false">取消</el-button>
        <el-button type="primary" :loading="submitting" @click="confirmFinish">确认完工</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { listWorkOrder } from '@/api/mes/workorder'
import { getTasksByWorkOrder, startTask, finishTask } from '@/api/mes/process'

const workOrderOptions = ref([])
const selectedWorkOrderId = ref(null)
const tasks = ref([])
const progress = ref(0)
const loading = ref(false)
const finishVisible = ref(false)
const finishForm = ref({ taskId:null, goodQty:0, badQty:0 })
const submitting = ref(false)

const progressColor = [
  {color:'#909399', percentage:20},{color:'#409EFF', percentage:40},
  {color:'#E6A23C', percentage:70},{color:'#67C23A', percentage:100}
]

function statusTag(s) { return { WAITING:'info', READY:'', RUNNING:'warning', FINISHED:'success', PAUSED:'danger' }[s]||'info' }
function statusLabel(s) { return { WAITING:'等待中', READY:'就绪', RUNNING:'运行中', FINISHED:'已完成', PAUSED:'已暂停' }[s]||s }

onMounted(async () => {
  const { data:wo } = await listWorkOrder({ pageNum:1, pageSize:100 })
  workOrderOptions.value = wo?.rows || []
  if (wo?.rows?.length) { selectedWorkOrderId.value = wo.rows[0].workOrderId; await loadTasks() }
})

async function loadTasks() {
  if (!selectedWorkOrderId.value) return
  loading.value = true
  try {
    const { data:res } = await getTasksByWorkOrder(selectedWorkOrderId.value)
    tasks.value = res?.tasks || []
    progress.value = res?.progress || 0
  } finally { loading.value = false }
}

function doStart(task) {
  startTask(task.taskId, null, null).then(() => { loadTasks() })
}

function doFinish(task) {
  finishForm.value = { taskId:task.taskId, goodQty:task.plannedQty||0, badQty:0 }
  finishVisible.value = true
}

function confirmFinish() {
  submitting.value = true
  finishTask(finishForm.value.taskId, finishForm.value.goodQty, finishForm.value.badQty).then(() => {
    finishVisible.value = false
    loadTasks()
  }).finally(() => { submitting.value = false })
}
</script>

<style scoped>
.mes-process { padding:12px; background:#0a0e27; min-height:calc(100vh - 80px); color:#c0c4cc; }
.page-header { display:flex; justify-content:space-between; align-items:center; padding:12px 20px; margin-bottom:16px; background:linear-gradient(135deg,#0f1535,#1a1f4a); border-radius:6px; border:1px solid #1e2a5a; }
.page-title { font-size:18px; font-weight:bold; color:#e0e6ff; }
.page-title i { color:#409EFF; margin-right:8px; }
.overall-progress { padding:16px 20px; margin-bottom:16px; background:linear-gradient(135deg,#0f1535,#151940); border-radius:6px; border:1px solid #1e2a5a; }
.progress-label { font-size:14px; color:#8b9dc3; margin-bottom:8px; }
.process-flow { position:relative; padding-left:40px; }
.flow-line { position:absolute; left:27px; top:10px; bottom:10px; width:2px; background:linear-gradient(#409EFF,#67C23A); }
.process-node-row { position:relative; }
.process-card { display:flex; align-items:center; padding:14px 16px; margin-bottom:4px; background:#0f1535; border-radius:6px; border-left:4px solid #409EFF; }
.process-card.status-finished { border-left-color:#67C23A; opacity:.8; }
.process-card.status-running { border-left-color:#E6A23C; box-shadow:0 0 12px rgba(230,162,60,.2); }
.card-seq { width:32px; height:32px; border-radius:50%; background:#1e2a5a; display:flex; align-items:center; justify-content:center; font-weight:bold; margin-right:14px; flex-shrink:0; }
.card-body { flex:1; }
.card-name { font-size:15px; font-weight:bold; color:#e0e6ff; margin-bottom:4px; }
.card-status { margin-bottom:4px; }
.card-meta { font-size:12px; color:#6b7db3; display:flex; gap:16px; }
.card-actions { margin-left:12px; flex-shrink:0; }
.process-arrow { text-align:center; color:#409EFF; font-size:16px; padding:4px 0 8px 0; }
</style>
