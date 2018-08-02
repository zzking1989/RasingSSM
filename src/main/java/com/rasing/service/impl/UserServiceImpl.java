package com.rasing.service.impl;

import com.rasing.dao.UserDao;
import com.rasing.model.Users;
import com.rasing.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserDao userDao;

    public Users doUserLogin(Users userLogin) {
        Users userInDB = userDao.getUserByUserName(userLogin.getUserName());
        String encryptPassword = getEncryptPassword(userLogin.getPassword());
        if (userInDB != null && userInDB.getPassword().equals(encryptPassword)) {
            return userInDB;
        } else {
            return null;
        }
    }

    public Users checkUserByUserName(Users user) {
        Users userInDB = userDao.getUserByUserName(user.getUserName());
        return userInDB;
    }

    public Users checkUserByUserID(Users user) {
        Users userInDB = userDao.getUserByUserID(user.getId());
        return userInDB;
    }

    public List<Users> getUsers() {

        return userDao.selectUsersAll();
    }

    public int addUser(Users user) {
        String uuid = UUID.randomUUID().toString();
        uuid = uuid.replace("-", "");
        user.setId(uuid);
        String newPassword = getEncryptPassword(user.getPassword());
        user.setPassword(newPassword);
        userDao.addUser(user);
        Users loginUser = userDao.getUserByUserName(user.getUserName());
        if (loginUser != null) {
            return 1;
        } else {
            return 0;
        }
    }


    public int deleteUser(String userID) {
        Users userInDB = userDao.getUserByUserID(userID);
        System.out.println("userInDB" + userInDB);
        if (userInDB != null) {
            userDao.deleteUser(userInDB.getId());

            if (userDao.getUserByUserName(userInDB.getUserName()) == null) {
                return 1;
            } else {
                return -1;
            }
        } else {
            return 0;
        }
    }

    public int updateUser(Users user) {
        return userDao.updateUser(user);
    }

    public String getEncryptPassword(String password) {

        return password;
    }
}
