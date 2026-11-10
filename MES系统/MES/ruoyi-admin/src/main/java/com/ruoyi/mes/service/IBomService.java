package com.ruoyi.mes.service;

import java.util.List;
import com.ruoyi.mes.domain.Bom;
import com.ruoyi.mes.dto.BomDTO;
import com.ruoyi.mes.dto.BomQueryDTO;
import com.ruoyi.mes.vo.BomVO;

/**
 * BOM物料清单 服务层
 *
 * @author ruoyi
 */
public interface IBomService
{
    public List<BomVO> selectBomList(BomQueryDTO query);

    public BomVO selectBomById(Long bomId);

    public int insertBom(BomDTO bomDto, String operator);

    public int updateBom(BomDTO bomDto, String operator);

    public int deleteBomByIds(String ids);

    public List<Bom> selectBomExportList(BomQueryDTO query);
}
