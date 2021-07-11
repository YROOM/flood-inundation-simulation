package com.yroom.flooddatainsert.entity;

/**
 * 行号列号在tif文件中的位置
 */
public class NewPoint {
    public int X;          //列号
    public int Y;          //行号
    public double Elevation;  //像素值(高程值)

    public NewPoint() {
    }

    public NewPoint(int x, int y, double elevation) {
        X = x;
        Y = y;
        Elevation = elevation;
    }

    public int getX() {
        return X;
    }

    public void setX(int x) {
        X = x;
    }

    public int getY() {
        return Y;
    }

    public void setY(int y) {
        Y = y;
    }

    public double getElevation() {
        return Elevation;
    }

    public void setElevation(double elevation) {
        Elevation = elevation;
    }

    @Override
    public String toString() {
        return "NewPoint{" +
                "X=" + X +
                ", Y=" + Y +
                ", Elevation=" + Elevation +
                '}';
    }
}
