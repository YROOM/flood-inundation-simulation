package com.yroom.flooddatainsert.entity;

public class Userdef {
    public double waterq;
    public double klongitude;
    public double klatitude;

    public Userdef() {
    }

    @Override
    public String toString() {
        return "Userdef{" +
                "waterq=" + waterq +
                ", klongitude=" + klongitude +
                ", klatitude=" + klatitude +
                '}';
    }

    public Userdef(double waterq, double klongitude, double klatitude) {
        this.waterq = waterq;
        this.klongitude = klongitude;
        this.klatitude = klatitude;
    }

    public double getWaterq() {
        return waterq;
    }

    public void setWaterq(double waterq) {
        this.waterq = waterq;
    }

    public double getKlongitude() {
        return klongitude;
    }

    public void setKlongitude(double klongitude) {
        this.klongitude = klongitude;
    }

    public double getKlatitude() {
        return klatitude;
    }

    public void setKlatitude(double klatitude) {
        this.klatitude = klatitude;
    }
}
