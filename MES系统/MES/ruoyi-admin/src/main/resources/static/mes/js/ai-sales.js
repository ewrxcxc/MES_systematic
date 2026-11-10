/**
 * MES AI分析 — 选择订单 → 调用DeepSeek分析 → 渲染Markdown结果
 */
var MES_AI_SALES = (function() {

  var ctx = window.ctx || '';
  var apiPrefix = ctx + 'api/mes/ai';

  /* ==================== 初始化 ==================== */

  function init() {
    initOrderDropdown();
    console.log('[MES_AI_SALES] 初始化完成');
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
          console.warn('[MES_AI_SALES] orderList 返回空');
          return;
        }
        $sel.find('option[value!=""]').remove();
        for (var i = 0; i < list.length; i++) {
          var item = list[i];
          var orderNo = item.order_no || item.orderNo || '';
          $sel.append('<option value="' + orderNo + '">' + orderNo + '</option>');
        }
        console.log('[MES_AI_SALES] 订单下拉: ' + list.length + '条');
      },
      error: function(xhr, status) {
        console.warn('[MES_AI_SALES] 下拉加载失败(' + status + ')');
      }
    });
  }

  /* ==================== AI分析 ==================== */

  function analyze() {
    var orderNo = $('#searchOrderNo').val();
    if (!orderNo) {
      alert('请先选择销售订单');
      return;
    }

    $('#emptyPanel').hide();
    $('#resultPanel').hide();
    $('#loadingPanel').show();

    $.ajax({
      url: apiPrefix + '/analyze',
      type: 'GET',
      data: { orderNo: orderNo },
      dataType: 'json',
      timeout: 200000,
      success: function(res) {
        $('#loadingPanel').hide();
        if (res.code === 0 && res.data) {
          var md = res.data.analysisResult || '';
          var summary = res.data.orderSummary || {};
          var html = _renderOrderSummary(summary) + _renderMarkdown(md);
          $('#resultPanel').html(html).show();
        } else {
          $('#resultPanel').html(
            '<div style="color:#F56C6C;padding:20px;">' +
            (res.msg || '分析返回异常') + '</div>'
          ).show();
        }
      },
      error: function(xhr, status) {
        $('#loadingPanel').hide();
        var msg = status === 'timeout' ? '请求超时，AI分析耗时较长，请重试' : ('请求失败: ' + status);
        $('#resultPanel').html(
          '<div style="color:#F56C6C;padding:20px;">' + msg + '</div>'
        ).show();
      }
    });
  }

  /* ==================== 订单概览卡片 ==================== */

  function _renderOrderSummary(summary) {
    if (!summary || !summary.orderNo) return '';
    var statusColor = {
      'COMPLETED': '#67c23a', '已完成': '#67c23a',
      'PRODUCING': '#409eff', '生产中': '#409eff',
      'CONFIRMED': '#e6a23c',
      'PENDING': '#909399', '待处理': '#909399'
    };
    var sc = statusColor[summary.orderStatus] || '#909399';
    return '<div style="background:#ecf5ff;border-left:4px solid #409eff;padding:12px 16px;margin-bottom:16px;border-radius:4px;">'
      + '<strong>订单概览</strong> '
      + '｜ 订单: ' + (summary.orderNo || '-')
      + ' ｜ 客户: ' + (summary.customerName || '-')
      + ' ｜ 产品: ' + (summary.productName || '-')
      + ' ｜ 数量: ' + (summary.quantity || '-')
      + ' ｜ 交期: ' + (summary.dueDate || '-')
      + ' ｜ <span style="color:' + sc + ';font-weight:600;">' + (summary.orderStatus || '-') + '</span>'
      + '</div>';
  }

  /* ==================== Markdown渲染 ==================== */

  function _renderMarkdown(md) {
    if (!md) return '';

    // Escape HTML
    var html = md
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;');

    // Code blocks (before other transformations)
    html = html.replace(/```([\s\S]*?)```/g, function(m, code) {
      return '<pre><code>' + code + '</code></pre>';
    });

    // Inline code
    html = html.replace(/`([^`]+)`/g, '<code>$1</code>');

    // Headers
    html = html.replace(/^#### (.+)$/gm, '<h4>$1</h4>');
    html = html.replace(/^### (.+)$/gm, '<h3>$1</h3>');
    html = html.replace(/^## (.+)$/gm, '<h2>$1</h2>');
    html = html.replace(/^# (.+)$/gm, '<h2>$1</h2>');

    // Bold and italic
    html = html.replace(/\*\*\*(.+?)\*\*\*/g, '<strong><em>$1</em></strong>');
    html = html.replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>');
    html = html.replace(/\*(.+?)\*/g, '<em>$1</em>');

    // Horizontal rules
    html = html.replace(/^---+$/gm, '<hr>');

    // Unordered lists
    html = html.replace(/^- (.+)$/gm, '<li>$1</li>');
    html = html.replace(/((?:<li>.*<\/li>\n?)+)/g, '<ul>$1</ul>');

    // Ordered lists
    html = html.replace(/^\d+\.\s+(.+)$/gm, '<li>$1</li>');

    // Table rows
    html = html.replace(/^\|(.+)\|$/gm, function(line) {
      if (/^\|[-:\s|]+\|$/.test(line)) return ''; // separator row
      var cells = line.split('|');
      var row = '';
      for (var i = 1; i < cells.length; i++) {
        row += '<td>' + cells[i].trim() + '</td>';
      }
      return '<tr>' + row + '</tr>';
    });
    // Wrap consecutive <tr> in <table>
    html = html.replace(/((?:<tr>.*<\/tr>\n?)+)/g, '<table>$1</table>');

    // Paragraphs: wrap text blocks
    html = html.replace(/\n\n/g, '</p><p>');
    html = '<p>' + html + '</p>';

    // Clean up empty tags
    html = html.replace(/<p>\s*<\/p>/g, '');
    html = html.replace(/<p>(<\w+)/g, '$1');
    html = html.replace(/(<\/\w+>)<\/p>/g, '$1');

    return html;
  }

  /* ==================== 工具 ==================== */

  function _extractList(res) {
    if (!res) return [];
    if ($.isArray(res)) return res;
    if (res.code === 0 && $.isArray(res.data)) return res.data;
    return [];
  }

  return {
    init: init,
    analyze: analyze
  };

})();

$(function() { MES_AI_SALES.init(); });
