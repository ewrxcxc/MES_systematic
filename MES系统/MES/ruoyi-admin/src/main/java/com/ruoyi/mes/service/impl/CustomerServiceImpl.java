package com.ruoyi.mes.service.impl;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.core.text.Convert;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.mes.domain.Customer;
import com.ruoyi.mes.dto.CustomerDTO;
import com.ruoyi.mes.dto.CustomerQueryDTO;
import com.ruoyi.mes.mapper.CustomerMapper;
import com.ruoyi.mes.service.ICustomerService;
import com.ruoyi.mes.vo.CustomerVO;

/**
 * 客户主数据 服务层处理
 *
 * @author ruoyi
 */
@Service
public class CustomerServiceImpl implements ICustomerService
{
    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public List<CustomerVO> selectCustomerList(CustomerQueryDTO query)
    {
        return customerMapper.selectCustomerList(query);
    }

    @Override
    public CustomerVO selectCustomerById(Long customerId)
    {
        return customerMapper.selectCustomerById(customerId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertCustomer(CustomerDTO customerDto, String operator)
    {
        if (!checkCustomerCodeUnique(customerDto))
        {
            throw new ServiceException("新增客户失败，客户编码已存在");
        }
        Customer customer = toEntity(customerDto);
        if (StringUtils.isBlank(customer.getStatus()))
        {
            customer.setStatus("0");
        }
        customer.setCreateBy(operator);
        return customerMapper.insertCustomer(customer);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateCustomer(CustomerDTO customerDto, String operator)
    {
        if (customerDto.getCustomerId() == null)
        {
            throw new ServiceException("客户ID不能为空");
        }
        if (!checkCustomerCodeUnique(customerDto))
        {
            throw new ServiceException("修改客户失败，客户编码已存在");
        }
        Customer customer = toEntity(customerDto);
        customer.setUpdateBy(operator);
        return customerMapper.updateCustomer(customer);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteCustomerByIds(String ids)
    {
        Long[] customerIds = Convert.toLongArray(ids);
        if (customerIds.length == 0)
        {
            throw new ServiceException("请选择要删除的客户");
        }
        return customerMapper.deleteCustomerByIds(customerIds);
    }

    @Override
    public List<Customer> selectCustomerExportList(CustomerQueryDTO query)
    {
        List<CustomerVO> voList = customerMapper.selectCustomerList(query);
        List<Customer> list = new ArrayList<Customer>();
        for (CustomerVO vo : voList)
        {
            Customer customer = new Customer();
            BeanUtils.copyProperties(vo, customer);
            customer.setRemark(vo.getRemark());
            customer.setCreateTime(vo.getCreateTime());
            customer.setUpdateTime(vo.getUpdateTime());
            list.add(customer);
        }
        return list;
    }

    @Override
    public boolean checkCustomerCodeUnique(CustomerDTO customerDto)
    {
        Long customerId = StringUtils.isNull(customerDto.getCustomerId()) ? -1L : customerDto.getCustomerId();
        Customer info = customerMapper.selectCustomerByCode(customerDto.getCustomerCode());
        if (StringUtils.isNotNull(info) && info.getCustomerId().longValue() != customerId.longValue())
        {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    private Customer toEntity(CustomerDTO customerDto)
    {
        Customer customer = new Customer();
        customer.setCustomerId(customerDto.getCustomerId());
        customer.setCustomerCode(customerDto.getCustomerCode());
        customer.setCustomerName(customerDto.getCustomerName());
        customer.setContactName(customerDto.getContactName());
        customer.setContactPhone(customerDto.getContactPhone());
        customer.setEmail(customerDto.getEmail());
        customer.setAddress(customerDto.getAddress());
        customer.setStatus(customerDto.getStatus());
        customer.setRemark(customerDto.getRemark());
        return customer;
    }
}
