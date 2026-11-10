package com.ruoyi.mes.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.mes.domain.Schedule;

public interface ScheduleMapper
{
    public List<Schedule> selectScheduleList(Schedule schedule);
    public Schedule selectScheduleById(Long scheduleId);
    public int insertSchedule(Schedule schedule);
    public int updateSchedule(Schedule schedule);
    public int deleteScheduleByIds(@Param("ids") Long[] ids);
}
