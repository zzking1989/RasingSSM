package com.shiro;

import com.rasing.model.Users;
import com.rasing.service.impl.UserServiceImpl;
import lombok.Data;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

@Data
public class RasingRealm extends AuthorizingRealm {
    @Autowired
    private UserServiceImpl userService;
    public static final String SESSION_USER_KEY = "green";


    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        Users user = (Users) SecurityUtils.getSubject().getSession().getAttribute(RasingRealm.SESSION_USER_KEY);
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        return info;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        Users userLogin = tokenToUser((UsernamePasswordToken) authenticationToken);
        // 验证用户是否可以登录
        Users ui = userService.doUserLogin(userLogin);
        if(ui == null)
            return null; // 异常处理，找不到数据
        // 设置session
        Session session = SecurityUtils.getSubject().getSession();
        session.setAttribute(RasingRealm.SESSION_USER_KEY, ui);
        //当前 Realm 的 name
        String realmName = this.getName();
        //登陆的主要信息: 可以是一个实体类的对象, 但该实体类的对象一定是根据 token 的 username 查询得到的.
//		Object principal = ui.getUsername();
        Object principal = authenticationToken.getPrincipal();
        return new SimpleAuthenticationInfo(principal, userLogin.getPassword(), realmName);
    }
    private Users tokenToUser(UsernamePasswordToken authcToken) {
        Users user = new Users();
        user.setUserName(authcToken.getUsername());
        user.setPassword(String.valueOf(authcToken.getPassword()));
        return user;
    }
}
