<template>
  <div class="mes-workorder">
    <div class="page-header">
      <span class="page-title"><i class="fa fa-industry"></i> 生产执行中心</span>
      <div class="header-actions">
        <el-button v-hasPermi="['mes:workorder:add']" type="primary" icon="Plus" @click="handleAdd">新增工单</el-button>
        <el-button icon="Refresh" @click="getList">刷新</el-button>
      </div>
    </div>

    <!-- 搜索 -->
    <el-form :inline="true" :model="queryParams" class="search-bar">
      <el-form-item label="工单编号"><el-input v-model.trim="queryParams.workOrderNo" placeholder="工单编号" clearable style="width:180px" @keyup.enter="handleQuery"/></el-form-item>
      <el-form-item label="状态">
        <el-select v-model="queryParams.status" placeholder="状态" clearable style="width:140px">
          <el-option v-for="s in statusOptions" :key="s.value" :label="s.label" :value="s.value"/>
        </el-select>
      </el-form-item>
      <el-form-item><el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button></el-form-item>
    </el-form>

    <!-- 工单卡片列表 (工业风) -->
    <div class="wo-cards">
      <div v-for="wo in list" :key="wo.workOrderId" class="wo-card" :class="'border-'+wo.status?.toLowerCase()">
        <div class="wo-card-header">
          <span class="wo-no">{{ wo.workOrderNo }}</span>
          <el-tag :type="statusTag(wo.status)" effect="dark">{{ wo.status }}</el-tag>
        </div>
        <div class="wo-card-body">
          <div class="wo-info">
            <div class="info-row"><span class="label">关联订单</span><span class="value">{{ wo.orderNo||'-' }}</span></div>
            <div class="info-row"><span class="label">计划数量</span><span class="value">{{ wo.plannedQty }}</span></div>
            <div class="info-row"><span class="label">完成数量</span><span class="value highlight">{{ wo.completedQty||0 }}</span></div>
            <div class="info-row"><span class="label">计划时间</span><span class="value">{{ wo.plannedStart||'-' }}</span></div>
          </div>
          <!-- 工序进度条 -->
          <div class="wo-progress">
            <div class="progress-header">
              <span>工序进度</span>
              <span>{{ wo.currentStep||1 }}/{{ wo.totalSteps||7 }}</span>
            </div>
            <el-progress :percentage="woProgress(wo)" :color="progressColor(woProgress(wo))" :stroke-width="14"/>
          </div>
        </div>
        <div class="wo-card-footer">
          <el-button link type="primary" icon="View" @click="handleDetail(wo)">详情</el-button>
          <el-button link type="primary" icon="Edit" @click="handleUpdate(wo)">编辑</el-button>
          <el-button v-if="wo.status==='WAITING'||wo.status==='READY'||wo.status==='PAUSED'" type="success" size="small" icon="VideoPlay" @click="handleStart(wo)">开工</el-button>
          <el-button v-if="wo.status==='RUNNING'" type="warning" size="small" icon="VideoPause" @click="handleFinish(wo)">完工</el-button>
          <el-button type="primary" size="small" icon="Cpu" @click="goProcess(wo)">工序执行</el-button>
          <el-button link type="danger" icon="Delete" @click="handleDelete(wo)">删除</el-button>
        </div>
      </div>
    </div>

    <pagination v-show="total>0" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" :total="total" @pagination="getList"/>

    <workorder-form v-model="formVisible" :data="currentRow" @success="getList"/>
    <workorder-detail v-model="detailVisible" :data="detailData"/>
  </div>
</template>

