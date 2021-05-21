package com.rawchen.mapper;

import com.rawchen.entity.OperationLog;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Description: 操作日志持久层接口
 * @Date: 2020-11-30
 */
@Mapper
@Repository
public interface OperationLogMapper {
	List<OperationLog> getOperationLogListByDate(String startDate, String endDate);

	int saveOperationLog(OperationLog log);

	int deleteOperationLogById(Long id);
}
