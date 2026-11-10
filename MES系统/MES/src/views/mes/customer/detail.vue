<template>
  <el-drawer :model-value="modelValue" title="客户详情" size="520px" append-to-body @close="emit('update:modelValue', false)">
    <el-descriptions v-if="data" :column="1" border class="mes-detail">
      <el-descriptions-item label="客户编码">{{ data.customerCode }}</el-descriptions-item>
      <el-descriptions-item label="客户名称">{{ data.customerName }}</el-descriptions-item>
      <el-descriptions-item label="状态">
        <el-tag :type="data.status === '0' ? 'success' : 'info'">
          {{ data.status === '0' ? '正常' : '停用' }}
        </el-tag>
      </el-descriptions-item>
      <el-descriptions-item label="联系人">{{ data.contactName || '-' }}</el-descriptions-item>
      <el-descriptions-item label="联系电话">{{ data.contactPhone || '-' }}</el-descriptions-item>
      <el-descriptions-item label="邮箱">{{ data.email || '-' }}</el-descriptions-item>
      <el-descriptions-item label="地址">{{ data.address || '-' }}</el-descriptions-item>
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
