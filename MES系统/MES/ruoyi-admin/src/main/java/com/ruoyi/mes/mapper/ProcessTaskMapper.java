package com.ruoyi.mes.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.mes.domain.ProcessTask;

public interface ProcessTaskMapper
{
    public List<ProcessTask> selectByWorkOrderId(Long workOrderId);
    public ProcessTask selectById(Long taskId);
    public int insert(ProcessTask task);
    public int update(ProcessTask task);
    public int deleteByWorkOrderId(Long workOrderId);
    public ProcessTask selectCurrentTask(@Param("workOrderId") Long workOrderId, @Param("processSeq") Integer processSeq);
    public int batchInsert(@Param("list") List<ProcessTask> tasks);
    public List<ProcessTask> selectAllTasks(ProcessTask task);
}
