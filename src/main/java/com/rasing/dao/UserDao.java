package com.rasing.dao;

import com.rasing.model.Users;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserDao {

    Users getUserByUserName(String userName);

    Users getUserByUserID(String userID);

    List<Users> selectUsersAll();

    void addUser(Users user);

    void deleteUser(String id);

    int updateUser(Users user);
}
