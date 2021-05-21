package com.rawchen.service.impl;

import com.rawchen.entity.CityVisitor;
import com.rawchen.mapper.CityVisitorMapper;
import com.rawchen.service.CityVisitorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description: 城市访客数量统计业务层实现
 * @Date: 2021-02-26
 */
@Service
public class CityVisitorServiceImpl implements CityVisitorService {
	@Autowired
	CityVisitorMapper cityVisitorMapper;

	@Override
	public void saveCityVisitor(CityVisitor cityVisitor) {
		cityVisitorMapper.saveCityVisitor(cityVisitor);
	}
}
