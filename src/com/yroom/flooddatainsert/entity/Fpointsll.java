package com.yroom.flooddatainsert.entity;

/**
 * 经纬度类，用于获取DEM淹没数据的经纬度，高程值，以及淹没层数
 */
public class Fpointsll {
    //经度
    public String longitude;
    //纬度
    public String latitude;
    public double Elevation;  //像素值(高程值)
    public boolean IsFlooded; //淹没标记
    public double FloodLevel; //淹没层级

    public Fpointsll(String longitude, String latitude, double elevation, boolean isFlooded, double floodLevel) {
        this.longitude = longitude;
        this.latitude = latitude;
        Elevation = elevation;
        IsFlooded = isFlooded;
        FloodLevel = floodLevel;
    }

    public Fpointsll() {
    }

    @Override
    public String toString() {
        return "Fpointsll{" +
                "longitude='" + longitude + '\'' +
                ", latitude='" + latitude + '\'' +
                ", Elevation=" + Elevation +
                ", IsFlooded=" + IsFlooded +
                ", FloodLevel=" + FloodLevel +
                '}';
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

    public double getFloodLevel() {
        return FloodLevel;
    }

    public void setFloodLevel(double floodLevel) {
        FloodLevel = floodLevel;
    }


}
