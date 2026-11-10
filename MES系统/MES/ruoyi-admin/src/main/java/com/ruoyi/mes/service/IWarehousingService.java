package com.ruoyi.mes.service;

import java.util.List;
import com.ruoyi.mes.domain.Warehousing;
import com.ruoyi.mes.domain.WarehousingDetail;

public interface IWarehousingService
{
    List<Warehousing> selectWarehousingList(Warehousing warehousing);
    Warehousing selectWarehousingById(Long warehousingId);
    int insertWarehousing(Warehousing warehousing, String operator);
    int doInspect(Long warehousingId, String inspector, String inspectResult, String operator);
    int confirmWarehousing(Long warehousingId, String warehousingBy, String location, String operator);
    int deleteWarehousingByIds(String ids);
    List<WarehousingDetail> selectWarehousingDetails(Long warehousingId);
}
