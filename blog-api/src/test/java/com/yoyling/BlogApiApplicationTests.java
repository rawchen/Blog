package com.yoyling;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;


@SpringBootTest
class BlogApiApplicationTests {

	@Test
	void contextLoads() {
	}

	@Test
	void test() {
		System.out.println(new BCryptPasswordEncoder(BCryptPasswordEncoder.BCryptVersion.$2A).encode("admin"));
	}
}
