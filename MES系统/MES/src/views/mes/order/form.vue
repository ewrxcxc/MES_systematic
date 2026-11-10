<template>
  <el-dialog :model-value="modelValue" :title="form.orderId?'编辑订单':'新增订单'" width="720px" append-to-body class="mes-dialog" @close="handleClose">
    <el-form ref="formRef" :model="form" :rules="rules" label-width="96px">
      <el-row :gutter="18">
        <el-col :span="12">
          <el-form-item label="订单编号" prop="orderNo">
            <el-input v-model.trim="form.orderNo" placeholder="留空自动生成" maxlength="50"/>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="客户" prop="customerName">
            <el-input v-model.trim="form.customerName" placeholder="请输入客户名称" maxlength="100"/>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="产品" prop="productName">
            <el-input v-model.trim="form.productName" placeholder="请输入产品名称" maxlength="100"/>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="数量" prop="quantity">
            <el-input-number v-model="form.quantity" :min="1" style="width:100%"/>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="交期" prop="dueDate">
            <el-date-picker v-model="form.dueDate" type="date" placeholder="选择交期" value-format="YYYY-MM-DD" style="width:100%"/>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="订单状态" prop="orderStatus">
            <el-select v-model="form.orderStatus" style="width:100%">
              <el-option label="待处理" value="待处理"/>
              <el-option label="生产中" value="生产中"/>
              <el-option label="已完成" value="已完成"/>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="收货人" prop="consignee">
            <el-input v-model.trim="form.consignee" placeholder="收货人" maxlength="50"/>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="联系电话" prop="consigneePhone">
            <el-input v-model.trim="form.consigneePhone" placeholder="联系电话" maxlength="20"/>
          </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="收货地址" prop="deliveryAddress">
            <el-input v-model.trim="form.deliveryAddress" placeholder="收货地址" maxlength="255"/>
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
import { getCurrentInstance, reactive, ref, watch } from 'vue'
import { addOrder, updateOrder } from './api'

const props = defineProps({ modelValue:{type:Boolean,default:false}, data:{type:Object,default:()=>({})} })
const emit = defineEmits(['update:modelValue','success'])
const { proxy } = getCurrentInstance()
const formRef = ref()
const submitting = ref(false)

const emptyForm = { orderId:undefined, orderNo:'', customerName:'', productName:'', quantity:undefined, dueDate:undefined, consignee:'', consigneePhone:'', deliveryAddress:'', orderStatus:'待处理', remark:'' }
const form = reactive({...emptyForm})
const rules = {
  customerName: [{required:true,message:'请输入客户名称',trigger:'blur'}],
  productName: [{required:true,message:'请输入产品名称',trigger:'blur'}],
  quantity: [{required:true,message:'请输入数量',trigger:'blur'}]
}

watch(()=>props.modelValue, v=>{ if(v){ Object.assign(form,emptyForm,props.data||{}); formRef.value?.clearValidate() } })

function handleClose() { emit('update:modelValue',false) }
function submit() {
  formRef.value.validate(async valid => {
    if(!valid) return
    submitting.value = true
    try {
      if(form.orderId) { await updateOrder(form); proxy.$modal.msgSuccess('修改成功') }
      else { await addOrder(form); proxy.$modal.msgSuccess('新增成功') }
      emit('success'); handleClose()
    } finally { submitting.value = false }
  })
}
</script>

<style scoped>.mes-dialog :deep(.el-dialog__body){padding-bottom:4px}</style>
