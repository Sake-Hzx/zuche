package com.guigu.service;

import com.guigu.vo.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DingDanService {
    //根据顾客id，查询当前顾客的订单信息
    public List<DingDan> queryDingdanByid(int gukeid);
    //根据顾客id，给顾客账户充值余额
    public int chonzhi(@Param("id") int id,
                       @Param("jine") float jine);
    //根据顾客id，查询顾客余额
    public Float chaxunBalance(int id);
    //提交租车订单
    public int dingdan(@Param("carid") int carid,
                       @Param("gukeid") int gukeid,
                       @Param("zucardidian") String zucardidian,
                       @Param("rentalTime") String rentalTime,
                       @Param("deposit") float deposit);
    //订车后从余额扣除押金  租金到还车再结算
    public int kouyajin(@Param("id") int id,
                        @Param("deposit") float deposit);
    //查询所有未审核订单信息
    public List<DingDan> queryDingdanWeishenhe();
    //根据订单id修改订单表里这个订单的状态为租赁中 修改审批人
    public int updateDingDanzt(@Param("ddid") int ddid,
                               @Param("shenpiren") String shenpiren);
    //同意审批
    public int tonyishenpi(@Param("ddid") int ddid,
                           @Param("carid") int carid,
                           @Param("gukeid") int gukeid,
                           @Param("shenpiren") String shenpiren,
                           @Param("caozuotime") String caozuotime);

    //查询所有租车订单记录信息
    public List<DingDanJiLu> queryDingDanJiLuAll();
    //查询所有租车订单
    public List<DingDan> queryDingdanAll();
    //修改订单表里这个订单的状态为已拒绝  修改审批人
    public int updateDingDanztJuJue(@Param("ddid") int ddid,
                                    @Param("shenpiren") String shenpiren);
    //拒绝审批
    public int jujueshenpi(@Param("ddid") int ddid,
                           @Param("carid") int carid,
                           @Param("gukeid") int gukeid,
                           @Param("shenpiren") String shenpiren,
                           @Param("caozuotime") String caozuotime);
    //根据订单id查询订单详情
    public DingDan queryDingById(int id);
    //根据车id获取该车的日租金
    public Float queryCarzujin(int id);
    //查询所有未审核的还车申请
    public List<HuanCheDingDan> queryDingdanHuanCheWeishenhe();
    //提交还车申请
    public int huanche(@Param("hcddid") int hcddid,
                       @Param("carid") int carid,
                       @Param("gukeid") String gukeid,
                       @Param("zujin") float zujin);
    //根据订单id修改订单的状态为 还车待审核  还车时间为当前时间
    public int updateDingDanStateHuanCheDaiShengHe(@Param("id") int id,
                                                   @Param("huancarTime") String huancarTime);
    //根据顾客id 扣除余额
    public int jianBalanceByid(@Param("id") int id,
                               @Param("zujin") float zujin);
    //修改还车订单审批的记录信息 状态为已结算  修改审批人
    public int updateHuanCheDingDanzt11(@Param("ddid") int ddid,
                                        @Param("shenpiren") String shenpiren);
    //修改订单表里这个订单的状态为已结算  修改审批人
    public int updateHuanCheDingDanzt(@Param("ddid") int ddid,
                                      @Param("shenpiren") String shenpiren);
    //给记录表添加还车同意记录
    public int tonyiHuanCheshenpi(@Param("ddid") int ddid,
                                  @Param("carid") int carid,
                                  @Param("gukeid") int gukeid,
                                  @Param("shenpiren") String shenpiren,
                                  @Param("caozuotime") String caozuotime);
    //退还押金
    public int tuiyajin(@Param("id") String id,
                        @Param("yajin") float yajin);
    //查询所有还车订单记录信息
    public List<DingDanJiLu> queryHuanCheDingDanJiLuAll();
}
