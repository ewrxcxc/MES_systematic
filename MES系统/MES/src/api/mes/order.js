import request from '@/utils/request'

export function listOrder(query) {
  return request({ url: '/api/mes/order/list', method: 'get', params: query })
}

export function getOrder(orderId) {
  return request({ url: `/api/mes/order/${orderId}`, method: 'get' })
}

export function addOrder(data) {
  return request({ url: '/api/mes/order/create', method: 'post', data })
}

export function updateOrder(data) {
  return request({ url: '/api/mes/order/update', method: 'post', data })
}

export function delOrder(orderIds) {
  return request({ url: `/api/mes/order/delete/${orderIds}`, method: 'post' })
}
