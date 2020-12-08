package com.guigu.dao;

import com.guigu.vo.MenuInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MenuDao {



    /**
     * 根据父id,菜单类型 查询子菜单信息
     *
     * @param pid   父id
     * @param nodeType 菜单类型
     * @return
     */
    public List<MenuInfo> querymenuBypidandnodeType(@Param("pid") int pid, @Param("nodeType") int nodeType);


    /**   2020-10-12修改
     * 根据角色id查询当前可操作的菜单
     * @param rid  角色id
     * @return
     */
    public List<Integer> querymenuidbyrid(int rid);

    //根据角色id删除角色权限
    public int delQuanxianByid(int rid);

    //根据角色id给角色赋予菜单权限
    public int addQuanxianByid(@Param("rid") int rid,
                               @Param("mid") String mid);
    //根据员工id查询他拥有的菜单id
    public List<MenuInfo> querymenuByuid(int uid);

}
