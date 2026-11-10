package com.ruoyi.mes.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.mes.domain.Inventory;
import com.ruoyi.mes.dto.InventoryQueryDTO;
import com.ruoyi.mes.vo.InventoryVO;

public interface InventoryMapper
{
    public List<InventoryVO> selectInventoryList(InventoryQueryDTO q);
    public InventoryVO selectInventoryById(Long id);
    public Inventory selectInventoryEntityById(Long id);
    public int insertInventory(Inventory inv);
    public int updateInventory(Inventory inv);
    public int deleteInventoryByIds(@Param("ids") Long[] ids);
    public int updateInventoryQuantity(@Param("inventoryId") Long id, @Param("quantity") java.math.BigDecimal qty);
}
