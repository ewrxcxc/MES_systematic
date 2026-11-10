package com.ruoyi.mes.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.mes.domain.Warehousing;
import com.ruoyi.mes.domain.WarehousingDetail;

public interface WarehousingMapper
{
    List<Warehousing> selectWarehousingList(Warehousing warehousing);
    Warehousing selectWarehousingById(Long warehousingId);
    Warehousing selectWarehousingByWorkOrderId(Long workOrderId);
    List<Warehousing> selectWarehousingListByWorkOrderId(Long workOrderId);
    int insertWarehousing(Warehousing warehousing);
    int updateWarehousing(Warehousing warehousing);
    int deleteWarehousingByIds(@Param("ids") Long[] ids);

    List<WarehousingDetail> selectWarehousingDetailsByWarehousingId(Long warehousingId);
    int insertWarehousingDetail(WarehousingDetail detail);
    int deleteWarehousingDetailsByWarehousingId(Long warehousingId);
}
