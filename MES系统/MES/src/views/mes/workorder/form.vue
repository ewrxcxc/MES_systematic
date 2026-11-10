<template>
  <el-dialog :model-value="modelValue" :title="form.workOrderId?'编辑工单':'新增工单'" width="680px" append-to-body class="mes-dialog" @close="handleClose">
    <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
      <el-row :gutter="18">
        <el-col :span="12">
          <el-form-item label="工单编号" prop="workOrderNo">
            <el-input v-model.trim="form.workOrderNo" placeholder="留空自动生成" maxlength="50"/>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="关联订单" prop="orderId">
            <el-select v-model="form.orderId" placeholder="请选择销售订单" filterable style="width:100%">
              <el-option v-for="o in orderOptions" :key="o.orderId" :label="o.orderNo" :value="o.orderId"/>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="计划数量" prop="plannedQty">
            <el-input-number v-model="form.plannedQty" :min="1" style="width:100%"/>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="工单状态" prop="status">
            <el-select v-model="form.status" style="width:100%">
              <el-option label="WAITING" value="WAITING"/><el-option label="READY" value="READY"/>
              <el-option label="RUNNING" value="RUNNING"/><el-option label="PAUSED" value="PAUSED"/>
              <el-option label="FINISHED" value="FINISHED"/>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="计划开始" prop="plannedStart">
            <el-date-picker v-model="form.plannedStart" type="datetime" placeholder="选择时间" value-format="YYYY-MM-DD HH:mm:ss" style="width:100%"/>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="计划结束" prop="plannedEnd">
            <el-date-picker v-model="form.plannedEnd" type="datetime" placeholder="选择时间" value-format="YYYY-MM-DD HH:mm:ss" style="width:100%"/>
          </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="备注" prop="remark">
            <el-input v-model="form.remark" type="textarea" :rows="2" placeholder="备注" maxlength="500"/>
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>
    <template #footer>
      <el-button @click="handleClose">取消</el-button>
      <el-button type="primary" :loading="submitting" @click="submit">保存</el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import { getCurrentInstance, reactive, ref, watch, onMounted } from 'vue'
import { addWorkOrder, updateWorkOrder } from './api'
import { listOrder } from '@/api/mes/order'

const props = defineProps({ modelValue:{type:Boolean,default:false}, data:{type:Object,default:()=>({})} })
const emit = defineEmits(['update:modelValue','success'])
const { proxy } = getCurrentInstance()
const formRef = ref(); const submitting = ref(false); const orderOptions = ref([])

const emptyForm = { workOrderId:undefined, workOrderNo:'', orderId:undefined, plannedQty:undefined, completedQty:0, status:'WAITING', plannedStart:undefined, plannedEnd:undefined, remark:'' }
const form = reactive({...emptyForm})
const rules = { orderId: [{required:true,message:'请选择销售订单',trigger:'change'}], plannedQty: [{required:true,message:'请输入计划数量',trigger:'blur'}] }

onMounted(() => { listOrder({pageNum:1,pageSize:999}).then(r => { orderOptions.value = r.rows || [] }) })

watch(()=>props.modelValue, v => { if(v){ Object.assign(form, emptyForm, props.data||{}); formRef.value?.clearValidate() } })

function handleClose() { emit('update:modelValue', false) }
function submit() {
  formRef.value.validate(async valid => {
    if(!valid) return; submitting.value = true
    try {
      if(form.workOrderId) { await updateWorkOrder(form); proxy.$modal.msgSuccess('修改成功') }
      else { await addWorkOrder(form); proxy.$modal.msgSuccess('新增成功') }
      emit('success'); handleClose()
    } finally { submitting.value = false }
  })
}
</script>
<style scoped>.mes-dialog :deep(.el-dialog__body){padding-bottom:4px}</style>
