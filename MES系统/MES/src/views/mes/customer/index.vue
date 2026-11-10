<template>
  <div class="app-container mes-customer-page">
    <el-form v-show="showSearch" ref="queryRef" :inline="true" :model="queryParams" class="mes-search">
      <el-form-item label="客户编码" prop="customerCode">
        <el-input
          v-model.trim="queryParams.customerCode"
          placeholder="请输入客户编码"
          clearable
          style="width: 220px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="客户名称" prop="customerName">
        <el-input
          v-model.trim="queryParams.customerName"
          placeholder="请输入客户名称"
          clearable
          style="width: 220px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="联系电话" prop="contactPhone">
        <el-input
          v-model.trim="queryParams.contactPhone"
          placeholder="请输入联系电话"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable style="width: 140px">
          <el-option label="正常" value="0" />
          <el-option label="停用" value="1" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button v-hasPermi="['mes:customer:add']" type="primary" plain icon="Plus" @click="handleAdd">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button v-hasPermi="['mes:customer:edit']" type="success" plain icon="Edit" :disabled="single" @click="handleUpdate()">编辑</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button v-hasPermi="['mes:customer:remove']" type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button v-hasPermi="['mes:customer:export']" type="warning" plain icon="Download" @click="handleExport">导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table
      v-loading="loading"
      :data="customerList"
      border
      stripe
      class="mes-table"
      @selection-change="handleSelectionChange"
      @sort-change="handleSortChange"
    >
      <el-table-column type="selection" width="50" align="center" />
      <el-table-column label="客户编码" prop="customerCode" min-width="140" sortable="custom" show-overflow-tooltip />
      <el-table-column label="客户名称" prop="customerName" min-width="180" sortable="custom" show-overflow-tooltip />
      <el-table-column label="联系人" prop="contactName" width="120" show-overflow-tooltip />
      <el-table-column label="联系电话" prop="contactPhone" width="150" show-overflow-tooltip />
      <el-table-column label="邮箱" prop="email" min-width="170" show-overflow-tooltip />
      <el-table-column label="状态" prop="status" width="90" align="center" sortable="custom">
        <template #default="{ row }">
          <el-tag :type="row.status === '0' ? 'success' : 'info'" effect="dark">
            {{ row.status === '0' ? '正常' : '停用' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" prop="createTime" width="170" sortable="custom" />
      <el-table-column label="操作" align="center" width="220" fixed="right">
        <template #default="{ row }">
          <el-button link type="primary" icon="View" @click="handleDetail(row)">详情</el-button>
          <el-button v-hasPermi="['mes:customer:edit']" link type="primary" icon="Edit" @click="handleUpdate(row)">编辑</el-button>
          <el-button v-hasPermi="['mes:customer:remove']" link type="danger" icon="Delete" @click="handleDelete(row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      :total="total"
      @pagination="getList"
    />

    <customer-form v-model="formVisible" :data="currentRow" @success="getList" />
    <customer-detail v-model="detailVisible" :data="detailData" />
  </div>
</template>

<script setup name="MesCustomer">
import { getCurrentInstance, reactive, ref, toRefs } from 'vue'
import CustomerForm from './form.vue'
import CustomerDetail from './detail.vue'
import { listCustomer, getCustomer, delCustomer } from './api'

const { proxy } = getCurrentInstance()

const loading = ref(false)
const showSearch = ref(true)
const customerList = ref([])
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const formVisible = ref(false)
const detailVisible = ref(false)
const currentRow = ref({})
const detailData = ref({})

const data = reactive({
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    customerCode: undefined,
    customerName: undefined,
    contactPhone: undefined,
    status: undefined,
    orderByColumn: undefined,
    isAsc: undefined
  }
})

const { queryParams } = toRefs(data)

getList()

function getList() {
  loading.value = true
  listCustomer(queryParams.value).then((response) => {
    customerList.value = response.rows || []
    total.value = response.total || 0
  }).finally(() => {
    loading.value = false
  })
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm('queryRef')
  handleQuery()
}

function handleSelectionChange(selection) {
  ids.value = selection.map((item) => item.customerId)
  single.value = selection.length !== 1
  multiple.value = selection.length === 0
}

function handleSortChange({ prop, order }) {
  queryParams.value.orderByColumn = prop
  queryParams.value.isAsc = order === 'ascending' ? 'asc' : 'desc'
  getList()
}

function handleAdd() {
  currentRow.value = {}
  formVisible.value = true
}

async function handleUpdate(row) {
  const customerId = row?.customerId || ids.value[0]
  const response = await getCustomer(customerId)
  currentRow.value = response.data || {}
  formVisible.value = true
}

async function handleDetail(row) {
  const response = await getCustomer(row.customerId)
  detailData.value = response.data || {}
  detailVisible.value = true
}

function handleDelete(row) {
  const customerIds = row?.customerId || ids.value.join(',')
  proxy.$modal.confirm(`确认删除客户编号为 "${customerIds}" 的数据项？`).then(() => {
    return delCustomer(customerIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess('删除成功')
  })
}

function handleExport() {
  proxy.download('/api/mes/customer/export', {
    ...queryParams.value
  }, `customer_${new Date().getTime()}.xlsx`)
}
</script>

<style scoped>
.mes-customer-page {
  background: #f5f7fa;
}

.mes-search {
  padding: 16px 16px 0;
  margin-bottom: 12px;
  background: #ffffff;
  border: 1px solid #d7dde8;
}

.mes-table {
  border-color: #c8d1df;
}

.mes-table :deep(.el-table__header th) {
  background: #1f2a37;
  color: #e5eef8;
}
</style>
