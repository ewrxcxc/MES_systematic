<template>
  <div class="mes-report">
    <div class="page-header">
      <span class="page-title"><i class="fa fa-clipboard-check"></i> 车间报工终端</span>
      <div class="header-actions">
        <el-button v-hasPermi="['mes:report:add']" type="primary" icon="Plus" @click="handleAdd">新增报工</el-button>
        <el-button icon="Refresh" @click="getList">刷新</el-button>
      </div>
    </div>

    <!-- 搜索 -->
    <el-form :inline="true" :model="queryParams" class="search-bar">
      <el-form-item label="工单"><el-select v-model="queryParams.workOrderId" placeholder="工单" clearable filterable style="width:200px"><el-option v-for="w in woOptions" :key="w.workOrderId" :label="w.workOrderNo" :value="w.workOrderId"/></el-select></el-form-item>
      <el-form-item label="类型"><el-select v-model="queryParams.reportType" placeholder="类型" clearable style="width:120px"><el-option label="开工" value="开工"/><el-option label="完工" value="完工"/></el-select></el-form-item>
      <el-form-item><el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button></el-form-item>
    </el-form>

    <!-- 快速操作大按钮 -->
    <div class="quick-actions">
      <el-button type="success" size="large" icon="VideoPlay" @click="quickStartVisible=true" :disabled="!runningWoCount" class="action-btn">
        开工报工<br/><small>开始生产</small>
      </el-button>
      <el-button type="warning" size="large" icon="VideoPause" @click="quickFinishVisible=true" :disabled="!runningWoCount" class="action-btn">
        完工报工<br/><small>完成生产</small>
      </el-button>
      <el-button type="danger" size="large" icon="WarningFilled" @click="quickDefectVisible=true" class="action-btn">
        不良上报<br/><small>质量异常</small>
      </el-button>
    </div>

    <!-- 报告列表 -->
    <el-table v-loading="loading" :data="list" border stripe class="mes-table" size="small">
      <el-table-column label="报告ID" prop="reportId" width="80"/>
      <el-table-column label="工单号" prop="workOrderNo" width="170"/>
      <el-table-column label="操作员" prop="operatorName" width="100"/>
      <el-table-column label="设备" prop="equipmentName" width="140"/>
      <el-table-column label="良品" prop="goodQty" width="80" align="center"/>
      <el-table-column label="不良品" prop="badQty" width="80" align="center">
        <template #default="{row}"><span :style="{color:row.badQty>0?'#F56C6C':'#c0c4cc'}">{{ row.badQty||0 }}</span></template>
      </el-table-column>
      <el-table-column label="类型" prop="reportType" width="90" align="center">
        <template #default="{row}"><el-tag :type="row.reportType==='开工'?'success':'warning'" effect="dark" size="small">{{ row.reportType }}</el-tag></template>
      </el-table-column>
      <el-table-column label="时间" prop="reportTime" width="170"/>
      <el-table-column label="操作" width="120" fixed="right">
        <template #default="{row}">
          <el-button link type="primary" icon="View" @click="handleDetail(row)">详情</el-button>
          <el-button link type="danger" icon="Delete" @click="handleDelete(row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" :total="total" @pagination="getList"/>

    <!-- 开工弹窗 -->
    <el-dialog v-model="quickStartVisible" title="开工报工" width="460px" append-to-body>
      <el-form :model="startForm" label-width="80px">
        <el-form-item label="工单"><el-select v-model="startForm.workOrderId" filterable style="width:100%"><el-option v-for="w in runningWoList" :key="w.workOrderId" :label="w.workOrderNo" :value="w.workOrderId"/></el-select></el-form-item>
        <el-form-item label="设备"><el-select v-model="startForm.equipmentId" filterable style="width:100%"><el-option v-for="e in equipOptions" :key="e.equipmentId" :label="e.equipmentName" :value="e.equipmentId"/></el-select></el-form-item>
      </el-form>
      <template #footer><el-button @click="quickStartVisible=false">取消</el-button><el-button type="success" :loading="submitting" @click="confirmStart">确认开工</el-button></template>
    </el-dialog>

    <!-- 完工弹窗 -->
    <el-dialog v-model="quickFinishVisible" title="完工报工" width="460px" append-to-body>
      <el-form :model="finishForm" label-width="80px">
        <el-form-item label="工单"><el-select v-model="finishForm.workOrderId" filterable style="width:100%"><el-option v-for="w in runningWoList" :key="w.workOrderId" :label="w.workOrderNo" :value="w.workOrderId"/></el-select></el-form-item>
        <el-form-item label="良品数量"><el-input-number v-model="finishForm.goodQty" :min="0" style="width:100%"/></el-form-item>
        <el-form-item label="不良数量"><el-input-number v-model="finishForm.badQty" :min="0" style="width:100%"/></el-form-item>
      </el-form>
      <template #footer><el-button @click="quickFinishVisible=false">取消</el-button><el-button type="warning" :loading="submitting" @click="confirmFinish">确认完工</el-button></template>
    </el-dialog>

    <!-- 新增报工弹窗 -->
    <el-dialog v-model="formVisible" :title="currentRow.reportId?'编辑报工':'新增报工'" width="500px" append-to-body>
      <el-form :model="currentRow" label-width="80px">
        <el-form-item label="工单"><el-select v-model="currentRow.workOrderId" filterable style="width:100%"><el-option v-for="w in woOptions" :key="w.workOrderId" :label="w.workOrderNo" :value="w.workOrderId"/></el-select></el-form-item>
        <el-form-item label="良品数量"><el-input-number v-model="currentRow.goodQty" :min="0" style="width:100%"/></el-form-item>
        <el-form-item label="不良数量"><el-input-number v-model="currentRow.badQty" :min="0" style="width:100%"/></el-form-item>
        <el-form-item label="类型"><el-select v-model="currentRow.reportType" style="width:100%"><el-option label="开工" value="开工"/><el-option label="完工" value="完工"/></el-select></el-form-item>
      </el-form>
      <template #footer><el-button @click="formVisible=false">取消</el-button><el-button type="primary" :loading="submitting" @click="submitForm">保存</el-button></template>
    </el-dialog>
  </div>
