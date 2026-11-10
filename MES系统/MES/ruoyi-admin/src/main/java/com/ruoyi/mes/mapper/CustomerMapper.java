package com.ruoyi.mes.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.mes.domain.Customer;
import com.ruoyi.mes.dto.CustomerQueryDTO;
import com.ruoyi.mes.vo.CustomerVO;

/**
 * 客户主数据 Mapper
 *
 * @author ruoyi
 */
public interface CustomerMapper
{
    public List<CustomerVO> selectCustomerList(CustomerQueryDTO query);

    public CustomerVO selectCustomerById(Long customerId);

    public Customer selectCustomerEntityById(Long customerId);

    public Customer selectCustomerByCode(String customerCode);
    
    public Customer selectCustomerByName(String customerName);

    public int insertCustomer(Customer customer);

    public int updateCustomer(Customer customer);

    public int deleteCustomerByIds(@Param("ids") Long[] ids);
}
