package com.yroom.flooddatainsert.entity;

import java.util.Arrays;
import java.util.Date;

/**
 * 声明一个填充像素类
 */
public class FloodFill {

    public int Centeridx;//中间点
    public int leftinterval;//左间距
    public int rightinterval;//右间距
    public String date;//记录时间，渲染的波数

    public double Len;//河流长度
    public double TotalSquare;//总的淹没面积
    public int[] Demtest;
    public int DemCount;

    public int getCenteridx() {
        return Centeridx;
    }

    public void setCenteridx(int centeridx) {
        Centeridx = centeridx;
    }

    public int getLeftinterval() {
        return leftinterval;
    }

    public void setLeftinterval(int leftinterval) {
        this.leftinterval = leftinterval;
    }

    public int getRightinterval() {
        return rightinterval;
    }

    public void setRightinterval(int rightinterval) {
        this.rightinterval = rightinterval;
    }

    public double getLen() {
        return Len;
    }

    public void setLen(double len) {
        Len = len;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public double getTotalSquare() {
        return TotalSquare;
    }

    public void setTotalSquare(double totalSquare) {
        TotalSquare = totalSquare;
    }

    public int[] getDemtest() {
        return Demtest;
    }

    public void setDemtest(int[] demtest) {
        Demtest = demtest;
    }

    public int getDemCount() {
        return DemCount;
    }

    public void setDemCount(int demCount) {
        DemCount = demCount;
    }

    public FloodFill(int centeridx, int leftinterval, int rightinterval, String date, double len, double totalSquare, int[] demtest, int demCount) {
        Centeridx = centeridx;
        this.leftinterval = leftinterval;
        this.rightinterval = rightinterval;
        this.date = date;
        Len = len;
        TotalSquare = totalSquare;
        Demtest = demtest;
        DemCount = demCount;
    }

    @Override
    public String toString() {
        return "FloodFill{" +
                "Centeridx=" + Centeridx +
                ", leftinterval=" + leftinterval +
                ", rightinterval=" + rightinterval +
                ", date='" + date + '\'' +
                ", Len=" + Len +
                ", TotalSquare=" + TotalSquare +
                ", Demtest=" + Arrays.toString(Demtest) +
                ", DemCount=" + DemCount +
                '}';
    }

    public FloodFill() {
    }

}
