package com.guigu.dao;

import com.guigu.vo.Car;
import com.guigu.vo.RoleInfo;
import com.guigu.vo.UserInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {

    //根据用户名和密码  租客登录验证
    public UserInfo zukelogin(@Param("loginname") String loginname,
                              @Param("pwd") String pwd);
    //根据用户名和密码  员工登录验证
    public UserInfo yuangonlogin(@Param("loginname") String loginname,
                              @Param("pwd") String pwd);
    //判断账号是否被注册
    public UserInfo panduanzhuce(String loginname);

    //注册
    public int zhuce(@Param("loginname") String loginname,
                              @Param("pwd") String pwd);

    //查询所有员工信息
    public List<UserInfo> queryUserAll();
    //添加员工
    public int addUserInfo(UserInfo userInfo);
    //根据id删除员工
    public int delUserInfoByid(int id);
    //根据id查询员工详情
    public UserInfo queryuserByid(int id);
    //根据员工实体修改员工详情  修改
    public int updateuser(UserInfo userInfo);

    //查询所有顾客信息
    public List<UserInfo> queryallguke();
    //查询所有车信息
    public List<Car> queryallCar();

}