</template>

<script setup>
import { getCurrentInstance, reactive, ref, toRefs, onMounted, computed } from 'vue'
import { listReport, addReport, updateReport, delReport, getReport } from './api'
import { listWorkOrder } from '@/api/mes/workorder'
import { listEquipment } from '@/api/mes/equipment'

const { proxy } = getCurrentInstance()
const loading = ref(false); const list = ref([]); const total = ref(0)
const formVisible = ref(false); const quickStartVisible = ref(false)
const quickFinishVisible = ref(false); const quickDefectVisible = ref(false)
const submitting = ref(false)
const woOptions = ref([]); const equipOptions = ref([])
const currentRow = ref({ workOrderId:null, goodQty:0, badQty:0, reportType:'开工' })

const startForm = reactive({ workOrderId:null, equipmentId:null })
const finishForm = reactive({ workOrderId:null, goodQty:0, badQty:0 })

const data = reactive({ queryParams: { pageNum:1, pageSize:15, workOrderId:null, reportType:null } })
const { queryParams } = toRefs(data)

const runningWoList = computed(() => woOptions.value.filter(w => w.status === 'RUNNING'))
const runningWoCount = computed(() => runningWoList.value.length)

onMounted(async () => {
  await loadRefs(); getList()
})

async function loadRefs() {
  const [woRes, equipRes] = await Promise.all([
    listWorkOrder({ pageNum:1, pageSize:200, status:'RUNNING' }),
    listEquipment({ pageNum:1, pageSize:200 })
  ])
  woOptions.value = woRes?.rows || []
  equipOptions.value = equipRes?.rows || []
}

function getList() { loading.value = true; listReport(queryParams.value).then(r => { list.value = r.rows||[]; total.value = r.total||0 }).finally(() => loading.value = false) }
function handleQuery() { queryParams.value.pageNum = 1; getList() }
function handleAdd() { currentRow.value = { workOrderId:null, goodQty:0, badQty:0, reportType:'开工' }; formVisible.value = true }
async function handleDetail(row) { const r = await getReport(row.reportId); currentRow.value = r.data||{} }
function handleDelete(row) { proxy.$modal.confirm('确认删除？').then(() => delReport(row.reportId)).then(() => { getList(); proxy.$modal.msgSuccess('删除成功') }) }

function submitForm() {
  submitting.value = true
  const api = currentRow.value.reportId ? updateReport : addReport
  api(currentRow.value).then(() => { formVisible.value = false; getList(); proxy.$modal.msgSuccess('保存成功') }).finally(() => submitting.value = false)
}

function confirmStart() {
  if (!startForm.workOrderId) { proxy.$modal.msgError('请选择工单'); return }
  submitting.value = true
  addReport({ workOrderId:startForm.workOrderId, equipmentId:startForm.equipmentId, reportType:'开工', reportTime:new Date() }).then(() => { quickStartVisible.value = false; getList(); proxy.$modal.msgSuccess('开工报工成功') }).finally(() => submitting.value = false)
}

function confirmFinish() {
  if (!finishForm.workOrderId) { proxy.$modal.msgError('请选择工单'); return }
  submitting.value = true
  addReport({ workOrderId:finishForm.workOrderId, goodQty:finishForm.goodQty, badQty:finishForm.badQty, reportType:'完工', reportTime:new Date() }).then(() => { quickFinishVisible.value = false; getList(); proxy.$modal.msgSuccess('完工报工成功') }).finally(() => submitting.value = false)
}
</script>

<style scoped>
.mes-report { padding:12px; background:#0a0e27; min-height:calc(100vh - 80px); color:#c0c4cc; }
.page-header { display:flex; justify-content:space-between; align-items:center; padding:12px 20px; margin-bottom:12px; background:linear-gradient(135deg,#0f1535,#1a1f4a); border-radius:6px; border:1px solid #1e2a5a; }
.page-title { font-size:18px; font-weight:bold; color:#e0e6ff; }
.page-title i { color:#67C23A; margin-right:8px; }
.search-bar { padding:12px 16px 0; margin-bottom:12px; background:#0f1535; border-radius:6px; border:1px solid #1e2a5a; }
.quick-actions { display:flex; gap:16px; margin-bottom:16px; justify-content:center; }
.action-btn { width:160px; height:80px; font-size:16px; border-radius:8px; }
.action-btn small { font-size:11px; opacity:.8; }
.mes-table { background:transparent; }
.mes-table :deep(.el-table__header th) { background:#1a1f3a; color:#8b9dc3; border-color:#1e2a5a; font-weight:normal; }
.mes-table :deep(.el-table__body td) { background:transparent; color:#c0c4cc; border-color:#1e2a5a; }
.mes-table :deep(.el-table__body tr:hover td) { background:#1a1f3a; }
</style>
