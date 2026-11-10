/**
 * MES 质量追溯 — 真实数据链路: SO → WO → 工序 → 质检
 */
var MES_TRACE = (function() {

  var ctx = window.ctx || '';
  var apiPrefix = ctx + 'api/mes/trace';
  var orderCache = {};

  /* ==================== 初始化 ==================== */

  function init() {
    initOrderDropdown();
    initTraceTable();
    console.log('[MES_TRACE] 初始化完成');
  }

  /* ==================== 订单下拉 ==================== */

  function initOrderDropdown() {
    var $sel = $('#searchOrderNo');

    $.ajax({
      url: apiPrefix + '/orderList',
      type: 'GET',
      dataType: 'json',
      success: function(res) {
        var list = _extractList(res);
        if (!list.length) {
          console.warn('[MES_TRACE] orderList 返回空');
          return;
        }
        _fillDropdown($sel, list);
      },
      error: function(xhr, status) {
        console.warn('[MES_TRACE] orderList 请求失败(' + status + ')');
      }
    });

    $sel.on('change', function() {
      var orderNo = $(this).val();
      var cached = orderCache[orderNo];
      if (!orderNo) {
        $('#searchWorkOrderNo').val('');
        $('#searchProductName').val('');
        return;
      }
      if (cached) {
        $('#searchProductName').val(cached.productName || '');
        if (cached.orderId) {
          $.ajax({
            url: apiPrefix + '/orderChain/' + cached.orderId,
            type: 'GET',
            dataType: 'json',
            success: function(res) {
              if (res.code === 0 && res.data) {
                var d = res.data;
                var wos = (d.workOrders && d.workOrders.length > 0) ? d.workOrders : [];
                if (wos.length > 0) {
                  $('#searchWorkOrderNo').val(wos[0].workOrderNo || '');
                }
                if (!cached.productName && d.order) {
                  $('#searchProductName').val(d.order.productName || '');
                }
              }
            }
          });
        }
      }
    });
  }

  function _fillDropdown($sel, list) {
    $sel.find('option[value!=""]').remove();
    orderCache = {};
    for (var i = 0; i < list.length; i++) {
      var item = list[i];
      var orderNo = item.order_no || item.orderNo || '';
      var orderId = item.order_id || item.orderId || '';
      var productName = item.product_name || item.productName || '';
      orderCache[orderNo] = { orderId: orderId, productName: productName };
      $sel.append('<option value="' + orderNo + '">' + orderNo + '</option>');
    }
    console.log('[MES_TRACE] 订单下拉: ' + list.length + '条');
  }

  /* ==================== 追溯表格（无语URL，手动加载） ==================== */

  function initTraceTable() {
    $.table.init({
      id: 'traceTable',
      sortName: 'time',
      sortOrder: 'desc',
      modalName: '追溯记录',
      columns: [
        { field: 'orderNo',       title: '订单编号', width: 155 },
        { field: 'workOrderNo',   title: '工单编号', width: 155 },
        { field: 'productName',   title: '产品名称', width: 140 },
        { field: 'processName',   title: '工序名称', width: 110 },
        { field: 'deviceName',    title: '设备',     width: 100 },
        { field: 'operator',      title: '操作人',   width: 85 },
        {
          field: 'qcResult', title: '质检结果', align: 'center', width: 85,
          formatter: function(v) {
            if (!v) return '<span class="tag tag-gray">-</span>';
            return v === 'PASS'
              ? '<span class="tag tag-green">合格</span>'
              : '<span class="tag tag-red">不合格</span>';
          }
        },
        { field: 'time', title: '生产时间', width: 130 }
      ]
    });
  }

  /* ==================== 字段映射（关键：统一后端字段名） ==================== */

  function mapTraceData(list) {
    return list.map(function(item) {
      return {
        orderNo:      item.orderNo,
        workOrderNo:  item.workOrderNo,
        productName:  item.productName,
        processName:  item.processName,

        // 设备字段：优先 device → deviceCode → equipmentName
        deviceName:   item.device || item.deviceCode || item.equipmentName,

        // 操作人
        operator:     item.operator || item.operatorName,

        // 质检结果
        qcResult:     item.qcResult || item.inspectResult,

        // 生产时间
        time:         item.time || item.productionDate
      };
    });
  }

  /* ==================== 搜索（手动 AJAX + 数据映射） ==================== */

  function loadTraceTable(params) {
    $.ajax({
      url: apiPrefix + '/search',
      type: 'POST',
      data: params,
      dataType: 'json',
      success: function(res) {
        var list = _extractList(res);
        var mapped = mapTraceData(list);
        console.log('[MES_TRACE] 搜索返回: ' + mapped.length + '条');
        $('#traceTable').bootstrapTable('load', mapped);
      },
      error: function(xhr, status) {
        console.warn('[MES_TRACE] 搜索失败(' + status + ')');
      }
    });
  }

  function handleSearch() {
    console.log('trace search triggered');
    console.log('   订单:', $('#searchOrderNo').val() || '全部');
    console.log('   工单:', $('#searchWorkOrderNo').val() || '全部');
    console.log('   产品:', $('#searchProductName').val() || '自动');

    var params = {
      orderNo:     $('#searchOrderNo').val(),
      workOrderNo: $('#searchWorkOrderNo').val()
    };
    loadTraceTable(params);
  }

  function resetSearch() {
    $('#search-form')[0].reset();
    $('#searchProductName').val('');
    $('#searchWorkOrderNo').val('');
    handleSearch();
  }

  /* ==================== 工具 ==================== */

  function _extractList(res) {
    if (!res) return [];
    if ($.isArray(res)) return res;
    if (res.rows && $.isArray(res.rows)) return res.rows;
    if (res.code === 0) {
      if ($.isArray(res.data)) return res.data;
      if ($.isArray(res.rows)) return res.rows;
    }
    return [];
  }

  return {
    init: init,
    handleSearch: handleSearch,
    resetSearch: resetSearch
  };

})();

$(function() { MES_TRACE.init(); });
