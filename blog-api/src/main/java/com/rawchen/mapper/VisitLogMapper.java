package com.rawchen.mapper;

import com.rawchen.entity.VisitLog;
import com.rawchen.model.dto.VisitLogUuidTime;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Description: 访问日志持久层接口
 * @Date: 2020-12-04
 */
@Mapper
@Repository
public interface VisitLogMapper {
	List<VisitLog> getVisitLogListByUUIDAndDate(String uuid, String startDate, String endDate);

	List<VisitLogUuidTime> getUUIDAndCreateTimeByYesterday();

	int saveVisitLog(VisitLog log);

	int deleteVisitLogById(Long id);

	int countVisitLogByToday();
}
