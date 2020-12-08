package com.guigu.vo;

public class DingDan {
    //编号
    Integer zucarid;
    //车编号   用来数据操作
    Integer carid;
    //车类型   用来显示
    String cartype;
    //顾客的id  实体类写string
    String gukeid;
    //租车地址
    String zucardidian;
    //租车时间
    String rentalTime;
    //还车时间
    String huancarTime;
    //押金
    Float deposit;
    //审批人
    String name;
    //状态
    String state;

    public DingDan() {
    }

    public DingDan(Integer zucarid, Integer carid, String cartype, String gukeid, String zucardidian, String rentalTime, String huancarTime, Float deposit, String name, String state) {
        this.zucarid = zucarid;
        this.carid = carid;
        this.cartype = cartype;
        this.gukeid = gukeid;
        this.zucardidian = zucardidian;
        this.rentalTime = rentalTime;
        this.huancarTime = huancarTime;
        this.deposit = deposit;
        this.name = name;
        this.state = state;
    }

    public String getCartype() {
        return cartype;
    }

    public void setCartype(String cartype) {
        this.cartype = cartype;
    }

    public Integer getZucarid() {
        return zucarid;
    }

    public void setZucarid(Integer zucarid) {
        this.zucarid = zucarid;
    }

    public Integer getCarid() {
        return carid;
    }

    public void setCarid(Integer carid) {
        this.carid = carid;
    }

    public String getGukeid() {
        return gukeid;
    }

    public void setGukeid(String gukeid) {
        this.gukeid = gukeid;
    }

    public String getZucardidian() {
        return zucardidian;
    }

    public void setZucardidian(String zucardidian) {
        this.zucardidian = zucardidian;
    }

    public String getRentalTime() {
        return rentalTime;
    }

    public void setRentalTime(String rentalTime) {
        this.rentalTime = rentalTime;
    }

    public String getHuancarTime() {
        return huancarTime;
    }

    public void setHuancarTime(String huancarTime) {
        this.huancarTime = huancarTime;
    }

    public Float getDeposit() {
        return deposit;
    }

    public void setDeposit(Float deposit) {
        this.deposit = deposit;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    @Override
    public String toString() {
        return "DingDan{" +
                "zucarid=" + zucarid +
                ", carid=" + carid +
                ", cartype='" + cartype + '\'' +
                ", gukeid='" + gukeid + '\'' +
                ", zucardidian='" + zucardidian + '\'' +
                ", rentalTime='" + rentalTime + '\'' +
                ", huancarTime='" + huancarTime + '\'' +
                ", deposit=" + deposit +
                ", name='" + name + '\'' +
                ", state='" + state + '\'' +
                '}';
    }
}
