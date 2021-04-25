package com.yoyling.service;

import com.yoyling.entity.Category;

import java.util.List;

public interface CategoryService {
	List<Category> getCategoryList();

	List<Category> getCategoryNameList();

	void saveCategory(Category category);

	Category getCategoryById(Long id);

	Category getCategoryByName(String name);

	void deleteCategoryById(Long id);

	void updateCategory(Category category);
}
