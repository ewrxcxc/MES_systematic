package com.ruoyi.mes.controller;

import java.util.List;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.mes.domain.Bom;
import com.ruoyi.mes.dto.BomDTO;
import com.ruoyi.mes.dto.BomQueryDTO;
import com.ruoyi.mes.service.IBomService;
import com.ruoyi.mes.vo.BomVO;

/**
 * BOM管理
 *
 * @author ruoyi
 */
@Tag(name = "MES BOM管理")
@RestController
@RequestMapping("/api/mes/bom")
public class BomController extends BaseController
{
    @Autowired
    private IBomService bomService;

    /**
     * 查询BOM列表
     */
    @Operation(summary = "查询BOM列表")
    @RequiresPermissions("mes:bom:list")
    @PostMapping("/list")
    public TableDataInfo list(BomQueryDTO query)
    {
        startPage();
        List<BomVO> list = bomService.selectBomList(query);
        return getDataTable(list);
    }

    /**
     * 导出BOM列表
     */
    @Operation(summary = "导出BOM列表")
    @Log(title = "BOM管理", businessType = BusinessType.EXPORT)
    @RequiresPermissions("mes:bom:export")
    @PostMapping("/export")
    public AjaxResult export(BomQueryDTO query)
    {
        List<Bom> list = bomService.selectBomExportList(query);
        ExcelUtil<Bom> util = new ExcelUtil<Bom>(Bom.class);
        return util.exportExcel(list, "BOM数据");
    }

    /**
     * 获取BOM详细信息
     */
    @Operation(summary = "获取BOM详细信息")
    @RequiresPermissions("mes:bom:query")
    @GetMapping("/{bomId}")
    public AjaxResult getInfo(@PathVariable Long bomId)
    {
        return success(bomService.selectBomById(bomId));
    }

    /**
     * 新增BOM
     */
    @Operation(summary = "新增BOM")
    @Log(title = "BOM管理", businessType = BusinessType.INSERT)
    @RequiresPermissions("mes:bom:add")
    @PostMapping("/create")
    public AjaxResult create(@Validated @RequestBody BomDTO bomDto)
    {
        return toAjax(bomService.insertBom(bomDto, getLoginName()));
    }

    /**
     * 修改BOM
     */
    @Operation(summary = "修改BOM")
    @Log(title = "BOM管理", businessType = BusinessType.UPDATE)
    @RequiresPermissions("mes:bom:edit")
    @PostMapping("/update")
    public AjaxResult update(@Validated @RequestBody BomDTO bomDto)
    {
        return toAjax(bomService.updateBom(bomDto, getLoginName()));
    }

    /**
     * 删除BOM
     */
    @Operation(summary = "删除BOM")
    @Log(title = "BOM管理", businessType = BusinessType.DELETE)
    @RequiresPermissions("mes:bom:remove")
    @PostMapping("/delete")
    public AjaxResult delete(String ids)
    {
        return toAjax(bomService.deleteBomByIds(ids));
    }
}
