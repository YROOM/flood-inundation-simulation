package com.yroom.flooddatainsert.entity;

/**
 * 经纬度坐标类
 */
public class PoiD {
    public double X;
    public double Y;

    public PoiD() {
    }

    public PoiD(double x, double y) {
        X = x;
        Y = y;
    }

    public void setX(double x) {
        X = x;
    }

    public void setY(double y) {
        Y = y;
    }

    public double getX() {
        return X;
    }

    public double getY() {
        return Y;
    }
}
