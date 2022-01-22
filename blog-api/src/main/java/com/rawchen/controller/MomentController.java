package com.rawchen.controller;

import com.github.pagehelper.PageInfo;
import com.rawchen.annotation.AccessLimit;
import com.rawchen.annotation.VisitLogger;
import com.rawchen.entity.Moment;
import com.rawchen.entity.User;
import com.rawchen.model.vo.PageResult;
import com.rawchen.model.vo.Result;
import com.rawchen.service.MomentService;
import com.rawchen.service.impl.UserServiceImpl;
import com.rawchen.util.JwtUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @Description: 动态
 * @Date: 2020-08-25
 */
@RestController
public class MomentController {
	@Autowired
	MomentService momentService;
	@Autowired
	UserServiceImpl userService;

	/**
	 * 分页查询动态List
	 *
	 * @param pageNum 页码
	 * @param jwt     博主访问Token
	 * @return
	 */
	@VisitLogger(behavior = "访问页面", content = "动态")
	@GetMapping("/moments")
	public Result moments(@RequestParam(defaultValue = "1") Integer pageNum,
						  @RequestHeader(value = "Authorization", defaultValue = "") String jwt) {
		boolean adminIdentity = false;
		if (JwtUtils.judgeTokenIsExist(jwt)) {
			try {
				String subject = JwtUtils.getTokenBody(jwt).getSubject();
				if (subject.startsWith("admin:")) {//博主身份Token
					String username = subject.replace("admin:", "");
					User admin = (User) userService.loadUserByUsername(username);
					if (admin != null) {
						adminIdentity = true;
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		PageInfo<Moment> pageInfo = new PageInfo<>(momentService.getMomentVOList(pageNum, adminIdentity));
		PageResult<Moment> pageResult = new PageResult<>(pageInfo.getPages(), pageInfo.getList());
		return Result.ok("获取成功", pageResult);
	}

	/**
	 * 给动态点赞
	 * 简单限制一下点赞
	 *
	 * @param id 动态id
	 * @return
	 */
	@AccessLimit(seconds = 86400, maxCount = 1, msg = "不可以重复点赞哦")
	@VisitLogger(behavior = "点赞动态")
	@PostMapping("/moment/like/{id}")
	public Result like(@PathVariable Long id) {
		momentService.addLikeByMomentId(id);
		return Result.ok("点赞成功");
	}
}
