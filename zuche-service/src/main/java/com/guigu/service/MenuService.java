package com.guigu.service;

import com.guigu.vo.MenuInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MenuService {


    /**   2020-10-12修改
     * 查询指定节点类型的菜单信息
     * @param nodetype   节点类型  文件夹 0    页面 1   按钮 3
     * @param rid  角色id   如果角色id为0 不做处理  不为0 设置当前角色id的权限菜单checked状态
     * @return
     */
    public List<MenuInfo> queryallmenus(int nodetype, int rid);

    //根据角色id删除角色权限
    public int delQuanxianByid(int rid);

    //根据角色id给角色赋予菜单权限
    public int addQuanxianByid(@Param("rid") int rid,
                               @Param("mid") String mid);
    //根据员工id查询他拥有的菜单id
    public List<MenuInfo> querymenuByuid(int uid);

}
