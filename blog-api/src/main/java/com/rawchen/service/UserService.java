package com.rawchen.service;

import com.rawchen.entity.User;

public interface UserService {
	User findUserByUsernameAndPassword(String username, String password);
}
