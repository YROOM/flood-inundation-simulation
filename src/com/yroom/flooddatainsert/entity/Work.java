package com.yroom.flooddatainsert.entity;

public class Work {
    public double Waterreal;
    public long times;
    public double qulity;
    public double youyuan;
    public int countyouyuan;

    public Work(double waterreal, long times, double qulity, double youyuan, int countyouyuan) {
        Waterreal = waterreal;
        this.times = times;
        this.qulity = qulity;
        this.youyuan = youyuan;
        this.countyouyuan = countyouyuan;
    }

    public Work() {
    }

    @Override
    public String toString() {
        return "Work{" +
                "Waterreal=" + Waterreal +
                ", times=" + times +
                ", qulity=" + qulity +
                ", youyuan=" + youyuan +
                ", countyouyuan=" + countyouyuan +
                '}';
    }

    public double getYouyuan() {
        return youyuan;
    }

    public void setYouyuan(double youyuan) {
        this.youyuan = youyuan;
    }

    public int getCountyouyuan() {
        return countyouyuan;
    }

    public void setCountyouyuan(int countyouyuan) {
        this.countyouyuan = countyouyuan;
    }

    public double getWaterreal() {
        return Waterreal;
    }

    public void setWaterreal(double waterreal) {
        Waterreal = waterreal;
    }

    public long getTimes() {
        return times;
    }

    public void setTimes(long times) {
        this.times = times;
    }

    public double getQulity() {
        return qulity;
    }

    public void setQulity(double qulity) {
        this.qulity = qulity;
    }
}
