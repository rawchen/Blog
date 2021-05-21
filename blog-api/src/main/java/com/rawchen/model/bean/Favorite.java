package com.rawchen.model.bean;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * @Description: 自定义爱好
 * @Date: 2020-08-09
 */
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Favorite {
	private String title;
	private String content;
}
