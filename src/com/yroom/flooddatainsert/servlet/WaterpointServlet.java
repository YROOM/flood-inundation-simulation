package com.yroom.flooddatainsert.servlet;

import com.yroom.flooddatainsert.dao.FdDao;
import com.yroom.flooddatainsert.entity.FloodPoint;
import com.yroom.flooddatainsert.entity.Tryjw;


import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "WaterpointServlet")
public class WaterpointServlet extends HttpServlet {
    //从数据库中获得淹没的洪水点
  /*  public List<FloodPoint> getFPFromMysql() throws SQLException {
        //创建链表存放洪水淹没点
        List<FloodPoint> fdpoints = new ArrayList<>();
        //从mysql数据库中获取数据
        FdDao fddao = new FdDao();
        ResultSet rs = null;
        rs = fddao.query();
        int count = 0;
        while (rs.next()) {
            // System.out.println(count++);
            //声明实体
            FloodPoint fldpoint = new FloodPoint();
            //设置实体的属性
            fldpoint.setGrid(rs.getString("grid"));
            fldpoint.setPointid(rs.getString("pointid"));
            fldpoint.setLatitude(rs.getString("latitude"));
            fldpoint.setLongitude(rs.getString("longitude"));
            fldpoint.setPtype(rs.getString("ptype"));
            //存入list
            fdpoints.add(fldpoint);
        }

        //返回list
        return fdpoints;
    }


    public List<Tryjw> getjw() throws SQLException {
        //创建链表存放洪水淹没点
        List<Tryjw> fdpoints = new ArrayList<>();
        //从mysql数据库中获取数据
        FdDao fddao = new FdDao();
        ResultSet rs = null;
        rs = fddao.querytry();
        int count = 0;
        while (rs.next()) {
            // System.out.println(count++);
            //声明实体
            Tryjw tryjw=new Tryjw();
            tryjw.setLatitude(rs.getString("w"));
            tryjw.setLongitude(rs.getString("j"));

            //存入list
            fdpoints.add(tryjw);
        }
        //返回list
        return fdpoints;

    }
    public int count;

    public void init() {
        // 重置计数器
        count = -10;
    }
    List<Tryjw> show = new ArrayList<>();
*/
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("servlet进来了");
        //将淹没的洪水点组成的数组存放到
        req.setCharacterEncoding("utf-8");
       // count=count+10;
        WaterpointServlet ws = new WaterpointServlet();
       /* List<FloodPoint> fullpoints = null;
        List<Tryjw> tryjw=null;
        //获得了前台所有的对象数据
        try {
          fullpoints = ws.getFPFromMysql();
            tryjw=ws.getjw();
            *//*if (count+10<tryjw.size()){
                for (int i = count; i < count+10; i++) {
                    show.add(tryjw.get(i));
                }
            }*//*
        } catch (SQLException ex) {
            ex.printStackTrace();
        }*/
      //  req.setAttribute("show", show);
   //     req.setAttribute("fldpoints", tryjw);
       req.getRequestDispatcher("/bianjie.jsp").forward(req, resp);
      //  req.getRequestDispatcher("/waterdemo1210.jsp").forward(req, resp);

      //  System.out.println(req.getAttribute("show"));
     //   System.out.println(req.getAttribute("fldpoints"));
       // System.out.println(tryjw.size());
         /*   int count = 0;
            //当fdpoints链表中还存在数据
            while (count < fullpoints.size()) {
                //从count开始，注入num个对象bean
                List<FloodPoint> partpoints = new ArrayList<>();
                for (int i = count; i < count + 10; i++) {
                    if (i>fullpoints.size()-1){
                        break;
                    }else{
                        partpoints.add(fullpoints.get(i));
                        count++;
                    }
                }*/
        //传送到前台显示

    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
