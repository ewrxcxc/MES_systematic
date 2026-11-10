import request from '@/utils/request'
export function listReport(q) { return request({ url:'/api/mes/report/list', method:'get', params:q }) }
export function getReport(id) { return request({ url:`/api/mes/report/${id}`, method:'get' }) }
export function addReport(d) { return request({ url:'/api/mes/report/create', method:'post', data:d }) }
export function updateReport(d) { return request({ url:'/api/mes/report/update', method:'post', data:d }) }
export function delReport(ids) { return request({ url:`/api/mes/report/delete/${ids}`, method:'post' }) }
