package com.guigu.controller;

import com.guigu.service.MenuService;
import com.guigu.vo.MenuInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class MenuController {

    @Autowired
    MenuService menuService;


    //查询出所有的菜单信息(菜单显示用，有层级关系)
    @RequestMapping("/queryallmenus.action")
    @ResponseBody
    public List<MenuInfo> queryallmenus(){

        return  menuService.queryallmenus(2,0);
    }

    //查询出所有的菜单信息(授权页面用，显示到按钮级别)
    //2020-10-12修改
    @RequestMapping("/queryallmenus2.action")
    @ResponseBody
    public List<MenuInfo> queryallmenus2(int rid){

        return  menuService.queryallmenus(3,rid);
    }

    @RequestMapping(value = "/auth.action",produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public String authSave(
            @RequestParam(value = "menuids",defaultValue = "")String menuids,
          @RequestParam(value = "roleid",defaultValue = "0")  int roleid){
        System.out.println("roleid:"+roleid);
        System.out.println("mids:"+menuids);

        String[] arr= menuids.split(",");
        //写一个给角色权限表rolemenu_info 先删除再添加的方法
        //执行删除权限方法
        int row =menuService.delQuanxianByid(roleid);
        for (int i=0;i<arr.length;i++ ) {
            //执行给角色赋予菜单权限
            menuService.addQuanxianByid(roleid,arr[i]);
        }
        return "授权成功";
    }

}
