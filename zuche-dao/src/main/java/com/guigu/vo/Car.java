package com.guigu.vo;

public class Car {
    Integer carid;
    String cartype;
    String lpnumber;
    String carcolor;
    Float price;
    String free;

    public Car() {
    }

    public Car(Integer carid, String cartype, String lpnumber, String carcolor, Float price, String free) {
        this.carid = carid;
        this.cartype = cartype;
        this.lpnumber = lpnumber;
        this.carcolor = carcolor;
        this.price = price;
        this.free = free;
    }

    public Integer getCarid() {
        return carid;
    }

    public void setCarid(Integer carid) {
        this.carid = carid;
    }

    public String getCartype() {
        return cartype;
    }

    public void setCartype(String cartype) {
        this.cartype = cartype;
    }

    public String getLpnumber() {
        return lpnumber;
    }

    public void setLpnumber(String lpnumber) {
        this.lpnumber = lpnumber;
    }

    public String getCarcolor() {
        return carcolor;
    }

    public void setCarcolor(String carcolor) {
        this.carcolor = carcolor;
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    public String getFree() {
        return free;
    }

    public void setFree(String free) {
        this.free = free;
    }

    @Override
    public String toString() {
        return "Car{" +
                "carid=" + carid +
                ", cartype='" + cartype + '\'' +
                ", lpnumber='" + lpnumber + '\'' +
                ", carcolor='" + carcolor + '\'' +
                ", price=" + price +
                ", free='" + free + '\'' +
                '}';
    }
}
