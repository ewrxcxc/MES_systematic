<template>
  <div class="app-container mes-order-page">
    <el-form v-show="showSearch" ref="queryRef" :inline="true" :model="queryParams" class="mes-search">
      <el-form-item label="订单编号" prop="orderNo">
        <el-input v-model.trim="queryParams.orderNo" placeholder="请输入订单编号" clearable style="width:200px" @keyup.enter="handleQuery"/>
      </el-form-item>
      <el-form-item label="客户" prop="customerName">
        <el-input v-model.trim="queryParams.customerName" placeholder="请输入客户名称" clearable style="width:180px" @keyup.enter="handleQuery"/>
      </el-form-item>
      <el-form-item label="订单状态" prop="orderStatus">
        <el-select v-model="queryParams.orderStatus" placeholder="请选择状态" clearable style="width:140px">
          <el-option label="待处理" value="待处理"/>
          <el-option label="生产中" value="生产中"/>
          <el-option label="已完成" value="已完成"/>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button v-hasPermi="['mes:order:add']" type="primary" plain icon="Plus" @click="handleAdd">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button v-hasPermi="['mes:order:edit']" type="success" plain icon="Edit" :disabled="single" @click="handleUpdate()">编辑</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button v-hasPermi="['mes:order:remove']" type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button v-hasPermi="['mes:order:export']" type="warning" plain icon="Download" @click="handleExport">导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"/>
    </el-row>

    <el-table v-loading="loading" :data="orderList" border stripe class="mes-table" @selection-change="handleSelectionChange" @sort-change="handleSortChange">
      <el-table-column type="selection" width="50" align="center"/>
      <el-table-column label="订单编号" prop="orderNo" min-width="160" sortable="custom" show-overflow-tooltip/>
      <el-table-column label="客户" prop="customerName" min-width="140" show-overflow-tooltip/>
      <el-table-column label="产品" prop="productName" min-width="140" show-overflow-tooltip/>
      <el-table-column label="数量" prop="quantity" width="80" align="center"/>
      <el-table-column label="交期" prop="dueDate" width="110" sortable="custom"/>
      <el-table-column label="订单状态" prop="orderStatus" width="100" align="center">
        <template #default="{row}">
          <el-tag :type="row.orderStatus==='已完成'?'success':row.orderStatus==='生产中'?'warning':'info'" effect="dark">{{row.orderStatus}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="发货状态" prop="deliveryStatus" width="100" align="center">
        <template #default="{row}">
          <el-tag :type="row.deliveryStatus==='已发货'?'success':'info'" effect="dark">{{row.deliveryStatus}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" prop="createTime" width="170" sortable="custom"/>
      <el-table-column label="操作" align="center" width="220" fixed="right">
        <template #default="{row}">
          <el-button link type="primary" icon="View" @click="handleDetail(row)">详情</el-button>
          <el-button v-hasPermi="['mes:order:edit']" link type="primary" icon="Edit" @click="handleUpdate(row)">编辑</el-button>
          <el-button v-hasPermi="['mes:order:remove']" link type="danger" icon="Delete" @click="handleDelete(row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" :total="total" @pagination="getList"/>

    <order-form v-model="formVisible" :data="currentRow" @success="getList"/>
    <order-detail v-model="detailVisible" :data="detailData"/>
  </div>
</template>

<script setup name="MesOrder">
import { getCurrentInstance, reactive, ref, toRefs, onMounted } from 'vue'
import OrderForm from './form.vue'
import OrderDetail from './detail.vue'
import { listOrder, getOrder, delOrder } from './api'

const { proxy } = getCurrentInstance()
const loading = ref(false)
const showSearch = ref(true)
const orderList = ref([])
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const formVisible = ref(false)
const detailVisible = ref(false)
const currentRow = ref({})
const detailData = ref({})

const data = reactive({
  queryParams: { pageNum:1, pageSize:10, orderNo:undefined, customerName:undefined, productName:undefined, orderStatus:undefined, orderByColumn:undefined, isAsc:undefined }
})
const { queryParams } = toRefs(data)

onMounted(() => { getList() })

function getList() {
  loading.value = true
  listOrder(queryParams.value).then(res => { orderList.value = res.rows || []; total.value = res.total || 0 }).finally(() => loading.value = false)
}
function handleQuery() { queryParams.value.pageNum = 1; getList() }
function resetQuery() { proxy.resetForm('queryRef'); handleQuery() }
function handleSelectionChange(s) { ids.value = s.map(i => i.orderId); single.value = s.length !== 1; multiple.value = s.length === 0 }
function handleSortChange({prop, order}) { queryParams.value.orderByColumn = prop; queryParams.value.isAsc = order === 'ascending' ? 'asc' : 'desc'; getList() }
function handleAdd() { currentRow.value = {}; formVisible.value = true }
async function handleUpdate(row) { const id = row?.orderId || ids.value[0]; const res = await getOrder(id); currentRow.value = res.data || {}; formVisible.value = true }
async function handleDetail(row) { const res = await getOrder(row.orderId); detailData.value = res.data || {}; detailVisible.value = true }
function handleDelete(row) {
  const oids = row?.orderId || ids.value.join(',')
  proxy.$modal.confirm(`确认删除订单编号为 "${oids}" 的数据项？`).then(() => delOrder(oids)).then(() => { getList(); proxy.$modal.msgSuccess('删除成功') })
}
function handleExport() { proxy.download('/api/mes/order/export', {...queryParams.value}, `order_${new Date().getTime()}.xlsx`) }
</script>

<style scoped>
.mes-order-page { background: #f5f7fa; }
.mes-search { padding: 16px 16px 0; margin-bottom: 12px; background: #fff; border: 1px solid #d7dde8; }
.mes-table { border-color: #c8d1df; }
.mes-table :deep(.el-table__header th) { background: #1f2a37; color: #e5eef8; }
</style>
