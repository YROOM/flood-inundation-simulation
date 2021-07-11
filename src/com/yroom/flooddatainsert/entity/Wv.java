package com.yroom.flooddatainsert.entity;

public class Wv {
   public  double waterl;
   public double Qutiy;

    @Override
    public String toString() {
        return "Wv{" +
                "waterl=" + waterl +
                ", Qutiy=" + Qutiy +
                '}';
    }

    public double getWaterl() {
        return waterl;
    }

    public void setWaterl(double waterl) {
        this.waterl = waterl;
    }

    public double getQutiy() {
        return Qutiy;
    }

    public void setQutiy(double qutiy) {
        Qutiy = qutiy;
    }

    public Wv() {
    }

    public Wv(double waterl, double qutiy) {
        this.waterl = waterl;
        Qutiy = qutiy;
    }
}
