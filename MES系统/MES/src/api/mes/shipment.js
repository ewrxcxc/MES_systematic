import request from '@/utils/request'
export function listShipment(q) { return request({ url:'/api/mes/shipment/list', method:'get', params:q }) }
export function getShipment(id) { return request({ url:`/api/mes/shipment/${id}`, method:'get' }) }
export function addShipment(d) { return request({ url:'/api/mes/shipment/create', method:'post', data:d }) }
export function updateShipment(d) { return request({ url:'/api/mes/shipment/update', method:'post', data:d }) }
export function delShipment(ids) { return request({ url:`/api/mes/shipment/delete/${ids}`, method:'post' }) }
