import request from '@/utils/request'

export function listBom(query) {
  return request({
    url: '/api/mes/bom/list',
    method: 'get',
    params: query
  })
}

export function getBom(bomId) {
  return request({
    url: `/api/mes/bom/${bomId}`,
    method: 'get'
  })
}

export function addBom(data) {
  return request({
    url: '/api/mes/bom/create',
    method: 'post',
    data
  })
}

export function updateBom(data) {
  return request({
    url: '/api/mes/bom/update',
    method: 'post',
    data
  })
}

export function delBom(bomIds) {
  return request({
    url: `/api/mes/bom/delete/${bomIds}`,
    method: 'post'
  })
}
