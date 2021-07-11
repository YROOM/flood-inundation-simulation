package com.yroom.flooddatainsert.entity;

public class WaterInfo {
    public float waterl;
    public String waterdeep;
    public String watersquare;
    public String maxlen;
    public String waterq;

    public WaterInfo(float waterl, String waterdeep, String watersquare, String maxlen, String waterq) {
        this.waterl = waterl;
        this.waterdeep = waterdeep;
        this.watersquare = watersquare;
        this.maxlen = maxlen;
        this.waterq = waterq;
    }

    public float getWaterl() {
        return waterl;
    }

    public void setWaterl(float waterl) {
        this.waterl = waterl;
    }

    public String getWaterdeep() {
        return waterdeep;
    }

    public void setWaterdeep(String waterdeep) {
        this.waterdeep = waterdeep;
    }

    public String getWatersquare() {
        return watersquare;
    }

    public void setWatersquare(String watersquare) {
        this.watersquare = watersquare;
    }

    public String getMaxlen() {
        return maxlen;
    }

    public void setMaxlen(String maxlen) {
        this.maxlen = maxlen;
    }

    public String getWaterq() {
        return waterq;
    }

    public void setWaterq(String waterq) {
        this.waterq = waterq;
    }

    public WaterInfo() {
    }

    @Override
    public String toString() {
        return "WaterInfo{" +
                "waterl=" + waterl +
                ", waterdeep='" + waterdeep + '\'' +
                ", watersquare='" + watersquare + '\'' +
                ", maxlen='" + maxlen + '\'' +
                ", waterq='" + waterq + '\'' +
                '}';
    }
}
