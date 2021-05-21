package com.rawchen.controller;

import com.rawchen.annotation.VisitLogger;
import com.rawchen.model.vo.Result;
import com.rawchen.service.AboutService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Description: 关于我页面
 * @Date: 2020-08-31
 */
@RestController
public class AboutController {
	@Autowired
	AboutService aboutService;

	/**
	 * 获取关于我页面信息
	 *
	 * @return
	 */
	@VisitLogger(behavior = "访问页面", content = "关于我")
	@GetMapping("/about")
	public Result about() {
		return Result.ok("获取成功", aboutService.getAboutInfo());
	}
}
