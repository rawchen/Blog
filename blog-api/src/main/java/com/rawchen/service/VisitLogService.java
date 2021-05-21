package com.rawchen.service;

import com.rawchen.entity.VisitLog;
import com.rawchen.model.dto.VisitLogUuidTime;
import org.springframework.scheduling.annotation.Async;

import java.util.List;

public interface VisitLogService {
	List<VisitLog> getVisitLogListByUUIDAndDate(String uuid, String startDate, String endDate);

	List<VisitLogUuidTime> getUUIDAndCreateTimeByYesterday();

	@Async
	void saveVisitLog(VisitLog log);

	void deleteVisitLogById(Long id);
}
