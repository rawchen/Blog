package com.yoyling.service.impl;

import com.yoyling.entity.VisitLog;
import com.yoyling.exception.PersistenceException;
import com.yoyling.mapper.VisitLogMapper;
import com.yoyling.model.dto.VisitLogUuidTime;
import com.yoyling.service.VisitLogService;
import com.yoyling.util.IpAddressUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.yoyling.util.UserAgentUtils;

import java.util.List;
import java.util.Map;

/**
 * @Description: 访问日志业务层实现
 * @Date: 2020-12-04
 */
@Service
public class VisitLogServiceImpl implements VisitLogService {
	@Autowired
	VisitLogMapper visitLogMapper;
	@Autowired
	UserAgentUtils userAgentUtils;

	@Override
	public List<VisitLog> getVisitLogListByUUIDAndDate(String uuid, String startDate, String endDate) {
		return visitLogMapper.getVisitLogListByUUIDAndDate(uuid, startDate, endDate);
	}

	@Override
	public List<VisitLogUuidTime> getUUIDAndCreateTimeByYesterday() {
		return visitLogMapper.getUUIDAndCreateTimeByYesterday();
	}

	@Transactional
	@Override
	public void saveVisitLog(VisitLog log) {
		String ipSource = IpAddressUtils.getCityInfo(log.getIp());
		Map<String, String> userAgentMap = userAgentUtils.parseOsAndBrowser(log.getUserAgent());
		String os = userAgentMap.get("os");
		String browser = userAgentMap.get("browser");
		log.setIpSource(ipSource);
		log.setOs(os);
		log.setBrowser(browser);
		if (visitLogMapper.saveVisitLog(log) != 1) {
			throw new PersistenceException("日志添加失败");
		}
	}

	@Transactional
	@Override
	public void deleteVisitLogById(Long id) {
		if (visitLogMapper.deleteVisitLogById(id) != 1) {
			throw new PersistenceException("删除日志失败");
		}
	}
}
