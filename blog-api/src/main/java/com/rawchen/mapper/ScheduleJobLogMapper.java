package com.rawchen.mapper;

import com.rawchen.entity.ScheduleJobLog;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Description: 定时任务日志持久层接口
 * @Date: 2020-11-01
 */
@Mapper
@Repository
public interface ScheduleJobLogMapper {
	List<ScheduleJobLog> getJobLogListByDate(String startDate, String endDate);

	int saveJobLog(ScheduleJobLog jobLog);

	int deleteJobLogByLogId(Long logId);
}
