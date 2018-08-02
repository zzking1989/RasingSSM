package com.rasing.controller;

import com.rasing.model.Users;
import com.rasing.service.UserService;
import com.util.RasingResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    UserService userService;

//    Logger logger = LoggerFactory.getLogger(UserController.class);

    @RequestMapping("/index")
    public String index(HttpServletRequest request, Model model) {
//        logger.info("going to main");
        HttpSession session = request.getSession();
        if (session.getAttribute("userName") != null && session.getAttribute("userName") != "") {
            String userName = session.getAttribute("userName").toString();
            model.addAttribute("userName", userName);
        }
        return "main";
    }

    @RequestMapping("/login")
    public String loginPage() {
//        logger.info("going to login");
        return "login";

    }

    @RequestMapping("/ajaxlogin")
    @ResponseBody
    public RasingResult ajaxLogin(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.println(username + ":" + password);

        Users custemUser = new Users();
        custemUser.setUserName(username);
        custemUser.setPassword(password);

        Users users = userService.doUserLogin(custemUser);
        if (users == null) {
            return new RasingResult(2, "用户名或者密码不正确", null);
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("userName", username);
            return new RasingResult(1, "登录成功", null);
        }
    }

    @RequestMapping("/getuser")
    @ResponseBody
    public List getUser() {
        List<Users> usersList = userService.getUsers();
        System.out.println(usersList);

        return usersList;
    }


    @RequestMapping("/register")
    public String addUser() {
//        logger.info("going to register");
        return "register";

    }

    @RequestMapping("/ajaxregister")
    @ResponseBody
    public RasingResult ajaxRegister(HttpServletRequest request, Users user) {

        Users oldUser = userService.checkUserByUserName(user);
        if (oldUser == null) {
            System.out.println("不存在用户");
            int flag = userService.addUser(user);
            System.out.println("flag:" + flag);
            if (flag > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("userName", user.getUserName());
                return new RasingResult(1, "注册成功", null);
            } else {
                return new RasingResult(-1, "注册失败", null);
            }
        } else {
            return new RasingResult(2, "已经存在", null);
        }
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.removeAttribute("userName");
        return "main";
    }

    @RequestMapping("/deleteuser/{userID}")
    @ResponseBody
    public RasingResult deleteUser(@PathVariable("userID") String userID) {
        System.out.println("in delete");
        System.out.println(userID);
        int flag = userService.deleteUser(userID);
        if (flag > 0) {
            return new RasingResult(1, "删除成功", null);
        } else {
            return new RasingResult(-1, "删除失败", null);
        }
    }


    @RequestMapping("/toupdateuser/{userID}")
    @ResponseBody
    public Object updateUser(@PathVariable("userID") String userID) {
        System.out.println("in update");
        System.out.println(userID);
        Users users = new Users();
        users.setId(userID);
        Users usersInDB = userService.checkUserByUserID(users);
        if (usersInDB != null) {
            return new RasingResult(1, "用户存在", null);
        } else {
            return new RasingResult(-1, "删除失败", null);
        }
    }

    @RequestMapping("/updateuser/{userID}")
    public String intoUpdateUser(HttpServletRequest request, @PathVariable("userID") String userID) {
        Users users = new Users();
        users.setId(userID);
        Users usersInDB = userService.checkUserByUserID(users);
        System.out.println("into updateuser");
        request.setAttribute("user", usersInDB);
        return "updateuser";
    }


    @RequestMapping("/ajaxupdate")
    @ResponseBody
    public RasingResult ajaxupdate(Users user) {
        System.out.println(user.getUserName());
        Users oldUser = userService.checkUserByUserName(user);
        if (oldUser != null) {
            int flag = userService.updateUser(user);
            System.out.println("flag:" + flag);
            if (flag > 0) {
                return new RasingResult(1, "修改成功", null);
            } else {
                return new RasingResult(-1, "修改失败", null);
            }
        } else {
            return new RasingResult(2, "用户不存在", null);
        }
    }


}
