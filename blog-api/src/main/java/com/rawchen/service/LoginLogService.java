package com.rawchen.service;

import com.rawchen.entity.LoginLog;
import org.springframework.scheduling.annotation.Async;

import java.util.List;

public interface LoginLogService {
	List<LoginLog> getLoginLogListByDate(String startDate, String endDate);

	@Async
	void saveLoginLog(LoginLog log);

	void deleteLoginLogById(Long id);
}
