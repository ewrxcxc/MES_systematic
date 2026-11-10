<template>
  <el-drawer :model-value="modelValue" title="订单详情" size="520px" append-to-body @close="emit('update:modelValue',false)">
    <el-descriptions v-if="data" :column="1" border class="mes-detail">
      <el-descriptions-item label="订单编号">{{data.orderNo}}</el-descriptions-item>
      <el-descriptions-item label="客户">{{data.customerName||'-'}}</el-descriptions-item>
      <el-descriptions-item label="产品">{{data.productName||'-'}}</el-descriptions-item>
      <el-descriptions-item label="数量">{{data.quantity||'-'}}</el-descriptions-item>
      <el-descriptions-item label="交期">{{data.dueDate||'-'}}</el-descriptions-item>
      <el-descriptions-item label="收货人">{{data.consignee||'-'}}</el-descriptions-item>
      <el-descriptions-item label="联系电话">{{data.consigneePhone||'-'}}</el-descriptions-item>
      <el-descriptions-item label="收货地址">{{data.deliveryAddress||'-'}}</el-descriptions-item>
      <el-descriptions-item label="订单状态"><el-tag :type="data.orderStatus==='已完成'?'success':data.orderStatus==='生产中'?'warning':'info'" effect="dark">{{data.orderStatus}}</el-tag></el-descriptions-item>
      <el-descriptions-item label="发货状态"><el-tag :type="data.deliveryStatus==='已发货'?'success':'info'" effect="dark">{{data.deliveryStatus}}</el-tag></el-descriptions-item>
      <el-descriptions-item label="创建时间">{{data.createTime||'-'}}</el-descriptions-item>
      <el-descriptions-item label="更新时间">{{data.updateTime||'-'}}</el-descriptions-item>
      <el-descriptions-item label="备注">{{data.remark||'-'}}</el-descriptions-item>
    </el-descriptions>
  </el-drawer>
</template>

<script setup>
defineProps({ modelValue:{type:Boolean,default:false}, data:{type:Object,default:()=>({})} })
const emit = defineEmits(['update:modelValue'])
</script>

<style scoped>.mes-detail{margin:0 4px}</style>