<script setup name="MesWorkOrder">
import { getCurrentInstance, reactive, ref, toRefs, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import WorkorderForm from './form.vue'
import WorkorderDetail from './detail.vue'
import { listWorkOrder, getWorkOrder, delWorkOrder, startWorkOrder, finishWorkOrder } from './api'

const { proxy } = getCurrentInstance()
const router = useRouter()
const loading = ref(false); const list = ref([]); const total = ref(0)
const formVisible = ref(false); const detailVisible = ref(false)
const currentRow = ref({}); const detailData = ref({})

const statusOptions = [
  {label:'WAITING 等待',value:'WAITING'},{label:'READY 就绪',value:'READY'},
  {label:'RUNNING 运行中',value:'RUNNING'},{label:'PAUSED 暂停',value:'PAUSED'},
  {label:'FINISHED 已完成',value:'FINISHED'}
]

const data = reactive({ queryParams: { pageNum:1, pageSize:12, workOrderNo:undefined, status:undefined } })
const { queryParams } = toRefs(data)

onMounted(() => getList())

function getList() { loading.value = true; listWorkOrder(queryParams.value).then(r => { list.value = r.rows||[]; total.value = r.total||0 }).finally(() => loading.value = false) }
function handleQuery() { queryParams.value.pageNum = 1; getList() }
function handleAdd() { currentRow.value = {}; formVisible.value = true }
async function handleUpdate(row) { const r = await getWorkOrder(row.workOrderId); currentRow.value = r.data||{}; formVisible.value = true }
async function handleDetail(row) { const r = await getWorkOrder(row.workOrderId); detailData.value = r.data||{}; detailVisible.value = true }
function handleDelete(row) { proxy.$modal.confirm('确认删除？').then(() => delWorkOrder(row.workOrderId)).then(() => { getList(); proxy.$modal.msgSuccess('删除成功') }) }
function handleStart(row) { proxy.$modal.confirm('确认开工？将自动创建7道工序任务。').then(() => startWorkOrder(row.workOrderId)).then(() => { getList(); proxy.$modal.msgSuccess('开工成功，工序已生成') }) }
function handleFinish(row) { proxy.$prompt('完工数量','完工确认',{inputValue:row.plannedQty,inputPattern:/^\d+$/}).then(({value}) => finishWorkOrder(row.workOrderId, parseInt(value))).then(() => { getList(); proxy.$modal.msgSuccess('完工成功') }) }
function goProcess(wo) { router.push({ path:'/mes/processTask', query:{ workOrderId:wo.workOrderId } }) }

function statusTag(s) { return { WAITING:'info', READY:'', RUNNING:'warning', FINISHED:'success', PAUSED:'danger' }[s]||'info' }
function woProgress(wo) { if (wo.totalSteps > 0) return Math.round((wo.currentStep||1)*100/(wo.totalSteps||7)); return 0 }
function progressColor(p) { if (p >= 80) return '#67C23A'; if (p >= 40) return '#E6A23C'; return '#409EFF' }
</script>

<style scoped>
.mes-workorder { padding:12px; background:#0a0e27; min-height:calc(100vh - 80px); color:#c0c4cc; }
.page-header { display:flex; justify-content:space-between; align-items:center; padding:12px 20px; margin-bottom:12px; background:linear-gradient(135deg,#0f1535,#1a1f4a); border-radius:6px; border:1px solid #1e2a5a; }
.page-title { font-size:18px; font-weight:bold; color:#e0e6ff; }
.page-title i { color:#E6A23C; margin-right:8px; }
.search-bar { padding:12px 16px 0; margin-bottom:12px; background:#0f1535; border-radius:6px; border:1px solid #1e2a5a; }
.wo-cards { display:grid; grid-template-columns:repeat(auto-fill,minmax(380px,1fr)); gap:12px; }
.wo-card { background:linear-gradient(135deg,#0f1535,#151940); border-radius:6px; border:1px solid #1e2a5a; border-left:4px solid #409EFF; padding:16px; transition:all .2s; }
.wo-card:hover { transform:translateY(-2px); box-shadow:0 4px 16px rgba(64,158,255,.12); }
.wo-card.border-running { border-left-color:#E6A23C; }
.wo-card.border-finished { border-left-color:#67C23A; }
.wo-card.border-paused { border-left-color:#F56C6C; }
.wo-card-header { display:flex; justify-content:space-between; align-items:center; margin-bottom:10px; }
.wo-no { font-size:16px; font-weight:bold; color:#e0e6ff; font-family:monospace; }
.wo-card-body { display:flex; gap:20px; margin-bottom:10px; }
.wo-info { flex:1; }
.info-row { display:flex; justify-content:space-between; font-size:13px; padding:3px 0; border-bottom:1px solid #1a1f3a; }
.info-row .label { color:#6b7db3; }
.info-row .value { color:#c0c4cc; }
.info-row .highlight { color:#67C23A; font-weight:bold; font-size:16px; }
.wo-progress { width:160px; }
.progress-header { display:flex; justify-content:space-between; font-size:12px; color:#8b9dc3; margin-bottom:6px; }
.wo-card-footer { display:flex; gap:6px; align-items:center; flex-wrap:wrap; padding-top:8px; border-top:1px solid #1a1f3a; }
</style>
