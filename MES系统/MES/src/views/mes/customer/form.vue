<template>
  <el-dialog
    :model-value="modelValue"
    :title="form.customerId ? '编辑客户' : '新增客户'"
    width="720px"
    append-to-body
    class="mes-customer-dialog"
    @close="handleClose"
  >
    <el-form ref="formRef" :model="form" :rules="rules" label-width="96px">
      <el-row :gutter="18">
        <el-col :span="12">
          <el-form-item label="客户编码" prop="customerCode">
            <el-input v-model.trim="form.customerCode" placeholder="请输入客户编码" maxlength="64" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="客户名称" prop="customerName">
            <el-input v-model.trim="form.customerName" placeholder="请输入客户名称" maxlength="128" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="联系人" prop="contactName">
            <el-input v-model.trim="form.contactName" placeholder="请输入联系人" maxlength="64" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="联系电话" prop="contactPhone">
            <el-input v-model.trim="form.contactPhone" placeholder="请输入联系电话" maxlength="32" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="邮箱" prop="email">
            <el-input v-model.trim="form.email" placeholder="请输入邮箱" maxlength="128" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="状态" prop="status">
            <el-radio-group v-model="form.status">
              <el-radio-button label="0">正常</el-radio-button>
              <el-radio-button label="1">停用</el-radio-button>
            </el-radio-group>
          </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="地址" prop="address">
            <el-input v-model.trim="form.address" placeholder="请输入客户地址" maxlength="255" />
          </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="备注" prop="remark">
            <el-input v-model="form.remark" type="textarea" :rows="3" placeholder="请输入备注" maxlength="500" />
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
import { addCustomer, updateCustomer, checkCustomerCodeUnique } from './api'

const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false
  },
  data: {
    type: Object,
    default: () => ({})
  }
})

const emit = defineEmits(['update:modelValue', 'success'])

const { proxy } = getCurrentInstance()
const formRef = ref()
const submitting = ref(false)

const emptyForm = {
  customerId: undefined,
  customerCode: '',
  customerName: '',
  contactName: '',
  contactPhone: '',
  email: '',
  address: '',
  status: '0',
  remark: ''
}

const form = reactive({ ...emptyForm })

const validateCodeUnique = async (rule, value, callback) => {
  if (!value) {
    callback()
    return
  }
  try {
    const res = await checkCustomerCodeUnique({
      customerId: form.customerId,
      customerCode: value
    })
    if (res.data === false) {
      callback(new Error('客户编码已存在'))
    } else {
      callback()
    }
  } catch (error) {
    callback(new Error('客户编码校验失败'))
  }
}

const rules = {
  customerCode: [
    { required: true, message: '客户编码不能为空', trigger: 'blur' },
    { validator: validateCodeUnique, trigger: 'blur' }
  ],
  customerName: [{ required: true, message: '客户名称不能为空', trigger: 'blur' }],
  contactPhone: [
    { pattern: /^[0-9+\-\s()]{6,32}$/, message: '联系电话格式不正确', trigger: 'blur' }
  ],
  email: [{ type: 'email', message: '邮箱格式不正确', trigger: 'blur' }],
  status: [{ required: true, message: '状态不能为空', trigger: 'change' }]
}

watch(
  () => props.modelValue,
  (visible) => {
    if (visible) {
      Object.assign(form, emptyForm, props.data || {})
      form.status = form.status || '0'
      formRef.value?.clearValidate()
    }
  }
)

function handleClose() {
  emit('update:modelValue', false)
}

function submit() {
  formRef.value.validate(async (valid) => {
    if (!valid) return
    submitting.value = true
    try {
      if (form.customerId) {
        await updateCustomer(form)
        proxy.$modal.msgSuccess('修改成功')
      } else {
        await addCustomer(form)
        proxy.$modal.msgSuccess('新增成功')
      }
      emit('success')
      handleClose()
    } finally {
      submitting.value = false
    }
  })
}
</script>

<style scoped>
.mes-customer-dialog :deep(.el-dialog__body) {
  padding-bottom: 4px;
}
</style>
