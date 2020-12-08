package com.guigu.vo;

public class HuanCheDingDan {
    int id;
    int hcddid;
    int carid;
    int gukeid;
    Float zujin;
    String state;
    String shenpiren;


    public HuanCheDingDan() {
    }

    public HuanCheDingDan(int id, int hcddid, int carid, int gukeid, Float zujin, String state, String shenpiren) {
        this.id = id;
        this.hcddid = hcddid;
        this.carid = carid;
        this.gukeid = gukeid;
        this.zujin = zujin;
        this.state = state;
        this.shenpiren = shenpiren;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getHcddid() {
        return hcddid;
    }

    public void setHcddid(int hcddid) {
        this.hcddid = hcddid;
    }

    public int getCarid() {
        return carid;
    }

    public void setCarid(int carid) {
        this.carid = carid;
    }

    public int getGukeid() {
        return gukeid;
    }

    public void setGukeid(int gukeid) {
        this.gukeid = gukeid;
    }

    public Float getZujin() {
        return zujin;
    }

    public void setZujin(Float zujin) {
        this.zujin = zujin;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getShenpiren() {
        return shenpiren;
    }

    public void setShenpiren(String shenpiren) {
        this.shenpiren = shenpiren;
    }

    @Override
    public String toString() {
        return "HuanCheDingDan{" +
                "id=" + id +
                ", hcddid=" + hcddid +
                ", carid=" + carid +
                ", gukeid=" + gukeid +
                ", zujin=" + zujin +
                ", state='" + state + '\'' +
                ", shenpiren='" + shenpiren + '\'' +
                '}';
    }
}
