package com.yroom.flooddatainsert.entity;

/**
 * 模拟判断点是否可以返回的点
 */
public class Fpoint {
    public int X;
    public int Y;

    public Fpoint() {
    }

    public Fpoint(int x, int y) {
        X = x;
        Y = y;
    }

    @Override
    public String toString() {
        return "Fpoint{" +
                "X=" + X +
                ", Y=" + Y +
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
}
