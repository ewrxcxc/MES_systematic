package com.ruoyi.mes.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.mes.domain.Bom;
import com.ruoyi.mes.dto.BomQueryDTO;
import com.ruoyi.mes.vo.BomVO;

/**
 * BOM物料清单 Mapper
 *
 * @author ruoyi
 */
public interface BomMapper
{
    public List<BomVO> selectBomList(BomQueryDTO query);

    public BomVO selectBomById(Long bomId);

    public Bom selectBomEntityById(Long bomId);

    public int insertBom(Bom bom);

    public int updateBom(Bom bom);

    public int deleteBomByIds(@Param("ids") Long[] ids);

    public List<BomVO> selectBomByProductId(Long productId);
}
