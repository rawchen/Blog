package com.rawchen.service.impl;

import com.rawchen.entity.VisitRecord;
import com.rawchen.mapper.VisitRecordMapper;
import com.rawchen.service.VisitRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description: 访问记录业务层实现
 * @Date: 2021-02-23
 */
@Service
public class VisitRecordServiceImpl implements VisitRecordService {
	@Autowired
	VisitRecordMapper visitRecordMapper;

	@Override
	public void saveVisitRecord(VisitRecord visitRecord) {
		visitRecordMapper.saveVisitRecord(visitRecord);
	}
}
