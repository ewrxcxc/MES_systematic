package com.ruoyi.mes.service;

import java.util.List;
import com.ruoyi.mes.domain.Customer;
import com.ruoyi.mes.dto.CustomerDTO;
import com.ruoyi.mes.dto.CustomerQueryDTO;
import com.ruoyi.mes.vo.CustomerVO;

/**
 * 客户主数据 服务层
 *
 * @author ruoyi
 */
public interface ICustomerService
{
    public List<CustomerVO> selectCustomerList(CustomerQueryDTO query);

    public CustomerVO selectCustomerById(Long customerId);

    public int insertCustomer(CustomerDTO customerDto, String operator);

    public int updateCustomer(CustomerDTO customerDto, String operator);

    public int deleteCustomerByIds(String ids);

    public List<Customer> selectCustomerExportList(CustomerQueryDTO query);

    public boolean checkCustomerCodeUnique(CustomerDTO customerDto);
}
