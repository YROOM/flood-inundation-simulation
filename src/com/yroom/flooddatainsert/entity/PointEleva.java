package com.yroom.flooddatainsert.entity;

/**
 * 像素点对象
 */
public class PointEleva {
    ////列号
    public int X;
    //行号
    public int Y;
    public double Elevation;  //像素值(高程值)
    public boolean IsFlooded; //淹没标记
    public boolean IsDaba;//标记是否为大坝出水口
    public double FloodLevel; //淹没层级
    public PointEleva parentPoint;//父亲节点
    public PointEleva originPoi;//可识别原始点

    //计算新的点与原始点之间的距离
    public double PerDistance() {
        return Math.sqrt((X - originPoi.X) * (X - originPoi.X) + (Y - originPoi.Y) * (Y - originPoi.Y));
    }

    public PointEleva(int x, int y, double elevation, boolean isFlooded, boolean isDaba, double floodLevel, PointEleva parentPoint, PointEleva originPoi) {
        X = x;
        Y = y;
        Elevation = elevation;
        IsFlooded = isFlooded;
        IsDaba = isDaba;
        FloodLevel = floodLevel;
        this.parentPoint = parentPoint;
        this.originPoi = originPoi;
    }

    public PointEleva() {
    }

    @Override
    public String toString() {
        return "PointEleva{" +
                "X=" + X +
                ", Y=" + Y +
                ", Elevation=" + Elevation +
                ", IsFlooded=" + IsFlooded +
                ", IsDaba=" + IsDaba +
                ", FloodLevel=" + FloodLevel +
                ", parentPoint=" + parentPoint +
                ", originPoi=" + originPoi +
                '}';
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

    public boolean isFlooded() {
        return IsFlooded;
    }

    public void setFlooded(boolean flooded) {
        IsFlooded = flooded;
    }

    public boolean isDaba() {
        return IsDaba;
    }

    public void setDaba(boolean daba) {
        IsDaba = daba;
    }

    public double getFloodLevel() {
        return FloodLevel;
    }

    public void setFloodLevel(double floodLevel) {
        FloodLevel = floodLevel;
    }

    public PointEleva getParentPoint() {
        return parentPoint;
    }

    public void setParentPoint(PointEleva parentPoint) {
        this.parentPoint = parentPoint;
    }

    public PointEleva getOriginPoi() {
        return originPoi;
    }

    public void setOriginPoi(PointEleva originPoi) {
        this.originPoi = originPoi;
    }
}
