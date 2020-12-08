package com.guigu.vo;

public class UserInfo {

    private Integer id;

    private String name;

    private String loginname;

    private String password;

    private String isdelete;
    //是否是员工  0顾客1员工
    private String isyuangonorguke;
    //余额
    private Float balance;

    public UserInfo() {
    }

    public UserInfo(Integer id, String name, String loginname, String password, String isdelete, String isyuangonorguke, Float balance) {
        this.id = id;
        this.name = name;
        this.loginname = loginname;
        this.password = password;
        this.isdelete = isdelete;
        this.isyuangonorguke = isyuangonorguke;
        this.balance = balance;
    }

    public String getIsyuangonorguke() {
        return isyuangonorguke;
    }

    public void setIsyuangonorguke(String isyuangonorguke) {
        this.isyuangonorguke = isyuangonorguke;
    }

    public Float getBalance() {
        return balance;
    }

    public void setBalance(Float balance) {
        this.balance = balance;
    }

    public String getIsdelete() {
        return isdelete;
    }

    public void setIsdelete(String isdelete) {
        this.isdelete = isdelete;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLoginname() {
        return loginname;
    }

    public void setLoginname(String loginname) {
        this.loginname = loginname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "UserInfo{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", loginname='" + loginname + '\'' +
                ", password='" + password + '\'' +
                ", isdelete='" + isdelete + '\'' +
                ", isyuangonorguke='" + isyuangonorguke + '\'' +
                ", balance=" + balance +
                '}';
    }
}
