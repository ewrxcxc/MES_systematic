package com.ruoyi.mes.controller;

import java.util.List;
import java.util.Map;
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
import com.ruoyi.mes.domain.Customer;
import com.ruoyi.mes.dto.CustomerDTO;
import com.ruoyi.mes.dto.CustomerQueryDTO;
import com.ruoyi.mes.service.ICustomerService;
import com.ruoyi.mes.vo.CustomerVO;

/**
 * 客户管理
 *
 * @author ruoyi
 */
@Tag(name = "MES客户管理")
@RestController
@RequestMapping("/api/mes/customer")
public class CustomerController extends BaseController
{
    @Autowired
    private ICustomerService customerService;

    /**
     * 查询客户列表
     */
    @Operation(summary = "查询客户列表")
    @RequiresPermissions("mes:customer:list")
    @PostMapping("/list")
    public TableDataInfo list(CustomerQueryDTO query)
    {
        startPage();
        List<CustomerVO> list = customerService.selectCustomerList(query);
        return getDataTable(list);
    }

    /**
     * 导出客户列表
     */
    @Operation(summary = "导出客户列表")
    @Log(title = "客户管理", businessType = BusinessType.EXPORT)
    @RequiresPermissions("mes:customer:export")
    @PostMapping("/export")
    public AjaxResult export(CustomerQueryDTO query)
    {
        List<Customer> list = customerService.selectCustomerExportList(query);
        ExcelUtil<Customer> util = new ExcelUtil<Customer>(Customer.class);
        return util.exportExcel(list, "客户数据");
    }

    /**
     * 获取客户详细信息
     */
    @Operation(summary = "获取客户详细信息")
    @RequiresPermissions("mes:customer:query")
    @GetMapping("/{customerId}")
    public AjaxResult getInfo(@PathVariable Long customerId)
    {
        return success(customerService.selectCustomerById(customerId));
    }

    /**
     * 新增客户
     */
    @Operation(summary = "新增客户")
    @Log(title = "客户管理", businessType = BusinessType.INSERT)
    @RequiresPermissions("mes:customer:add")
    @PostMapping("/create")
    public AjaxResult create(@Validated @RequestBody CustomerDTO customerDto)
    {
        return toAjax(customerService.insertCustomer(customerDto, getLoginName()));
    }

    /**
     * 修改客户
     */
    @Operation(summary = "修改客户")
    @Log(title = "客户管理", businessType = BusinessType.UPDATE)
    @RequiresPermissions("mes:customer:edit")
    @PostMapping("/update")
    public AjaxResult update(@Validated @RequestBody CustomerDTO customerDto)
    {
        return toAjax(customerService.updateCustomer(customerDto, getLoginName()));
    }

    /**
     * 删除客户
     */
    @Operation(summary = "删除客户")
    @Log(title = "客户管理", businessType = BusinessType.DELETE)
    @RequiresPermissions("mes:customer:remove")
    @PostMapping("/delete")
    public AjaxResult delete(String ids)
    {
        return toAjax(customerService.deleteCustomerByIds(ids));
    }

    /**
     * 校验客户编码唯一
     */
    @Operation(summary = "校验客户编码唯一")
    @PostMapping("/checkCodeUnique")
    public AjaxResult checkCodeUnique(@RequestBody CustomerDTO customerDto)
    {
        return success(customerService.checkCustomerCodeUnique(customerDto));
    }
}
