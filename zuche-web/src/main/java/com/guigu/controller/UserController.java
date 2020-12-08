package com.guigu.controller;

import com.guigu.service.MenuService;
import com.guigu.service.UserService;
import com.guigu.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    UserService userService;
    @Autowired
    MenuService menuService;

    //租客登录方法
    @RequestMapping(value = "/login.action", produces = "text/html;charset=utf-8")
    @ResponseBody
    public String login(String loginname, String pwd, HttpSession session) {
        UserInfo zukeuser = userService.zukelogin(loginname,pwd);
        if (zukeuser != null) {
            //将对象 存入session
            session.setAttribute("zukeuser", zukeuser);

            //session.invalidate();
            return "登录成功";
        }else {
            return "账号或密码错误";
        }
    }

    //员工登录方法
    @RequestMapping(value = "/yuangonlogin.action", produces = "text/html;charset=utf-8")
    @ResponseBody
    public String yuangonlogin(String loginname, String pwd, HttpSession session) {
        UserInfo yuangonuser = userService.yuangonlogin(loginname,pwd);
        if (yuangonuser != null) {
            //将对象 存入session
            session.setAttribute("yuangonuser", yuangonuser);

            List<MenuInfo>list=menuService.querymenuByuid(yuangonuser.getId());
            List<String> list1= new ArrayList<>();

            for (MenuInfo menuInfo:list){
                list1.add(menuInfo.getMenuCode());
            }
            session.setAttribute("list",list1);

            return "登录成功";
        }else {
            return "账号或密码错误";
        }
    }
    //判断账号是否被注册
    @RequestMapping(value = "/panduanzhuce.action", produces = "text/html;charset=utf-8")
    @ResponseBody
    public String panduanzhuce(String loginname) {
        UserInfo userInfo=userService.panduanzhuce(loginname);
        System.out.println(userInfo);
        if (userInfo!=null) {
            return "账户名已被使用";
        } else {
            return "可以注册";
        }
    }
    //注册
    @RequestMapping(value = "/zhuce.action", produces = "text/html;charset=utf-8")
    @ResponseBody
    public String zhuce(String loginname, String pwd) {

        int row = userService.zhuce(loginname,pwd);

        if (row > 0) {
            return "注册成功";
        } else {
            return "注册失败";
        }
    }

    //查询所有员工
    @RequestMapping("/queryUserAll.action")
    @ResponseBody
    public List<UserInfo> queryUserAll() {
        //System.out.println("name==="+name);
        //System.out.println(userService.queryUserAll());
        return userService.queryUserAll();
    }

    //添加员工方法
    @RequestMapping(value = "/addyuangon.action", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public Map addPerson(UserInfo userInfo) {
        //System.out.println(userInfo);
        int num = userService.addUserInfo(userInfo);
        Map<String, String> map = new HashMap<String, String>();
        //System.out.println(num);
        if (num > 0) {
            map.put("msg", "添加成功");
            map.put("code", "1");
        } else {
            map.put("msg", "添加失败");
            map.put("code", "0");
        }
        return map;
    }

    //删除
    @RequestMapping(value = "/deluser.action", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public int del(int id) {
        int row = userService.delUserInfoByid(id);
        if (row > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    //根据id查询员工详情
    @RequestMapping(value = "/queryuserByid.action", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public UserInfo queryuserByid(int id) {

       UserInfo userInfo = userService.queryuserByid(id);

        if (userInfo!=null) {
            return userInfo;
        } else {
            return null;
        }
    }
    //修改员工信息
    @RequestMapping(value = "/updateyuangon.action", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public int updateyuangon(UserInfo userInfo) {
        int row = userService.updateuser(userInfo);
        if (row > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    //查询所有顾客信息
    @RequestMapping("/queryallguke.action")
    @ResponseBody
    public List<UserInfo> queryGuKeAll() {
        //System.out.println("name==="+name);
        //System.out.println(userService.queryUserAll());
        return userService.queryallguke();
    }

    //查询所有车信息
    @RequestMapping("/queryallcar.action")
    @ResponseBody
    public List<Car> queryCarAll() {
        //System.out.println("name==="+name);
        System.out.println(userService.queryallCar());
        return userService.queryallCar();
    }
}
