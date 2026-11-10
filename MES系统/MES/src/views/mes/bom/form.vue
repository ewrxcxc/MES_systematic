<template>
  <el-dialog
    :model-value="modelValue"
    :title="form.bomId ? '编辑BOM' : '新增BOM'"
    width="680px"
    append-to-body
    class="mes-bom-dialog"
    @close="handleClose"
  >
    <el-form ref="formRef" :model="form" :rules="rules" label-width="96px">
      <el-row :gutter="18">
        <el-col :span="12">
          <el-form-item label="关联产品" prop="productId">
            <el-select v-model="form.productId" placeholder="请选择产品" clearable filterable style="width: 100%">
              <el-option
                v-for="p in productOptions"
                :key="p.productId"
                :label="p.productName"
                :value="p.productId"
              />
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="物料名称" prop="materialName">
            <el-input v-model.trim="form.materialName" placeholder="请输入物料名称" maxlength="100" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="物料编码" prop="materialCode">
            <el-input v-model.trim="form.materialCode" placeholder="请输入物料编码" maxlength="50" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="用量" prop="usageQty">
            <el-input-number v-model="form.usageQty" :precision="2" :min="0" :step="0.1" placeholder="请输入用量" style="width: 100%" />
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
import { getCurrentInstance, reactive, ref, watch, onMounted } from 'vue'
import { addBom, updateBom } from './api'
import { listProduct } from '@/api/mes/product'

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
const productOptions = ref([])

const emptyForm = {
  bomId: undefined,
  productId: undefined,
  materialName: '',
  materialCode: '',
  usageQty: undefined,
  remark: ''
}

const form = reactive({ ...emptyForm })

const rules = {
  productId: [{ required: true, message: '请选择关联产品', trigger: 'change' }],
  materialName: [{ required: true, message: '物料名称不能为空', trigger: 'blur' }]
}

onMounted(() => {
  listProduct({ pageNum: 1, pageSize: 999 }).then(res => {
    productOptions.value = res.rows || []
  })
})

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
      if (form.bomId) {
        await updateBom(form)
        proxy.$modal.msgSuccess('修改成功')
      } else {
        await addBom(form)
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
.mes-bom-dialog :deep(.el-dialog__body) {
  padding-bottom: 4px;
}
</style>
