package com.ruoyi.mes.controller;

import java.util.*;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.mes.domain.MaterialPicking;
import com.ruoyi.mes.domain.MaterialPickingDetail;
import com.ruoyi.mes.mapper.InventoryMapper;
import com.ruoyi.mes.service.IMaterialPickingService;
import com.ruoyi.mes.vo.InventoryVO;
import com.ruoyi.mes.dto.InventoryQueryDTO;

@Tag(name = "领料管理")
@RestController
@RequestMapping("/api/mes/picking")
public class MaterialPickingController extends BaseController
{
    @Autowired private IMaterialPickingService pickingService;
    @Autowired private InventoryMapper inventoryMapper;

    @Operation(summary = "查询领料单列表")
    @RequiresPermissions("mes:picking:list")
    @PostMapping("/list")
    public TableDataInfo list(MaterialPicking picking) {
        startPage();
        return getDataTable(pickingService.selectMaterialPickingList(picking));
    }

    @Operation(summary = "获取领料单详情")
    @RequiresPermissions("mes:picking:query")
    @GetMapping("/{pickingId}")
    public AjaxResult getInfo(@PathVariable Long pickingId) {
        AjaxResult result = success(pickingService.selectMaterialPickingById(pickingId));
        result.put("details", pickingService.selectPickingDetails(pickingId));
        return result;
    }

    @Operation(summary = "获取领料单明细(含库存信息)")
    @GetMapping("/details/{pickingId}")
    public AjaxResult getDetails(@PathVariable Long pickingId) {
        List<MaterialPickingDetail> details = pickingService.selectPickingDetails(pickingId);
        List<Map<String, Object>> enriched = new ArrayList<>();
        for (MaterialPickingDetail d : details) {
            Map<String, Object> item = new HashMap<>();
            item.put("detailId", d.getDetailId());
            item.put("pickingId", d.getPickingId());
            item.put("materialCode", d.getMaterialCode());
            item.put("materialName", d.getMaterialName());
            item.put("bomUsage", d.getBomUsage());
            item.put("requiredQty", d.getRequiredQty());
            item.put("actualQty", d.getActualQty());
            item.put("unit", d.getUnit());
            item.put("status", d.getStatus());
            // 查询当前库存
            InventoryQueryDTO q = new InventoryQueryDTO();
            q.setMaterialCode(d.getMaterialCode());
            List<InventoryVO> invList = inventoryMapper.selectInventoryList(q);
            if (invList != null && !invList.isEmpty()) {
                item.put("inventoryQty", invList.get(0).getQuantity());
                item.put("inventoryId", invList.get(0).getInventoryId());
                item.put("location", invList.get(0).getLocation());
            } else {
                item.put("inventoryQty", 0);
                item.put("inventoryId", null);
                item.put("location", "");
            }
            enriched.add(item);
        }
        return success(enriched);
    }

    @Operation(summary = "从工单生成领料单(BOM展开)")
    @Log(title = "领料单", businessType = BusinessType.INSERT)
    @RequiresPermissions("mes:picking:add")
    @PostMapping("/createByWorkOrder/{workOrderId}")
    public AjaxResult createByWorkOrder(@PathVariable Long workOrderId) {
        try {
            MaterialPicking picking = pickingService.createPickingByWorkOrder(workOrderId, getLoginName());
            return success(picking);
        } catch (Exception e) {
            return error(e.getMessage());
        }
    }

    @Operation(summary = "确认领料(扣减库存)")
    @Log(title = "领料单", businessType = BusinessType.UPDATE)
    @RequiresPermissions("mes:picking:edit")
    @PostMapping("/confirm/{pickingId}")
    public AjaxResult confirm(@PathVariable Long pickingId, String pickingBy,
                              @RequestBody(required = false) List<MaterialPickingDetail> details) {
        try {
            return toAjax(pickingService.confirmPicking(pickingId, pickingBy, details, getLoginName()));
        } catch (Exception e) {
            return error(e.getMessage());
        }
    }

    @Operation(summary = "删除领料单")
    @Log(title = "领料单", businessType = BusinessType.DELETE)
    @RequiresPermissions("mes:picking:remove")
    @PostMapping("/delete")
    public AjaxResult delete(String ids) {
        return toAjax(pickingService.deleteMaterialPickingByIds(ids));
    }
}
