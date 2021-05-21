package com.rawchen.model.bean;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * @Description: GitHub徽标
 * @Date: 2020-08-09
 */
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Badge {
	private String title;
	private String url;
	private String subject;
	private String value;
	private String color;
}
