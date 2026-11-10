package com.ruoyi.mes.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.mes.domain.Product;
import com.ruoyi.mes.dto.ProductQueryDTO;
import com.ruoyi.mes.vo.ProductVO;

/**
 * 产品主数据 Mapper
 *
 * @author ruoyi
 */
public interface ProductMapper
{
    public List<ProductVO> selectProductList(ProductQueryDTO query);

    public ProductVO selectProductById(Long productId);

    public Product selectProductEntityById(Long productId);

    public Product selectProductByCode(String productCode);
    
    public Product selectProductByName(String productName);

    public int insertProduct(Product product);

    public int updateProduct(Product product);

    public int deleteProductByIds(@Param("ids") Long[] ids);
}
