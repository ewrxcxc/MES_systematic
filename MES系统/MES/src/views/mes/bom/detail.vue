<template>
  <el-drawer :model-value="modelValue" title="BOM详情" size="520px" append-to-body @close="emit('update:modelValue', false)">
    <el-descriptions v-if="data" :column="1" border class="mes-detail">
      <el-descriptions-item label="关联产品">{{ data.productName || '-' }}</el-descriptions-item>
      <el-descriptions-item label="物料名称">{{ data.materialName || '-' }}</el-descriptions-item>
      <el-descriptions-item label="物料编码">{{ data.materialCode || '-' }}</el-descriptions-item>
      <el-descriptions-item label="用量">{{ data.usageQty || '-' }}</el-descriptions-item>
      <el-descriptions-item label="创建时间">{{ data.createTime || '-' }}</el-descriptions-item>
      <el-descriptions-item label="更新时间">{{ data.updateTime || '-' }}</el-descriptions-item>
      <el-descriptions-item label="备注">{{ data.remark || '-' }}</el-descriptions-item>
    </el-descriptions>
  </el-drawer>
</template>

<script setup>
defineProps({
  modelValue: {
    type: Boolean,
    default: false
  },
  data: {
    type: Object,
    default: () => ({})
  }
})

const emit = defineEmits(['update:modelValue'])
</script>

<style scoped>
.mes-detail {
  margin: 0 4px;
}
</style>
