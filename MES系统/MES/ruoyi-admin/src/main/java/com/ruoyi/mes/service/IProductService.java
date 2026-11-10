package com.ruoyi.mes.service;

import java.util.List;
import com.ruoyi.mes.domain.Product;
import com.ruoyi.mes.dto.ProductDTO;
import com.ruoyi.mes.dto.ProductQueryDTO;
import com.ruoyi.mes.vo.ProductVO;

/**
 * 产品主数据 服务层
 *
 * @author ruoyi
 */
public interface IProductService
{
    public List<ProductVO> selectProductList(ProductQueryDTO query);

    public ProductVO selectProductById(Long productId);

    public int insertProduct(ProductDTO productDto, String operator);

    public int updateProduct(ProductDTO productDto, String operator);

    public int deleteProductByIds(String ids);

    public List<Product> selectProductExportList(ProductQueryDTO query);

    public boolean checkProductCodeUnique(ProductDTO productDto);
}
