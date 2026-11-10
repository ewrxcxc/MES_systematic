package com.ruoyi.mes.service.impl;

import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.core.text.Convert;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.mes.domain.ProcessEquipmentMapping;
import com.ruoyi.mes.mapper.ProcessEquipmentMappingMapper;
import com.ruoyi.mes.service.IProcessEquipmentMappingService;

@Service
public class ProcessEquipmentMappingServiceImpl implements IProcessEquipmentMappingService
{
    @Autowired private ProcessEquipmentMappingMapper mapper;

    @Override
    public List<ProcessEquipmentMapping> selectMappingList(ProcessEquipmentMapping mapping) {
        return mapper.selectMappingList(mapping);
    }

    @Override
    public List<ProcessEquipmentMapping> selectByProcessCode(String processCode) {
        return mapper.selectByProcessCode(processCode);
    }

    @Override
    public List<ProcessEquipmentMapping> selectByProcessSeq(Integer processSeq) {
        return mapper.selectByProcessSeq(processSeq);
    }

    @Override
    public ProcessEquipmentMapping selectMappingById(Long id) {
        return mapper.selectMappingById(id);
    }

    @Override
    public int insertMapping(ProcessEquipmentMapping mapping, String operator) {
        mapping.setCreateBy(operator);
        return mapper.insertMapping(mapping);
    }

    @Override
    public int updateMapping(ProcessEquipmentMapping mapping, String operator) {
        mapping.setUpdateBy(operator);
        return mapper.updateMapping(mapping);
    }

    @Override
    public int deleteMappingByIds(String ids) {
        Long[] idArray = Convert.toLongArray(ids);
        if (idArray.length == 0) throw new ServiceException("请选择要删除的映射");
        return mapper.deleteMappingByIds(idArray);
    }

    @Override
    public int batchEnable(String ids, String operator) {
        Long[] idArray = Convert.toLongArray(ids);
        if (idArray.length == 0) throw new ServiceException("请选择要启用的映射");
        return mapper.batchUpdateStatus(idArray, "ACTIVE", operator);
    }

    @Override
    public int batchDisable(String ids, String operator) {
        Long[] idArray = Convert.toLongArray(ids);
        if (idArray.length == 0) throw new ServiceException("请选择要停用的映射");
        return mapper.batchUpdateStatus(idArray, "INACTIVE", operator);
    }

    @Override
    public Map<String, Object> testConnection(Long id) {
        Map<String, Object> result = new HashMap<>();
        ProcessEquipmentMapping mapping = mapper.selectMappingById(id);
        if (mapping == null) {
            result.put("success", false);
            result.put("msg", "映射记录不存在喵~");
            return result;
        }
        String apiUrl = mapping.getApiUrl();
        if (apiUrl == null || apiUrl.isEmpty()) {
            result.put("success", false);
            result.put("msg", "API地址为空喵~");
            return result;
        }
        long startTime = System.currentTimeMillis();
        try {
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setConnectTimeout(5000);
            conn.setReadTimeout(5000);
            conn.setRequestMethod("GET");
            conn.connect();
            int code = conn.getResponseCode();
            long responseTime = System.currentTimeMillis() - startTime;
            conn.disconnect();
            result.put("success", code >= 200 && code < 300);
            result.put("httpCode", code);
            result.put("responseTime", responseTime);
            // update response_time and last_call_time
            mapper.updateResponseTime(id, responseTime);
            if (code >= 200 && code < 300) {
                result.put("msg", "连接成功，HTTP " + code + "，响应时间 " + responseTime + "ms喵~");
            } else {
                result.put("msg", "HTTP " + code + "，响应时间 " + responseTime + "ms喵~");
            }
        } catch (Exception e) {
            long responseTime = System.currentTimeMillis() - startTime;
            mapper.updateResponseTime(id, responseTime);
            result.put("success", false);
            result.put("httpCode", 0);
            result.put("responseTime", responseTime);
            result.put("msg", "连接失败: " + e.getMessage() + " 喵~");
        }
        return result;
    }

    @Override
    public void refreshStatus() {
        mapper.refreshAllStatus();
    }
}
