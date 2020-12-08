package com.guigu.service.impl;

import com.github.pagehelper.PageHelper;
import com.guigu.dao.UserDao;
import com.guigu.service.UserService;
import com.guigu.vo.Car;
import com.guigu.vo.PageVo;
import com.guigu.vo.UserInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserDao userDao;


    //根据用户名和密码  租客登录验证
    @Override
    public UserInfo zukelogin(String loginname, String pwd) {
        return userDao.zukelogin(loginname,pwd);
    }

    @Override
    public UserInfo yuangonlogin(String loginname, String pwd) {
        return userDao.yuangonlogin(loginname,pwd);
    }

    @Override
    public UserInfo panduanzhuce(String loginname) {
        return userDao.panduanzhuce(loginname);
    }

    @Override
    public int zhuce(String loginname, String pwd) {
        return userDao.zhuce(loginname,pwd);
    }

    //查询所有员工信息
    @Override
    public List<UserInfo> queryUserAll() {
        return userDao.queryUserAll();
    }

    @Override
    public int addUserInfo(UserInfo userInfo) {
        return userDao.addUserInfo(userInfo);
    }

    @Override
    public int delUserInfoByid(int id) {
        return userDao.delUserInfoByid(id);
    }

    @Override
    public UserInfo queryuserByid(int id) {
        return userDao.queryuserByid(id);
    }

    @Override
    public int updateuser(UserInfo userInfo) {
        return userDao.updateuser(userInfo);
    }

    @Override
    public List<UserInfo> queryallguke() {
        return userDao.queryallguke();
    }

    @Override
    public List<Car> queryallCar() {
        return userDao.queryallCar();
    }
}
