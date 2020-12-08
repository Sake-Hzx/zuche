package com.guigu.dao;

import com.guigu.vo.RoleInfo;

import java.util.List;

public interface RoleDao {

    /**
     * 获取所有的角色信息
     * @return  角色信息集合
     */
    public List<RoleInfo> queryallroles();

    /**
     * 根据用户id，查询当前用户拥有的角色信息
     * @param uid  用户id
     * @return 角色信息集合
     */
    public List<RoleInfo> queryRolesByuid(int uid);
}
