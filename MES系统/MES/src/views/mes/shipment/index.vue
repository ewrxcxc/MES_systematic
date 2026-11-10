<template>
  <div class="mes-shipment">
    <div class="page-header">
      <span class="page-title"><i class="fa fa-truck"></i> 发货管理中心</span>
      <div class="header-actions">
        <el-button v-hasPermi="['mes:shipment:add']" type="primary" icon="Plus" @click="handleAdd">新增发货</el-button>
        <el-button icon="Refresh" @click="getList">刷新</el-button>
      </div>
    </div>

    <el-form :inline="true" :model="queryParams" class="search-bar">
      <el-form-item label="发货编号"><el-input v-model.trim="queryParams.shipmentNo" placeholder="发货编号" clearable style="width:200px"/></el-form-item>
      <el-form-item label="订单"><el-select v-model="queryParams.orderId" placeholder="订单" clearable filterable style="width:200px"><el-option v-for="o in orderOptions" :key="o.orderId" :label="o.orderNo" :value="o.orderId"/></el-select></el-form-item>
      <el-form-item><el-button type="primary" icon="Search" @click="getList">搜索</el-button></el-form-item>
    </el-form>

    <!-- 发货卡片 -->
    <div class="ship-cards">
      <div v-for="s in list" :key="s.shipmentId" class="ship-card">
        <div class="ship-header">
          <span class="ship-no">{{ s.shipmentNo }}</span>
          <el-tag :type="s.shipmentQty>0?'success':'info'" effect="dark">{{ s.shipmentQty>0?'已发货':'待发货' }}</el-tag>
        </div>
        <div class="ship-body">
          <div class="ship-info">
            <div class="info-row"><span class="label">关联订单</span><span class="value">{{ s.orderNo||'-' }}</span></div>
            <div class="info-row"><span class="label">快递公司</span><span class="value">{{ s.expressCompany||'-' }}</span></div>
            <div class="info-row"><span class="label">快递单号</span><span class="value mono">{{ s.trackingNo||'-' }}</span></div>
          </div>
          <div class="ship-qty">
            <div class="qty-value">{{ s.shipmentQty||0 }}</div>
            <div class="qty-label">发货数量</div>
          </div>
        </div>
        <div class="ship-footer">
          <span class="ship-time">{{ s.shipmentTime||'-' }}</span>
          <div>
            <el-button link type="primary" @click="handleDetail(s)">详情</el-button>
            <el-button link type="primary" @click="handleUpdate(s)">编辑</el-button>
            <el-button link type="danger" @click="handleDelete(s)">删除</el-button>
          </div>
        </div>
      </div>
    </div>

    <pagination v-show="total>0" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" :total="total" @pagination="getList"/>

    <!-- 发货表单弹窗 -->
    <el-dialog v-model="formVisible" :title="currentRow.shipmentId?'编辑发货':'新增发货'" width="560px" append-to-body>
      <el-form :model="currentRow" label-width="90px">
        <el-form-item label="发货编号"><el-input v-model.trim="currentRow.shipmentNo" placeholder="留空自动生成"/></el-form-item>
        <el-form-item label="关联订单"><el-select v-model="currentRow.orderId" filterable style="width:100%"><el-option v-for="o in orderOptions" :key="o.orderId" :label="o.orderNo" :value="o.orderId"/></el-select></el-form-item>
        <el-form-item label="快递公司"><el-input v-model.trim="currentRow.expressCompany" placeholder="快递公司"/></el-form-item>
        <el-form-item label="快递单号"><el-input v-model.trim="currentRow.trackingNo" placeholder="快递单号"/></el-form-item>
        <el-form-item label="发货数量"><el-input-number v-model="currentRow.shipmentQty" :min="1" style="width:100%"/></el-form-item>
        <el-form-item label="发货时间"><el-date-picker v-model="currentRow.shipmentTime" type="datetime" value-format="YYYY-MM-DD HH:mm:ss" style="width:100%"/></el-form-item>
      </el-form>
      <template #footer><el-button @click="formVisible=false">取消</el-button><el-button type="primary" :loading="submitting" @click="submitForm">保存</el-button></template>
    </el-dialog>
  </div>
