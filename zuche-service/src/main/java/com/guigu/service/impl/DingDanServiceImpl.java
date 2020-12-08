package com.guigu.service.impl;

import com.guigu.dao.DingDanDao;
import com.guigu.dao.RoleDao;
import com.guigu.service.DingDanService;
import com.guigu.service.RoleService;
import com.guigu.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DingDanServiceImpl implements DingDanService {

    @Autowired
    DingDanDao dingDanDao;


    @Override
    public List<DingDan> queryDingdanByid(int gukeid) {
        return dingDanDao.queryDingdanByid(gukeid);
    }

    @Override
    public int chonzhi(int id, float jine) {
        return dingDanDao.chonzhi(id,jine);
    }

    @Override
    public Float chaxunBalance(int id) {
        return dingDanDao.chaxunBalance(id);
    }

    @Override
    public int dingdan(int carid, int gukeid, String zucardidian, String rentalTime, float deposit) {
        return dingDanDao.dingdan(carid,gukeid,zucardidian,rentalTime,deposit);
    }

    @Override
    public int kouyajin(int id, float deposit) {
        return dingDanDao.kouyajin(id,deposit);
    }

    @Override
    public List<DingDan> queryDingdanWeishenhe() {
        return dingDanDao.queryDingdanWeishenhe();
    }

    @Override
    public int updateDingDanzt(int ddid, String shenpiren) {
        return dingDanDao.updateDingDanzt(ddid,shenpiren);
    }


    @Override
    public int tonyishenpi(int ddid, int carid, int gukeid, String shenpiren, String caozuotime) {
        return dingDanDao.tonyishenpi(ddid,carid,gukeid,shenpiren,caozuotime);
    }

    @Override
    public List<DingDanJiLu> queryDingDanJiLuAll() {
        return dingDanDao.queryDingDanJiLuAll();
    }

    @Override
    public List<DingDan> queryDingdanAll() {
        return dingDanDao.queryDingdanAll();
    }

    @Override
    public int updateDingDanztJuJue(int ddid, String shenpiren) {
        return dingDanDao.updateDingDanztJuJue(ddid,shenpiren);
    }

    @Override
    public int jujueshenpi(int ddid, int carid, int gukeid, String shenpiren, String caozuotime) {
        return dingDanDao.jujueshenpi(ddid,carid,gukeid,shenpiren,caozuotime);
    }

    @Override
    public DingDan queryDingById(int id) {
        return dingDanDao.queryDingById(id);
    }

    @Override
    public Float queryCarzujin(int id) {
        return dingDanDao.queryCarzujin(id);
    }

    @Override
    public List<HuanCheDingDan> queryDingdanHuanCheWeishenhe() {
        return dingDanDao.queryDingdanHuanCheWeishenhe();
    }

    @Override
    public int huanche(int hcddid, int carid, String gukeid, float zujin) {
        return dingDanDao.huanche(hcddid,carid,gukeid,zujin);
    }

    @Override
    public int updateDingDanStateHuanCheDaiShengHe(int id,String huancarTime) {
        return dingDanDao.updateDingDanStateHuanCheDaiShengHe(id,huancarTime);
    }

    @Override
    public int jianBalanceByid(int id, float zujin) {
        return dingDanDao.jianBalanceByid(id,zujin);
    }

    @Override
    public int updateHuanCheDingDanzt11(int ddid, String shenpiren) {
        return dingDanDao.updateHuanCheDingDanzt11(ddid,shenpiren);
    }

    @Override
    public int updateHuanCheDingDanzt(int ddid, String shenpiren) {
        return dingDanDao.updateHuanCheDingDanzt(ddid,shenpiren);
    }

    @Override
    public int tonyiHuanCheshenpi(int ddid, int carid, int gukeid, String shenpiren, String caozuotime) {
        return dingDanDao.tonyiHuanCheshenpi(ddid,carid,gukeid,shenpiren,caozuotime);
    }

    @Override
    public int tuiyajin(String id, float yajin) {
        return dingDanDao.tuiyajin(id,yajin);
    }


    @Override
    public List<DingDanJiLu> queryHuanCheDingDanJiLuAll() {
        return dingDanDao.queryHuanCheDingDanJiLuAll();
    }
}
