package com.yroom.flooddatainsert.entity;

/**
 * 高程索引类
 */
public class ElevationIdx  {

    public int Idx;//初步确定：像素栅格的编号，索引
    public double Elevation; //地形的高程值
    public int Direct;//0代表自己,1代表大于中心点，-1代表小于中心点
    public double WaterHeight;//水的高度


    public ElevationIdx() {
    }

    public ElevationIdx(int idx, double elevation, int direct, double waterHeight) {
        Idx = idx;
        Elevation = elevation;
        Direct = direct;
        WaterHeight = waterHeight;
    }

    public int getIdx() {
        return Idx;
    }

    public void setIdx(int idx) {
        Idx = idx;
    }

    public double getElevation() {
        return Elevation;
    }

    public void setElevation(double elevation) {
        Elevation = elevation;
    }

    public int getDirect() {
        return Direct;
    }

    public void setDirect(int direct) {
        Direct = direct;
    }

    public double getWaterHeight() {
        return WaterHeight;
    }

    public void setWaterHeight(double waterHeight) {
        WaterHeight = waterHeight;
    }

    @Override
    public String toString() {
        return "ElevationIdx{" +
                "Idx=" + Idx +
                ", Elevation=" + Elevation +
                ", Direct=" + Direct +
                ", WaterHeight=" + WaterHeight +
                '}';
    }

    public double WaterElevation(double elevation,double waterHeight){
        //获取当前水深+高程也就是获得当前水位
        return elevation+waterHeight;
    }


}
