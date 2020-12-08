package com.guigu.controller;

import com.guigu.dao.DingDanDao;
import com.guigu.service.DingDanService;
import com.guigu.service.RoleService;
import com.guigu.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class DingDanController {

    @Autowired
    DingDanService dingDanService;

    //根据顾客id 查询该顾客的订单信息
    @RequestMapping(value = "/queryDingdanByid.action", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public List<DingDan> queryDingdanByid(int id) {
        //System.out.println(id);
        //System.out.println(dingDanService.queryDingdanByid(69));
        return dingDanService.queryDingdanByid(id);
    }

    //充值余额方法
    @RequestMapping(value = "/chonzhi.action", produces = {"application/html;charset=utf-8"})
    @ResponseBody
    public String chonzhi(int id, float jine) {
        //System.out.println(id);
        //System.out.println(jine);
        //System.out.println(dingDanService.queryDingdanByid(69));
        int row = dingDanService.chonzhi(id, jine);
        //System.out.println(row);
        if (row > 0) {
            return "充值成功";
        }
        return "充值失败";
    }

    //根据顾客id，查询顾客余额
    @RequestMapping(value = "/chaxunBalance.action", produces = {"application/html;charset=utf-8"})
    @ResponseBody
    public String chaxunBalance(int id) {

        float row=dingDanService.chaxunBalance(id);
        //System.out.println(row);

        return row+"";
    }
    //提交订单 并且扣钱 没审核也扣 审核拒绝了就退还钱
    @RequestMapping(value = "/dingdan.action", produces = {"application/html;charset=utf-8"})
    @ResponseBody
    public String dingdan(int carid,int gukeid, String zucardidian, float deposit) {
        //车子的id carid
        //类型id  carid
        //获取顾客id gukeid
        //地址  zucardidian
        //获取当前时间  rentalTime
        Date date = new Date();
        SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd");
        //押金  deposit
       int row = dingDanService.dingdan(carid,gukeid,zucardidian,dateFormat.format(date),deposit);
        //从用户余额扣除押金
        dingDanService.kouyajin(gukeid,deposit);
        if (row>0){
            return "成功";
        }
       return "失败";
    }

    //查询所有未审核订单信息
    @RequestMapping(value = "/queryDingdanWeishenhe.action", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public List<DingDan> queryDingdanWeishenhe() {
        //System.out.println(id);
        //System.out.println(dingDanService.queryDingdanByid(69));
        return dingDanService.queryDingdanWeishenhe();
    }
    //同意审批
    @RequestMapping(value = "/tonyishenpi.action", produces = {"application/html;charset=utf-8"})
    @ResponseBody
    public String tonyishenpi(int ddid,int carid,int gukeid,String shenpiren) {
        /*System.out.println(ddid);
        System.out.println(carid);
        System.out.println(gukeid);
        System.out.println(shenpiren);*/
        //修改订单表里这个订单的状态为租赁中  修改审批人
        int row =dingDanService.updateDingDanzt(ddid,shenpiren);
        //给记录表添加同意记录
        Date date = new Date();
        SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd");
        int row1=dingDanService.tonyishenpi(ddid,carid,gukeid,shenpiren,dateFormat.format(date));

        if (row>0 && row1>0){
            return "成功";
        }
        return "失败";
    }
    //拒绝审批
    @RequestMapping(value = "/jujueshenpi.action", produces = {"application/html;charset=utf-8"})
    @ResponseBody
    public String jujueshenpi(int ddid,int carid,int gukeid,String shenpiren) {
        //修改订单表里这个订单的状态为已拒绝  修改审批人
        int row =dingDanService.updateDingDanztJuJue(ddid,shenpiren);
        //给记录表添加拒绝记录
        Date date = new Date();
        SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd");
        int row1=dingDanService.jujueshenpi(ddid,carid,gukeid,shenpiren,dateFormat.format(date));

        if (row>0 && row1>0){
            return "成功";
        }
        return "失败";
    }
    //查询所有租车订单记录信息
    @RequestMapping(value = "/zuchejilu.action", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public List<DingDanJiLu> queryDingDanJiLuAll() {
        //System.out.println(id);
        //System.out.println(dingDanService.queryDingdanByid(69));

        return dingDanService.queryDingDanJiLuAll();
    }
    //查询所有租车订单
    @RequestMapping(value = "/queryDingdanAll.action", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public List<DingDan> queryDingdanAll() {
        //System.out.println(id);
        //System.out.println(dingDanService.queryDingdanByid(69));
        return dingDanService.queryDingdanAll();
    }

    //用户点击还车 根据订单id  算租金 返回租金
    @RequestMapping(value = "/fanhuizujin.action", produces = {"application/html;charset=utf-8"})
    @ResponseBody
    public String huancheshenqin(int id) {
        //根据订单id查询订单详情
        DingDan dingDan=dingDanService.queryDingById(id);
        //System.out.println(dingDan);
        //获取订单租车时间
        String zuchetime=dingDan.getRentalTime();
        String[] zuchetime1=zuchetime.split("-");
        //获取订单还车时间 获取当前时间
        Date date = new Date();
        SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd");
        String huanchetime=dateFormat.format(date);
        String[] huanchetime1=huanchetime.split("-");
        //还车时间减去租车时间得到天数
        int tianshi=Integer.parseInt(huanchetime1[2])-Integer.parseInt(zuchetime1[2]);
        //拿到订单租的车的日租金  写一个车实体
        //根据车id获取该车的日租金
        Float rizujin=dingDanService.queryCarzujin(dingDan.getCarid());
        //天数*日租金=租金
        Float zujin=rizujin*tianshi;
        //System.out.println(zujin);
        //返回租金
        return zujin+"";
    }

    //查询所有未审核的还车申请
    @RequestMapping(value = "/queryDingdanHuanCheWeishenhe.action", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public List<HuanCheDingDan> queryDingdanHuanCheWeishenhe() {
        //System.out.println(id);
        return dingDanService.queryDingdanHuanCheWeishenhe();
    }
    //点击确定还车按钮 提交还车申请
    @RequestMapping(value = "/huancheshenqin.action", produces = {"application/html;charset=utf-8"})
    @ResponseBody
    public String huancheshenqin(int ddid,float zujin) {
        //根据订单id查询该订单的详情
        DingDan dingDan=dingDanService.queryDingById(ddid);
        //获取车辆id
        dingDan.getCarid();
        //获取顾客id
        dingDan.getGukeid();

        //执行发送还车申请
        int row =dingDanService.huanche(ddid,dingDan.getCarid(), dingDan.getGukeid(),zujin);
        //根据订单id修改订单的状态为 还车待审核  还车时间为当前时间
        Date date = new Date();
        SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd");
        String huanchetime=dateFormat.format(date);
        int row1 =dingDanService.updateDingDanStateHuanCheDaiShengHe(ddid,huanchetime);
        if (row>0&&row1>0){
            //根据顾客id 扣除余额
            dingDanService.jianBalanceByid(Integer.parseInt(dingDan.getGukeid()),zujin);
            return "还车申请提交成功";
        }
        return "失败";
    }

    //同意还车 审批
    @RequestMapping(value = "/tonyiHuanCheshenpi.action", produces = {"application/html;charset=utf-8"})
    @ResponseBody
    public String tonyiHuanCheshenpi(int ddid,String shenpiren) {
        //根据订单id查询该订单的详情
        DingDan dingDan=dingDanService.queryDingById(ddid);
        //修改还车订单审批的记录信息 状态为已结算  修改审批人
        int row2 = dingDanService.updateHuanCheDingDanzt11(ddid,shenpiren);
        //修改订单表里这个订单的状态为已结算  修改审批人
        int row = dingDanService.updateHuanCheDingDanzt(ddid,shenpiren);
        //给记录表添加还车同意记录
        Date date = new Date();
        SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd");
        String huanchetime=dateFormat.format(date);
        int row1 = dingDanService.tonyiHuanCheshenpi(ddid, dingDan.getCarid(),Integer.parseInt(dingDan.getGukeid()),shenpiren,huanchetime);

        if (row>0 && row1>0 && row2>0){
            //退还押金
            dingDanService.tuiyajin(dingDan.getGukeid(),dingDan.getDeposit());
            return "成功";
        }
        return "失败";
    }

    //查询所有还车订单记录信息
    @RequestMapping(value = "/huanchejilu.action", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public List<DingDanJiLu> queryHuanCheDingDanJiLuAll() {
        //System.out.println(id);
        //System.out.println(dingDanService.queryDingdanByid(69));

        return dingDanService.queryHuanCheDingDanJiLuAll();
    }


}
