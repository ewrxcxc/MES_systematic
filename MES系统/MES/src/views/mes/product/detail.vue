<template>
  <el-drawer :model-value="modelValue" title="产品详情" size="520px" append-to-body @close="emit('update:modelValue', false)">
    <el-descriptions v-if="data" :column="1" border class="mes-detail">
      <el-descriptions-item label="产品编码">{{ data.productCode }}</el-descriptions-item>
      <el-descriptions-item label="产品名称">{{ data.productName }}</el-descriptions-item>
      <el-descriptions-item label="规格">{{ data.specification || '-' }}</el-descriptions-item>
      <el-descriptions-item label="单位">{{ data.unit || '-' }}</el-descriptions-item>
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
