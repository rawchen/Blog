package com.rawchen.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * @Description: 站点设置
 * @Date: 2020-08-09
 */
@NoArgsConstructor
@Getter
@Setter
@ToString
public class SiteSetting {
	private Long id;
	private String nameEn;
	private String nameZh;
	private String value;
	private Integer type;
}
