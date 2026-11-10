package com.ruoyi.mes.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.mes.service.IMesAIAnalysisService;

@Tag(name = "AI分析")
@RestController
@RequestMapping("/api/mes/ai")
public class MesAIController extends BaseController {

    @Autowired
    private IMesAIAnalysisService aiService;

    @Operation(summary = "获取订单列表（下拉选择）")
    @RequiresPermissions("mes:ai:list")
    @GetMapping("/orderList")
    public AjaxResult orderList() {
        return success(aiService.getDistinctOrders());
    }

    @Operation(summary = "执行AI分析")
    @RequiresPermissions("mes:ai:analyze")
    @GetMapping("/analyze")
    public AjaxResult analyze(@RequestParam String orderNo) {
        try {
            return success(aiService.analyzeSalesOrder(orderNo));
        } catch (Exception e) {
            return error("AI分析失败: " + e.getMessage());
        }
    }
}
