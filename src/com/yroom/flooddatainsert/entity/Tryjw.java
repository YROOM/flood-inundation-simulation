package com.yroom.flooddatainsert.entity;

public class Tryjw {
    //经度
    public String longitude;
    //纬度
    public String latitude;

    public Tryjw(String longitude, String latitude) {
        this.longitude = longitude;
        this.latitude = latitude;
    }

    public Tryjw() {

    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    @Override
    public String toString() {
        return "Tryjw{" +
                "longitude='" + longitude + '\'' +
                ", latitude='" + latitude + '\'' +
                '}';
    }
}
