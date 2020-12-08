package com.guigu.controller;

import com.guigu.service.RoleService;
import com.guigu.vo.RoleInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;

@Controller
public class RoleController {

    @Autowired
    RoleService roleService;

    @RequestMapping("/queryallroles.action")
    @ResponseBody
    public List<RoleInfo> queryallroles(){

        return roleService.queryallroles();
    }

    //注销登录的session
    @RequestMapping("/zhuxiao.action")
    public String zhuxiao(HttpSession session){
        //session.invalidate();
        session.removeAttribute("zukeuser"); //适用于清空指定的属性
        return "redirect:/login.jsp";
    }

}
