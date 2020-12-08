package com.guigu.service.impl;

import com.guigu.dao.RoleDao;
import com.guigu.service.RoleService;
import com.guigu.vo.RoleInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class  RoleServiceImpl  implements RoleService {

    @Autowired
    RoleDao roleDao;

    @Override
    public List<RoleInfo> queryallroles() {
        return roleDao.queryallroles();
    }
}
