package com.ruoyi.mes.service;

import java.util.List;
import com.ruoyi.mes.domain.Inventory;
import com.ruoyi.mes.dto.InventoryDTO;
import com.ruoyi.mes.dto.InventoryQueryDTO;
import com.ruoyi.mes.vo.InventoryVO;

public interface IInventoryService
{
    public List<InventoryVO> selectInventoryList(InventoryQueryDTO q);
    public InventoryVO selectInventoryById(Long id);
    public int insertInventory(InventoryDTO dto, String operator);
    public int insertOrAddInventory(InventoryDTO dto, String operator);
    public int updateInventory(InventoryDTO dto, String operator);
    public int deleteInventoryByIds(String ids);
    public List<Inventory> selectInventoryExportList(InventoryQueryDTO q);
}
