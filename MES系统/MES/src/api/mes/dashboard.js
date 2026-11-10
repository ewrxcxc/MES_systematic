import request from '@/utils/request'
export function getDashboardStats() { return request({ url:'/api/mes/dashboard/stats', method:'get' }) }
export function getOrderStatus() { return request({ url:'/api/mes/dashboard/orderStatus', method:'get' }) }
export function getEquipStatus() { return request({ url:'/api/mes/dashboard/equipStatus', method:'get' }) }
export function getInventoryStats() { return request({ url:'/api/mes/dashboard/inventoryStats', method:'get' }) }
export function getYieldTrend() { return request({ url:'/api/mes/dashboard/yieldTrend', method:'get' }) }
