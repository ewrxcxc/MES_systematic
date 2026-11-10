<template>
  <el-drawer :model-value="modelValue" title="工单详情" size="600px" append-to-body @close="emit('update:modelValue',false)">
    <el-descriptions v-if="data" :column="1" border class="mes-detail">
      <el-descriptions-item label="工单编号">{{data.workOrderNo}}</el-descriptions-item>
      <el-descriptions-item label="关联订单">{{data.orderNo||'-'}}</el-descriptions-item>
      <el-descriptions-item label="计划数量">{{data.plannedQty||'-'}}</el-descriptions-item>
      <el-descriptions-item label="完成数量">{{data.completedQty||0}}</el-descriptions-item>
      <el-descriptions-item label="工单状态"><el-tag :type="data.status==='FINISHED'?'success':data.status==='RUNNING'?'warning':data.status==='PAUSED'?'danger':'info'" effect="dark">{{data.status}}</el-tag></el-descriptions-item>
      <el-descriptions-item label="计划开始">{{data.plannedStart||'-'}}</el-descriptions-item>
      <el-descriptions-item label="计划结束">{{data.plannedEnd||'-'}}</el-descriptions-item>
      <el-descriptions-item label="当前工序">{{currentProcessName}}</el-descriptions-item>
      <el-descriptions-item label="工序进度">
        <div class="process-progress">
          <el-progress :percentage="processProgress" :stroke-width="14" color="#409EFF">
            <span style="font-size:12px">{{processProgress}}%</span>
          </el-progress>
        </div>
      </el-descriptions-item>
      <el-descriptions-item label="工序流程">
        <div class="process-flow">
          <div v-for="(step, index) in processSteps" :key="index" class="process-step">
            <div class="step-icon">
              <i v-if="index < currentStepIndex" class="el-icon-check" style="color:#67C23A"></i>
              <i v-else-if="index === currentStepIndex" class="el-icon-loading" style="color:#409EFF"></i>
              <span v-else>{{index + 1}}</span>
            </div>
            <div class="step-info">
              <span class="step-name" :class="{active: index === currentStepIndex, completed: index < currentStepIndex}">{{step.name}}</span>
              <span class="step-desc">{{step.desc}}</span>
            </div>
            <div v-if="index < processSteps.length - 1" class="step-arrow">
              <i class="el-icon-arrow-down" :style="{color: index < currentStepIndex ? '#67C23A' : '#DCDFE6'}"></i>
            </div>
          </div>
        </div>
      </el-descriptions-item>
      <el-descriptions-item label="创建时间">{{data.createTime||'-'}}</el-descriptions-item>
      <el-descriptions-item label="更新时间">{{data.updateTime||'-'}}</el-descriptions-item>
      <el-descriptions-item label="备注">{{data.remark||'-'}}</el-descriptions-item>
    </el-descriptions>
  </el-drawer>
</template>

<script setup>
import { ref, computed } from 'vue'

const props = defineProps({ 
  modelValue:{type:Boolean,default:false}, 
  data:{type:Object,default:()=>({})} 
})
const emit = defineEmits(['update:modelValue'])

const currentStepIndex = ref(0)

const processSteps = [
  { name: '原材料领料', desc: '从仓库领取生产所需原材料' },
  { name: 'CNC 加工', desc: '数控机床精密加工' },
  { name: '打磨处理', desc: '表面打磨抛光处理' },
  { name: '喷砂/氧化', desc: '表面喷砂处理或阳极氧化' },
  { name: '组装', desc: '零部件组装装配' },
  { name: '功能检测', desc: '产品功能性能检测' },
  { name: '包装入库', desc: '包装成品入库' }
]

const currentProcessName = computed(() => {
  return processSteps[currentStepIndex.value]?.name || '-'
})

const processProgress = computed(() => {
  return Math.round((currentStepIndex.value / (processSteps.length - 1)) * 100)
})
</script>

<style scoped>
.mes-detail{margin:0 4px}
.process-progress{padding:4px 0}
.process-flow{padding:8px 0}
.process-step{display:flex;align-items:center;margin-bottom:12px}
.step-icon{width:32px;height:32px;border-radius:50%;background:#F5F7FA;border:2px solid #DCDFE6;display:flex;align-items:center;justify-content:center;font-size:14px;color:#909399;margin-right:12px;flex-shrink:0}
.step-info{flex:1;min-width:0}
.step-name{display:block;font-size:14px;font-weight:500;color:#303133}
.step-name.active{color:#409EFF}
.step-name.completed{color:#67C23A}
.step-desc{display:block;font-size:12px;color:#909399;margin-top:2px}
.step-arrow{color:#DCDFE6;margin-left:8px}
</style>
