package com.rasing.service;

import com.rasing.model.Users;

import java.util.List;


public interface UserService {
    Users doUserLogin(Users userLogin);

    List<Users> getUsers();

    int addUser(Users user);

    Users checkUserByUserName(Users user);

    Users checkUserByUserID(Users user);

    int deleteUser(String userID);

    int updateUser(Users user);
}
