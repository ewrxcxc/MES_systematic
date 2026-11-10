package com.ruoyi.mes.service.impl;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.core.text.Convert;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.mes.domain.Bom;
import com.ruoyi.mes.dto.BomDTO;
import com.ruoyi.mes.dto.BomQueryDTO;
import com.ruoyi.mes.mapper.BomMapper;
import com.ruoyi.mes.service.IBomService;
import com.ruoyi.mes.vo.BomVO;

/**
 * BOM物料清单 服务层处理
 *
 * @author ruoyi
 */
@Service
public class BomServiceImpl implements IBomService
{
    @Autowired
    private BomMapper bomMapper;

    @Override
    public List<BomVO> selectBomList(BomQueryDTO query)
    {
        return bomMapper.selectBomList(query);
    }

    @Override
    public BomVO selectBomById(Long bomId)
    {
        return bomMapper.selectBomById(bomId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertBom(BomDTO bomDto, String operator)
    {
        if (bomDto.getProductId() == null)
        {
            throw new ServiceException("请选择关联产品");
        }
        Bom bom = toEntity(bomDto);
        bom.setCreateBy(operator);
        return bomMapper.insertBom(bom);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateBom(BomDTO bomDto, String operator)
    {
        if (bomDto.getBomId() == null)
        {
            throw new ServiceException("BOM ID不能为空");
        }
        if (bomDto.getProductId() == null)
        {
            throw new ServiceException("请选择关联产品");
        }
        Bom bom = toEntity(bomDto);
        bom.setUpdateBy(operator);
        return bomMapper.updateBom(bom);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteBomByIds(String ids)
    {
        Long[] bomIds = Convert.toLongArray(ids);
        if (bomIds.length == 0)
        {
            throw new ServiceException("请选择要删除的BOM");
        }
        return bomMapper.deleteBomByIds(bomIds);
    }

    @Override
    public List<Bom> selectBomExportList(BomQueryDTO query)
    {
        List<BomVO> voList = bomMapper.selectBomList(query);
        List<Bom> list = new ArrayList<Bom>();
        for (BomVO vo : voList)
        {
            Bom bom = new Bom();
            BeanUtils.copyProperties(vo, bom);
            bom.setRemark(vo.getRemark());
            bom.setCreateTime(vo.getCreateTime());
            bom.setUpdateTime(vo.getUpdateTime());
            list.add(bom);
        }
        return list;
    }

    private Bom toEntity(BomDTO bomDto)
    {
        Bom bom = new Bom();
        bom.setBomId(bomDto.getBomId());
        bom.setProductId(bomDto.getProductId());
        bom.setMaterialName(bomDto.getMaterialName());
        bom.setMaterialCode(bomDto.getMaterialCode());
        bom.setUsageQty(bomDto.getUsageQty());
        bom.setRemark(bomDto.getRemark());
        return bom;
    }
}
