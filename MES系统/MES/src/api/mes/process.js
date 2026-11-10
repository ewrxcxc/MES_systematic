import request from '@/utils/request'

export function getTasksByWorkOrder(workOrderId) {
  return request({ url: `/api/mes/process/tasks/${workOrderId}`, method: 'get' })
}

export function startTask(taskId, operatorId, equipmentId) {
  return request({ url: `/api/mes/process/start/${taskId}`, method: 'post', params: { operatorId, equipmentId } })
}

export function finishTask(taskId, goodQty, badQty) {
  return request({ url: `/api/mes/process/finish/${taskId}`, method: 'post', params: { goodQty, badQty } })
}
