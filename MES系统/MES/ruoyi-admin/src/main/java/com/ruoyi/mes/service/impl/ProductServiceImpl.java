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
import com.ruoyi.mes.domain.Product;
import com.ruoyi.mes.dto.ProductDTO;
import com.ruoyi.mes.dto.ProductQueryDTO;
import com.ruoyi.mes.mapper.ProductMapper;
import com.ruoyi.mes.service.IProductService;
import com.ruoyi.mes.vo.ProductVO;

/**
 * 产品主数据 服务层处理
 *
 * @author ruoyi
 */
@Service
public class ProductServiceImpl implements IProductService
{
    @Autowired
    private ProductMapper productMapper;

    @Override
    public List<ProductVO> selectProductList(ProductQueryDTO query)
    {
        return productMapper.selectProductList(query);
    }

    @Override
    public ProductVO selectProductById(Long productId)
    {
        return productMapper.selectProductById(productId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertProduct(ProductDTO productDto, String operator)
    {
        if (!checkProductCodeUnique(productDto))
        {
            throw new ServiceException("新增产品失败，产品编码已存在");
        }
        Product product = toEntity(productDto);
        product.setCreateBy(operator);
        return productMapper.insertProduct(product);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateProduct(ProductDTO productDto, String operator)
    {
        if (productDto.getProductId() == null)
        {
            throw new ServiceException("产品ID不能为空");
        }
        if (!checkProductCodeUnique(productDto))
        {
            throw new ServiceException("修改产品失败，产品编码已存在");
        }
        Product product = toEntity(productDto);
        product.setUpdateBy(operator);
        return productMapper.updateProduct(product);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteProductByIds(String ids)
    {
        Long[] productIds = Convert.toLongArray(ids);
        if (productIds.length == 0)
        {
            throw new ServiceException("请选择要删除的产品");
        }
        return productMapper.deleteProductByIds(productIds);
    }

    @Override
    public List<Product> selectProductExportList(ProductQueryDTO query)
    {
        List<ProductVO> voList = productMapper.selectProductList(query);
        List<Product> list = new ArrayList<Product>();
        for (ProductVO vo : voList)
        {
            Product product = new Product();
            BeanUtils.copyProperties(vo, product);
            product.setRemark(vo.getRemark());
            product.setCreateTime(vo.getCreateTime());
            product.setUpdateTime(vo.getUpdateTime());
            list.add(product);
        }
        return list;
    }

    @Override
    public boolean checkProductCodeUnique(ProductDTO productDto)
    {
        Long productId = StringUtils.isNull(productDto.getProductId()) ? -1L : productDto.getProductId();
        Product info = productMapper.selectProductByCode(productDto.getProductCode());
        if (StringUtils.isNotNull(info) && info.getProductId().longValue() != productId.longValue())
        {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    private Product toEntity(ProductDTO productDto)
    {
        Product product = new Product();
        product.setProductId(productDto.getProductId());
        product.setProductCode(productDto.getProductCode());
        product.setProductName(productDto.getProductName());
        product.setSpecification(productDto.getSpecification());
        product.setProductModel(productDto.getProductModel());
        product.setUnit(productDto.getUnit());
        product.setRemark(productDto.getRemark());
        return product;
    }
}
