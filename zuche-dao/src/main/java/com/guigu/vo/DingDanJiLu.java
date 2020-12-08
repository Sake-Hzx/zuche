package com.guigu.vo;

public class DingDanJiLu {
    int id;
    int ddid;
    int carid;
    int gukeid;
    String state;
    String shenpiren;
    String caozuo;
    String caozuotime;

    public DingDanJiLu() {
    }

    public DingDanJiLu(int id, int ddid, int carid, int gukeid, String state, String shenpiren, String caozuo, String caozuotime) {
        this.id = id;
        this.ddid = ddid;
        this.carid = carid;
        this.gukeid = gukeid;
        this.state = state;
        this.shenpiren = shenpiren;
        this.caozuo = caozuo;
        this.caozuotime = caozuotime;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getDdid() {
        return ddid;
    }

    public void setDdid(int ddid) {
        this.ddid = ddid;
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

    public String getCaozuo() {
        return caozuo;
    }

    public void setCaozuo(String caozuo) {
        this.caozuo = caozuo;
    }

    public String getCaozuotime() {
        return caozuotime;
    }

    public void setCaozuotime(String caozuotime) {
        this.caozuotime = caozuotime;
    }

    @Override
    public String toString() {
        return "DingDanJiLu{" +
                "id=" + id +
                ", ddid=" + ddid +
                ", carid=" + carid +
                ", gukeid=" + gukeid +
                ", state='" + state + '\'' +
                ", shenpiren='" + shenpiren + '\'' +
                ", caozuo='" + caozuo + '\'' +
                ", caozuotime='" + caozuotime + '\'' +
                '}';
    }
}
