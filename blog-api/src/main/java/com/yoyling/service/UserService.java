package com.yoyling.service;

import com.yoyling.entity.User;

public interface UserService {
	User findUserByUsernameAndPassword(String username, String password);
}