</template>

<script setup>
import { getCurrentInstance, reactive, ref, toRefs, onMounted } from 'vue'
import { listShipment, addShipment, updateShipment, delShipment, getShipment } from './api'
import { listOrder } from '@/api/mes/order'

const { proxy } = getCurrentInstance()
const loading = ref(false); const list = ref([]); const total = ref(0)
const formVisible = ref(false); const submitting = ref(false)
const orderOptions = ref([])
const currentRow = ref({ orderId:null, shipmentNo:'', expressCompany:'', trackingNo:'', shipmentQty:0, shipmentTime:null })

const data = reactive({ queryParams: { pageNum:1, pageSize:12, orderId:null, shipmentNo:null } })
const { queryParams } = toRefs(data)

onMounted(async () => {
  const { data:orders } = await listOrder({ pageNum:1, pageSize:999 })
  orderOptions.value = orders?.rows || []
  getList()
})

function getList() { loading.value = true; listShipment(queryParams.value).then(r => { list.value = r.rows||[]; total.value = r.total||0 }).finally(() => loading.value = false) }
function handleAdd() { currentRow.value = { orderId:null, shipmentNo:'', expressCompany:'', trackingNo:'', shipmentQty:0, shipmentTime:null }; formVisible.value = true }
async function handleUpdate(row) { const r = await getShipment(row.shipmentId); currentRow.value = r.data||{}; formVisible.value = true }
function handleDetail(row) { currentRow.value = row }
function handleDelete(row) { proxy.$modal.confirm('确认删除？').then(() => delShipment(row.shipmentId)).then(() => { getList(); proxy.$modal.msgSuccess('删除成功') }) }
function submitForm() {
  submitting.value = true
  const api = currentRow.value.shipmentId ? updateShipment : addShipment
  api(currentRow.value).then(() => { formVisible.value = false; getList(); proxy.$modal.msgSuccess('保存成功') }).finally(() => submitting.value = false)
}
</script>

<style scoped>
.mes-shipment { padding:12px; background:#0a0e27; min-height:calc(100vh - 80px); color:#c0c4cc; }
.page-header { display:flex; justify-content:space-between; align-items:center; padding:12px 20px; margin-bottom:12px; background:linear-gradient(135deg,#0f1535,#1a1f4a); border-radius:6px; border:1px solid #1e2a5a; }
.page-title { font-size:18px; font-weight:bold; color:#e0e6ff; }
.page-title i { color:#00BCD4; margin-right:8px; }
.search-bar { padding:12px 16px 0; margin-bottom:12px; background:#0f1535; border-radius:6px; border:1px solid #1e2a5a; }
.ship-cards { display:grid; grid-template-columns:repeat(auto-fill,minmax(360px,1fr)); gap:12px; }
.ship-card { background:linear-gradient(135deg,#0f1535,#151940); border-radius:6px; border:1px solid #1e2a5a; padding:16px; }
.ship-header { display:flex; justify-content:space-between; align-items:center; margin-bottom:10px; }
.ship-no { font-size:15px; font-weight:bold; color:#e0e6ff; font-family:monospace; }
.ship-body { display:flex; gap:20px; margin-bottom:10px; }
.ship-info { flex:1; }
.info-row { display:flex; justify-content:space-between; font-size:13px; padding:3px 0; border-bottom:1px solid #1a1f3a; }
.info-row .label { color:#6b7db3; }
.info-row .value { color:#c0c4cc; }
.info-row .mono { font-family:monospace; }
.ship-qty { width:80px; text-align:center; }
.qty-value { font-size:28px; font-weight:bold; color:#00BCD4; }
.qty-label { font-size:11px; color:#6b7db3; }
.ship-footer { display:flex; justify-content:space-between; align-items:center; padding-top:8px; border-top:1px solid #1a1f3a; font-size:12px; }
.ship-time { color:#6b7db3; }
</style>
