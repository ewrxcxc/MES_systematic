<template>
  <div class="app-container mes-bom-page">
    <el-form v-show="showSearch" ref="queryRef" :inline="true" :model="queryParams" class="mes-search">
      <el-form-item label="产品" prop="productId">
        <el-select v-model="queryParams.productId" placeholder="请选择产品" clearable filterable style="width: 200px">
          <el-option
            v-for="p in productOptions"
            :key="p.productId"
            :label="p.productName"
            :value="p.productId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="物料名称" prop="materialName">
        <el-input
          v-model.trim="queryParams.materialName"
          placeholder="请输入物料名称"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="物料编码" prop="materialCode">
        <el-input
          v-model.trim="queryParams.materialCode"
          placeholder="请输入物料编码"
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
        <el-button v-hasPermi="['mes:bom:add']" type="primary" plain icon="Plus" @click="handleAdd">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button v-hasPermi="['mes:bom:edit']" type="success" plain icon="Edit" :disabled="single" @click="handleUpdate()">编辑</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button v-hasPermi="['mes:bom:remove']" type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button v-hasPermi="['mes:bom:export']" type="warning" plain icon="Download" @click="handleExport">导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table
      v-loading="loading"
      :data="bomList"
      border
      stripe
      class="mes-table"
      @selection-change="handleSelectionChange"
      @sort-change="handleSortChange"
    >
      <el-table-column type="selection" width="50" align="center" />
      <el-table-column label="关联产品" prop="productName" min-width="160" show-overflow-tooltip />
      <el-table-column label="物料名称" prop="materialName" min-width="160" show-overflow-tooltip />
      <el-table-column label="物料编码" prop="materialCode" min-width="140" show-overflow-tooltip />
      <el-table-column label="用量" prop="usageQty" width="100" align="center" />
      <el-table-column label="创建时间" prop="createTime" width="170" sortable="custom" />
      <el-table-column label="操作" align="center" width="220" fixed="right">
        <template #default="{ row }">
          <el-button link type="primary" icon="View" @click="handleDetail(row)">详情</el-button>
          <el-button v-hasPermi="['mes:bom:edit']" link type="primary" icon="Edit" @click="handleUpdate(row)">编辑</el-button>
          <el-button v-hasPermi="['mes:bom:remove']" link type="danger" icon="Delete" @click="handleDelete(row)">删除</el-button>
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

    <bom-form v-model="formVisible" :data="currentRow" @success="getList" />
    <bom-detail v-model="detailVisible" :data="detailData" />
  </div>
</template>

<script setup name="MesBom">
import { getCurrentInstance, reactive, ref, toRefs, onMounted } from 'vue'
import BomForm from './form.vue'
import BomDetail from './detail.vue'
import { listBom, getBom, delBom } from './api'
import { listProduct } from '@/api/mes/product'

const { proxy } = getCurrentInstance()

const loading = ref(false)
const showSearch = ref(true)
const bomList = ref([])
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const formVisible = ref(false)
const detailVisible = ref(false)
const currentRow = ref({})
const detailData = ref({})
const productOptions = ref([])

const data = reactive({
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    productId: undefined,
    materialName: undefined,
    materialCode: undefined,
    orderByColumn: undefined,
    isAsc: undefined
  }
})

const { queryParams } = toRefs(data)

onMounted(() => {
  loadProducts()
  getList()
})

function loadProducts() {
  listProduct({ pageNum: 1, pageSize: 999 }).then(res => {
    productOptions.value = res.rows || []
  })
}

function getList() {
  loading.value = true
  listBom(queryParams.value).then((response) => {
    bomList.value = response.rows || []
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
  ids.value = selection.map((item) => item.bomId)
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
  const bomId = row?.bomId || ids.value[0]
  const response = await getBom(bomId)
  currentRow.value = response.data || {}
  formVisible.value = true
}

async function handleDetail(row) {
  const response = await getBom(row.bomId)
  detailData.value = response.data || {}
  detailVisible.value = true
}

function handleDelete(row) {
  const bomIds = row?.bomId || ids.value.join(',')
  proxy.$modal.confirm(`确认删除BOM编号为 "${bomIds}" 的数据项？`).then(() => {
    return delBom(bomIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess('删除成功')
  })
}

function handleExport() {
  proxy.download('/api/mes/bom/export', {
    ...queryParams.value
  }, `bom_${new Date().getTime()}.xlsx`)
}
</script>

<style scoped>
.mes-bom-page {
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
