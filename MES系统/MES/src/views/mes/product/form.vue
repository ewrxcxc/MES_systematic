<template>
  <el-dialog
    :model-value="modelValue"
    :title="form.productId ? '编辑产品' : '新增产品'"
    width="680px"
    append-to-body
    class="mes-product-dialog"
    @close="handleClose"
  >
    <el-form ref="formRef" :model="form" :rules="rules" label-width="96px">
      <el-row :gutter="18">
        <el-col :span="12">
          <el-form-item label="产品编码" prop="productCode">
            <el-input v-model.trim="form.productCode" placeholder="请输入产品编码" maxlength="50" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="产品名称" prop="productName">
            <el-input v-model.trim="form.productName" placeholder="请输入产品名称" maxlength="100" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="规格" prop="specification">
            <el-input v-model.trim="form.specification" placeholder="请输入规格" maxlength="255" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="单位" prop="unit">
            <el-input v-model.trim="form.unit" placeholder="请输入单位" maxlength="20" />
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
import { addProduct, updateProduct, checkProductCodeUnique } from './api'

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
  productId: undefined,
  productCode: '',
  productName: '',
  specification: '',
  unit: '',
  remark: ''
}

const form = reactive({ ...emptyForm })

const validateCodeUnique = async (rule, value, callback) => {
  if (!value) {
    callback()
    return
  }
  try {
    const res = await checkProductCodeUnique({
      productId: form.productId,
      productCode: value
    })
    if (res.data === false) {
      callback(new Error('产品编码已存在'))
    } else {
      callback()
    }
  } catch (error) {
    callback(new Error('产品编码校验失败'))
  }
}

const rules = {
  productCode: [
    { required: true, message: '产品编码不能为空', trigger: 'blur' },
    { validator: validateCodeUnique, trigger: 'blur' }
  ],
  productName: [{ required: true, message: '产品名称不能为空', trigger: 'blur' }]
}

watch(
  () => props.modelValue,
  (visible) => {
    if (visible) {
      Object.assign(form, emptyForm, props.data || {})
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
      if (form.productId) {
        await updateProduct(form)
        proxy.$modal.msgSuccess('修改成功')
      } else {
        await addProduct(form)
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
.mes-product-dialog :deep(.el-dialog__body) {
  padding-bottom: 4px;
}
</style>
