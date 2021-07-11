package com.yroom.flooddatainsert.dao;

import com.yroom.flooddatainsert.baseDao.BaseDao;
import com.yroom.flooddatainsert.entity.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FdDao extends BaseDao {
    //数据库增加操作
    public boolean add(FloodPoint floodpoint) {
        String sql = "insert into jsonw(pointid,grid,longitude,latitude,ptype) VALUES(?,?,?,?,?) ";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, floodpoint.getPointid());
            preparedStatement.setString(2, floodpoint.getGrid());
            preparedStatement.setString(3, floodpoint.getLongitude());
            preparedStatement.setString(4, floodpoint.getLatitude());
            preparedStatement.setString(5, floodpoint.getPtype());
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }


    public boolean adduserdef(Userdef usdf) {
        String sql = "insert into userdef(id,waterq,klongitude,klatitude) VALUES(null,?,?,?) ";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setDouble(1, usdf.getWaterq());
            preparedStatement.setDouble(2, usdf.getKlongitude());
            preparedStatement.setDouble(3, usdf.getKlatitude());
     ;
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }

    public boolean addshuishen(Shuishen shuishen) {
        String sql = "insert into shuishen(grid,longitude,latitude) VALUES(?,?,?) ";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, shuishen.getGrid());
            preparedStatement.setString(2, shuishen.getLongitude());
            preparedStatement.setString(3, shuishen.getLatitude());
            ;
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }

    public boolean addwork(Work work) {
        String sql = "insert into workforys(Waterreal,times,qulity,youyuan,countyouyuan) VALUES(?,?,?,?,?) ";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setDouble(1, work.getWaterreal());
            preparedStatement.setLong(2, work.getTimes());
            preparedStatement.setDouble(3, work.getQulity());
            preparedStatement.setDouble(4, work.getYouyuan());
            preparedStatement.setDouble(5, work.getCountyouyuan());
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }
    public ResultSet query() {
       // List<ResultSet> rss=new ArrayList<>();
        ResultSet rs=null;
       // for(int i=0;i<1000;i=i+100){
        //获取sql数据
            String sql="select * from jsonw limit 100";
            try{
                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                rs = preparedStatement.executeQuery();
            } catch (SQLException e) {
                e.printStackTrace();
            }
         //   rss.add(rs);
      //  }
        //返回存放rs的数组
        return rs;
    }
    public ResultSet querytry() {
        // List<ResultSet> rss=new ArrayList<>();
        ResultSet rs=null;
        // for(int i=0;i<1000;i=i+100){
        //获取sql数据
        String sql="select * from tryxian";
        try{
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            rs = preparedStatement.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        //   rss.add(rs);
        //  }
        //返回存放rs的数组
        return rs;
    }

    public ResultSet queryjson() {
        // List<ResultSet> rss=new ArrayList<>();
        ResultSet rs=null;

        String sql="select * from fljsons";
        try{
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            rs = preparedStatement.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        //   rss.add(rs);
        //  }
        //返回存放rs的数组
        return rs;
    }


    public boolean addjw(Tryjw tryjw) {
        String sql = "insert into tryxian(j,w) VALUES(?,?) ";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, tryjw.getLongitude());
            preparedStatement.setString(2, tryjw.getLatitude());

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }
    public boolean addFpointsll(Fpointsll floodpoint) {
      /*  //经度
        public String longitude;
        //纬度
        public String latitude;
        public double Elevation;  //像素值(高程值)
        public boolean IsFlooded; //淹没标记
        public double FloodLevel; //淹没层级*/
        String sql = "insert into fpointsll(longitude,latitude,Elevation,IsFlooded,FloodLevel) VALUES(?,?,?,?,?) ";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, floodpoint.getLongitude());
            preparedStatement.setString(2, floodpoint.getLatitude());
            preparedStatement.setDouble(3, floodpoint.getElevation());
            preparedStatement.setBoolean(4, floodpoint.isFlooded());
            preparedStatement.setDouble(5, floodpoint.getFloodLevel());
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }
    public boolean addwv(Wv wv) {
        String sql = "insert into wv(waterl,Qutiy) VALUES(?,?) ";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setDouble(1, wv.getWaterl());
            preparedStatement.setDouble(2, wv.getQutiy());
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }
}
