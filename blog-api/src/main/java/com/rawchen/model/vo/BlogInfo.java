package com.rawchen.model.vo;

import lombok.*;
import com.rawchen.entity.Category;
import com.rawchen.entity.Tag;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Description: 博客简要信息
 * @Date: 2020-08-08
 */
@NoArgsConstructor
@Getter
@Setter
@ToString
public class BlogInfo {
	private Long id;
	private String title;//文章标题
	private String description;//描述
	private Date createTime;//创建时间
	private Integer views;//浏览次数
	private Boolean top;//是否置顶
	private String password;//文章密码
	private Boolean privacy;//是否私密文章
	private String firstPicture;//首图

	private Category category;//文章分类
	private List<Tag> tags = new ArrayList<>();//文章标签
}
