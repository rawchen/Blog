package com.rawchen;

import com.rawchen.util.IpAddressUtils;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.util.ClassUtils;


@SpringBootTest
class BlogApiApplicationTests {

	@Test
	void contextLoads() {
	}

	@Test
	void test01() {
		System.out.println(new BCryptPasswordEncoder(BCryptPasswordEncoder.BCryptVersion.$2A).encode("admin"));
	}

	@Test
	void test02() {
		System.out.println(String.class.getTypeName());
		System.out.println(ClassUtils.getShortNameAsProperty(String.class));
//		System.out.println(ClassUtils.getMethod(String.class, "valueOf", String.class));
	}

	@Test
	void test03() {
		String cityInfo = IpAddressUtils.getCityInfo("119.23.60.193");
		System.out.println(cityInfo);
	}
}
