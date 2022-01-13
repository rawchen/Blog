package com.rawchen.service;

import com.rawchen.model.vo.BlogInfo;
import com.rawchen.model.vo.PageResult;

import java.util.List;
import java.util.Map;

public interface RedisService {

	/**
	 * 根据hash值获取博客页面信息
	 *
	 * @param hash
	 * @param pageNum
	 * @return
	 */
	PageResult<BlogInfo> getBlogInfoPageResultByHash(String hash, Integer pageNum);

	/**
	 * 保存键值到hash中
	 *
	 * @param hash
	 * @param key
	 * @param value
	 */
	void saveKVToHash(String hash, Object key, Object value);

	/**
	 * 保存map到hash中
	 *
	 * @param hash
	 * @param map
	 */
	void saveMapToHash(String hash, Map map);

	/**
	 * 根据hash值获取map
	 *
	 * @param hash
	 * @return
	 */
	Map getMapByHash(String hash);

	/**
	 * 根据hashKey获取value
	 *
	 * @param hash
	 * @param key
	 * @return
	 */
	Object getValueByHashKey(String hash, Object key);

	/**
	 * 根据hashkey新增
	 * @param hash
	 * @param key
	 * @param increment
	 */
	void incrementByHashKey(String hash, Object key, int increment);

	/**
	 * 根据hashkey删除
	 *
	 * @param hash
	 * @param key
	 */
	void deleteByHashKey(String hash, Object key);

	/**
	 * 根据值获取list
	 *
	 * @param key
	 * @param <T>
	 * @return
	 */
	<T> List<T> getListByValue(String key);

	/**
	 * 保存list到value
	 *
	 * @param key
	 * @param list
	 * @param <T>
	 */
	<T> void saveListToValue(String key, List<T> list);

	/**
	 * 根据值获取map
	 *
	 * @param key
	 * @param <T>
	 * @return
	 */
	<T> Map<String, T> getMapByValue(String key);

	/**
	 * 保存map到value
	 *
	 * @param key
	 * @param map
	 * @param <T>
	 */
	<T> void saveMapToValue(String key, Map<String, T> map);

	/**
	 * 根据value获取Object
	 *
	 * @param key
	 * @param t
	 * @param <T>
	 * @return
	 */
	<T> T getObjectByValue(String key, Class t);

	/**
	 * 根据key插入信息
	 *
	 * @param key
	 * @param increment
	 */
	void incrementByKey(String key, int increment);

	/**
	 * 保存object到value
	 *
	 * @param key
	 * @param object
	 */
	void saveObjectToValue(String key, Object object);

	/**
	 * 保存value到set
	 *
	 * @param key
	 * @param value
	 */
	void saveValueToSet(String key, Object value);

	/**
	 * 根据set获取总数
	 *
	 * @param key
	 * @return
	 */
	int countBySet(String key);

	/**
	 * 根据set删除值
	 *
	 * @param key
	 * @param value
	 */
	void deleteValueBySet(String key, Object value);

	/**
	 * 校验Redis中是否存在uuid
	 *
	 * @param key
	 * @param value
	 * @return
	 */
	boolean hasValueInSet(String key, Object value);

	/**
	 * 删除友链页面缓存
	 *
	 * @param key
	 */
	void deleteCacheByKey(String key);

	/**
	 * 校验key是否存在
	 *
	 * @param key
	 * @return
	 */
	boolean hasKey(String key);

	/**
	 * 设置key的过期时间
	 *
	 * @param key
	 * @param time
	 */
	void expire(String key, long time);
}
