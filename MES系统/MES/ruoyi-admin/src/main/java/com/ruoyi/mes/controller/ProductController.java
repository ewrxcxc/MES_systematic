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
import com.ruoyi.mes.domain.Product;
import com.ruoyi.mes.dto.ProductDTO;
import com.ruoyi.mes.dto.ProductQueryDTO;
import com.ruoyi.mes.service.IProductService;
import com.ruoyi.mes.vo.ProductVO;

/**
 * 产品管理
 *
 * @author ruoyi
 */
@Tag(name = "MES产品管理")
@RestController
@RequestMapping("/api/mes/product")
public class ProductController extends BaseController
{
    @Autowired
    private IProductService productService;

    /**
     * 查询产品列表
     */
    @Operation(summary = "查询产品列表")
    @PostMapping("/list")
    public TableDataInfo list(ProductQueryDTO query)
    {
        startPage();
        List<ProductVO> list = productService.selectProductList(query);
        return getDataTable(list);
    }

    /**
     * 导出产品列表
     */
    @Operation(summary = "导出产品列表")
    @Log(title = "产品管理", businessType = BusinessType.EXPORT)
    @RequiresPermissions("mes:product:export")
    @PostMapping("/export")
    public AjaxResult export(ProductQueryDTO query)
    {
        List<Product> list = productService.selectProductExportList(query);
        ExcelUtil<Product> util = new ExcelUtil<Product>(Product.class);
        return util.exportExcel(list, "产品数据");
    }

    /**
     * 获取产品详细信息
     */
    @Operation(summary = "获取产品详细信息")
    @RequiresPermissions("mes:product:query")
    @GetMapping("/{productId}")
    public AjaxResult getInfo(@PathVariable Long productId)
    {
        return success(productService.selectProductById(productId));
    }

    /**
     * 新增产品
     */
    @Operation(summary = "新增产品")
    @Log(title = "产品管理", businessType = BusinessType.INSERT)
    @RequiresPermissions("mes:product:add")
    @PostMapping("/create")
    public AjaxResult create(@Validated @RequestBody ProductDTO productDto)
    {
        return toAjax(productService.insertProduct(productDto, getLoginName()));
    }

    /**
     * 修改产品
     */
    @Operation(summary = "修改产品")
    @Log(title = "产品管理", businessType = BusinessType.UPDATE)
    @RequiresPermissions("mes:product:edit")
    @PostMapping("/update")
    public AjaxResult update(@Validated @RequestBody ProductDTO productDto)
    {
        return toAjax(productService.updateProduct(productDto, getLoginName()));
    }

    /**
     * 删除产品
     */
    @Operation(summary = "删除产品")
    @Log(title = "产品管理", businessType = BusinessType.DELETE)
    @RequiresPermissions("mes:product:remove")
    @PostMapping("/delete")
    public AjaxResult delete(String ids)
    {
        return toAjax(productService.deleteProductByIds(ids));
    }

    /**
     * 校验产品编码唯一
     */
    @Operation(summary = "校验产品编码唯一")
    @PostMapping("/checkCodeUnique")
    public AjaxResult checkCodeUnique(@RequestBody ProductDTO productDto)
    {
        return success(productService.checkProductCodeUnique(productDto));
    }

    /**
     * 获取简化产品列表（供下拉框使用）
     */
    @Operation(summary = "获取简化产品列表")
    @PostMapping("/simpleList")
    public AjaxResult simpleList()
    {
        List<ProductVO> list = productService.selectProductList(new ProductQueryDTO());
        return success(list);
    }
}
