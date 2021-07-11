package com.yroom.flooddatainsert.entity;

public class Shuishen {
    //淹没包含的高程
    public String  grid;
    //经度
    public String longitude;
    //纬度
    public String latitude;

    public String getGrid() {
        return grid;
    }

    public void setGrid(String grid) {
        this.grid = grid;
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

    public Shuishen() {
    }

    public Shuishen(String grid, String longitude, String latitude) {
        this.grid = grid;
        this.longitude = longitude;
        this.latitude = latitude;
    }

    @Override
    public String toString() {
        return "Shuishen{" +
                "grid='" + grid + '\'' +
                ", longitude='" + longitude + '\'' +
                ", latitude='" + latitude + '\'' +
                '}';
    }
}
