import request from '@/utils/request'

export function listWorkOrder(query) {
  return request({ url: '/api/mes/workorder/list', method: 'get', params: query })
}
export function getWorkOrder(id) {
  return request({ url: `/api/mes/workorder/${id}`, method: 'get' })
}
export function addWorkOrder(data) {
  return request({ url: '/api/mes/workorder/create', method: 'post', data })
}
export function updateWorkOrder(data) {
  return request({ url: '/api/mes/workorder/update', method: 'post', data })
}
export function delWorkOrder(ids) {
  return request({ url: `/api/mes/workorder/delete/${ids}`, method: 'post' })
}
export function startWorkOrder(id) {
  return request({ url: `/api/mes/workorder/start/${id}`, method: 'post' })
}
export function finishWorkOrder(id, completedQty) {
  return request({ url: `/api/mes/workorder/finish/${id}`, method: 'post', data: { completedQty } })
}
