package com.yroom.flooddatainsert.entity;
//json数据与数据库对应的实体
public class FloodPoint {
    //点id
    public String pointid;
    //淹没包含的高程
    public String  grid;
    //经度
    public String longitude;
    //纬度
    public String latitude;
    //数据类型
    public String ptype;

    public FloodPoint() {
    }

    public FloodPoint(String pointid, String grid, String longitude, String latitude, String ptype) {
        this.pointid = pointid;
        this.grid = grid;
        this.longitude = longitude;
        this.latitude = latitude;
        this.ptype = ptype;
    }

    public String getPointid() {
        return pointid;
    }

    public String getGrid() {
        return grid;
    }

    public String getLongitude() {
        return longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public String getPtype() {
        return ptype;
    }

    public void setPointid(String pointid) {
        this.pointid = pointid;
    }

    public void setGrid(String grid) {
        this.grid = grid;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public void setPtype(String ptype) {
        this.ptype = ptype;
    }

    @Override
    public String toString() {
        return "JsonClass{" +
                "pointid=" + pointid +
                ", grid=" + grid +
                ", longitude='" + longitude + '\'' +
                ", latitude='" + latitude + '\'' +
                ", ptype='" + ptype + '\'' +
                '}';
    }
}
