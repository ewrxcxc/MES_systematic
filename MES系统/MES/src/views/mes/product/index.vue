<template>
  <div class="app-container mes-product-page">
    <el-form v-show="showSearch" ref="queryRef" :inline="true" :model="queryParams" class="mes-search">
      <el-form-item label="产品编码" prop="productCode">
        <el-input
          v-model.trim="queryParams.productCode"
          placeholder="请输入产品编码"
          clearable
          style="width: 220px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="产品名称" prop="productName">
        <el-input
          v-model.trim="queryParams.productName"
          placeholder="请输入产品名称"
          clearable
          style="width: 220px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="规格" prop="specification">
        <el-input
          v-model.trim="queryParams.specification"
          placeholder="请输入规格"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button v-hasPermi="['mes:product:add']" type="primary" plain icon="Plus" @click="handleAdd">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button v-hasPermi="['mes:product:edit']" type="success" plain icon="Edit" :disabled="single" @click="handleUpdate()">编辑</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button v-hasPermi="['mes:product:remove']" type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button v-hasPermi="['mes:product:export']" type="warning" plain icon="Download" @click="handleExport">导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table
      v-loading="loading"
      :data="productList"
      border
      stripe
      class="mes-table"
      @selection-change="handleSelectionChange"
      @sort-change="handleSortChange"
    >
      <el-table-column type="selection" width="50" align="center" />
      <el-table-column label="产品编码" prop="productCode" min-width="140" sortable="custom" show-overflow-tooltip />
      <el-table-column label="产品名称" prop="productName" min-width="180" sortable="custom" show-overflow-tooltip />
      <el-table-column label="规格" prop="specification" min-width="160" show-overflow-tooltip />
      <el-table-column label="单位" prop="unit" width="80" align="center" />
      <el-table-column label="创建时间" prop="createTime" width="170" sortable="custom" />
      <el-table-column label="操作" align="center" width="220" fixed="right">
        <template #default="{ row }">
          <el-button link type="primary" icon="View" @click="handleDetail(row)">详情</el-button>
          <el-button v-hasPermi="['mes:product:edit']" link type="primary" icon="Edit" @click="handleUpdate(row)">编辑</el-button>
          <el-button v-hasPermi="['mes:product:remove']" link type="danger" icon="Delete" @click="handleDelete(row)">删除</el-button>
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

    <product-form v-model="formVisible" :data="currentRow" @success="getList" />
    <product-detail v-model="detailVisible" :data="detailData" />
  </div>
</template>

<script setup name="MesProduct">
import { getCurrentInstance, reactive, ref, toRefs } from 'vue'
import ProductForm from './form.vue'
import ProductDetail from './detail.vue'
import { listProduct, getProduct, delProduct } from './api'

const { proxy } = getCurrentInstance()

const loading = ref(false)
const showSearch = ref(true)
const productList = ref([])
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
    productCode: undefined,
    productName: undefined,
    specification: undefined,
    orderByColumn: undefined,
    isAsc: undefined
  }
})

const { queryParams } = toRefs(data)

getList()

function getList() {
  loading.value = true
  listProduct(queryParams.value).then((response) => {
    productList.value = response.rows || []
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
  ids.value = selection.map((item) => item.productId)
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
  const productId = row?.productId || ids.value[0]
  const response = await getProduct(productId)
  currentRow.value = response.data || {}
  formVisible.value = true
}

async function handleDetail(row) {
  const response = await getProduct(row.productId)
  detailData.value = response.data || {}
  detailVisible.value = true
}

function handleDelete(row) {
  const productIds = row?.productId || ids.value.join(',')
  proxy.$modal.confirm(`确认删除产品编号为 "${productIds}" 的数据项？`).then(() => {
    return delProduct(productIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess('删除成功')
  })
}

function handleExport() {
  proxy.download('/api/mes/product/export', {
    ...queryParams.value
  }, `product_${new Date().getTime()}.xlsx`)
}
</script>

<style scoped>
.mes-product-page {
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
