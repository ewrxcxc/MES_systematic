import request from '@/utils/request'
export function listInventory(q) { return request({ url:'/api/mes/inventory/list', method:'get', params:q }) }
export function getInventory(id) { return request({ url:`/api/mes/inventory/${id}`, method:'get' }) }
export function addInventory(d) { return request({ url:'/api/mes/inventory/create', method:'post', data:d }) }
export function updateInventory(d) { return request({ url:'/api/mes/inventory/update', method:'post', data:d }) }
export function delInventory(ids) { return request({ url:`/api/mes/inventory/delete/${ids}`, method:'post' }) }
