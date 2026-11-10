import request from '@/utils/request'
export function listEquipment(q) { return request({ url:'/api/mes/equipment/list', method:'get', params:q }) }
export function getEquipment(id) { return request({ url:`/api/mes/equipment/${id}`, method:'get' }) }
export function addEquipment(d) { return request({ url:'/api/mes/equipment/create', method:'post', data:d }) }
export function updateEquipment(d) { return request({ url:'/api/mes/equipment/update', method:'post', data:d }) }
export function delEquipment(ids) { return request({ url:`/api/mes/equipment/delete/${ids}`, method:'post' }) }
