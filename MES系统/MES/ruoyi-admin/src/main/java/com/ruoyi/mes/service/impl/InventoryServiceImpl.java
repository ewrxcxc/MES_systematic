package com.ruoyi.mes.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.core.text.Convert;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.mes.domain.Inventory;
import com.ruoyi.mes.dto.InventoryDTO;
import com.ruoyi.mes.dto.InventoryQueryDTO;
import com.ruoyi.mes.mapper.InventoryMapper;
import com.ruoyi.mes.service.IInventoryService;
import com.ruoyi.mes.vo.InventoryVO;

@Service
public class InventoryServiceImpl implements IInventoryService
{
    @Autowired private InventoryMapper mapper;

    @Override public List<InventoryVO> selectInventoryList(InventoryQueryDTO q) { return mapper.selectInventoryList(q); }
    @Override public InventoryVO selectInventoryById(Long id) { return mapper.selectInventoryById(id); }

    @Override @Transactional(rollbackFor = Exception.class)
    public int insertInventory(InventoryDTO dto, String operator) {
        Inventory inv = toEntity(dto); inv.setCreateBy(operator);
        return mapper.insertInventory(inv);
    }

    @Override @Transactional(rollbackFor = Exception.class)
    public int insertOrAddInventory(InventoryDTO dto, String operator) {
        // 查找是否已存在同物料编码的库存
        InventoryQueryDTO q = new InventoryQueryDTO();
        q.setMaterialCode(dto.getMaterialCode());
        List<InventoryVO> existing = mapper.selectInventoryList(q);

        if (existing != null && !existing.isEmpty()) {
            // 已存在：累加数量
            InventoryVO vo = existing.get(0);
            Inventory inv = mapper.selectInventoryEntityById(vo.getInventoryId());
            if (inv == null) throw new ServiceException("库存记录不存在");

            BigDecimal newQty = inv.getQuantity().add(dto.getQuantity() != null ? dto.getQuantity() : BigDecimal.ZERO);
            mapper.updateInventoryQuantity(inv.getInventoryId(), newQty);
            return 1;
        } else {
            // 不存在：新增
            Inventory inv = toEntity(dto);
            inv.setCreateBy(operator);
            return mapper.insertInventory(inv);
        }
    }

    @Override @Transactional(rollbackFor = Exception.class)
    public int updateInventory(InventoryDTO dto, String operator) {
        if (dto.getInventoryId() == null) throw new ServiceException("库存ID不能为空");
        Inventory inv = toEntity(dto); inv.setUpdateBy(operator);
        return mapper.updateInventory(inv);
    }

    @Override @Transactional(rollbackFor = Exception.class)
    public int deleteInventoryByIds(String ids) {
        Long[] arr = Convert.toLongArray(ids);
        if (arr.length == 0) throw new ServiceException("请选择要删除的库存记录");
        return mapper.deleteInventoryByIds(arr);
    }

    @Override public List<Inventory> selectInventoryExportList(InventoryQueryDTO q) {
        List<InventoryVO> vos = mapper.selectInventoryList(q);
        List<Inventory> list = new ArrayList<>();
        for (InventoryVO vo : vos) { Inventory inv = new Inventory(); BeanUtils.copyProperties(vo, inv); list.add(inv); }
        return list;
    }

    private Inventory toEntity(InventoryDTO dto) { Inventory inv = new Inventory(); BeanUtils.copyProperties(dto, inv); return inv; }
}
