package com.rawchen.controller;

import com.rawchen.annotation.VisitLogger;
import com.rawchen.model.vo.BlogInfo;
import com.rawchen.model.vo.PageResult;
import com.rawchen.model.vo.Result;
import com.rawchen.service.BlogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Description: 分类
 * @Date: 2020-08-19
 */
@RestController
public class CategoryController {
	@Autowired
	BlogService blogService;

	/**
	 * 根据分类name分页查询公开博客列表
	 *
	 * @param categoryName 分类name
	 * @param pageNum      页码
	 * @return
	 */
	@VisitLogger(behavior = "查看分类")
	@GetMapping("/category")
	public Result category(@RequestParam String categoryName,
						   @RequestParam(defaultValue = "1") Integer pageNum) {
		PageResult<BlogInfo> pageResult = blogService.getBlogInfoListByCategoryNameAndIsPublished(categoryName, pageNum);
		return Result.ok("请求成功", pageResult);
	}
}
