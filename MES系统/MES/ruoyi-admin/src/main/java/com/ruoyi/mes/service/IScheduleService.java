package com.ruoyi.mes.service;

import java.util.List;
import com.ruoyi.mes.domain.Schedule;

public interface IScheduleService
{
    public List<Schedule> selectScheduleList(Schedule schedule);
    public Schedule selectScheduleById(Long scheduleId);
    public int insertSchedule(Schedule schedule);
    public int updateSchedule(Schedule schedule);
    public int deleteScheduleByIds(String ids);
    public List<Schedule> selectScheduleExportList(Schedule schedule);
}
