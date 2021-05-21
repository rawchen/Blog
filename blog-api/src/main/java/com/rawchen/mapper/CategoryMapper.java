package com.rawchen.mapper;

import com.rawchen.entity.Category;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Description: 博客分类持久层接口
 * @Date: 2020-07-29
 */
@Mapper
@Repository
public interface CategoryMapper {
	List<Category> getCategoryList();

	List<Category> getCategoryNameList();

	int saveCategory(Category category);

	Category getCategoryById(Long id);

	Category getCategoryByName(String name);

	int deleteCategoryById(Long id);

	int updateCategory(Category category);
}
