import request from '@/utils/request'

export function listProduct(query) {
  return request({
    url: '/api/mes/product/list',
    method: 'get',
    params: query
  })
}

export function getProduct(productId) {
  return request({
    url: `/api/mes/product/${productId}`,
    method: 'get'
  })
}

export function addProduct(data) {
  return request({
    url: '/api/mes/product/create',
    method: 'post',
    data
  })
}

export function updateProduct(data) {
  return request({
    url: '/api/mes/product/update',
    method: 'post',
    data
  })
}

export function delProduct(productIds) {
  return request({
    url: `/api/mes/product/delete/${productIds}`,
    method: 'post'
  })
}

export function checkProductCodeUnique(data) {
  return request({
    url: '/api/mes/product/checkCodeUnique',
    method: 'post',
    data
  })
}
