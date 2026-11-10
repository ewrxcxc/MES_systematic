import request from '@/utils/request'

export function listCustomer(query) {
  return request({
    url: '/api/mes/customer/list',
    method: 'get',
    params: query
  })
}

export function getCustomer(customerId) {
  return request({
    url: `/api/mes/customer/${customerId}`,
    method: 'get'
  })
}

export function addCustomer(data) {
  return request({
    url: '/api/mes/customer/create',
    method: 'post',
    data
  })
}

export function updateCustomer(data) {
  return request({
    url: '/api/mes/customer/update',
    method: 'post',
    data
  })
}

export function delCustomer(customerIds) {
  return request({
    url: `/api/mes/customer/delete/${customerIds}`,
    method: 'post'
  })
}

export function checkCustomerCodeUnique(data) {
  return request({
    url: '/api/mes/customer/checkCodeUnique',
    method: 'post',
    data
  })
}
