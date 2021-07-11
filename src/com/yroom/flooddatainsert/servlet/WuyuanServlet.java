package com.yroom.flooddatainsert.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "Servlet1")
public class WuyuanServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       // req.setAttribute("fldpoints", tryjw);
      //  req.getRequestDispatcher("/tryw.jsp").forward(req, resp);
        double wuyuanml=Double.valueOf(req.getParameter("wuml"));
        req.getSession().setAttribute("wuml",wuyuanml);
        req.getRequestDispatcher("/wuyuanzs.jsp").forward(req, resp);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
