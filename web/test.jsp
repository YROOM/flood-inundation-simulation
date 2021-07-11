<%--
  Created by IntelliJ IDEA.
  User: YROOM
  Date: 2020/12/8
  Time: 20:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>

<%--<%
    String basePath = request.getScheme()+":"+"//"+request.getServerName()+":"+request.getServerPort()+"/"
            +request.getServletContext().getContextPath()+"/";
%>--%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<center>
   <form action="HheatServlet" method="post">
        <p>用户名：<input type="text" name="username"></p>
        <p>密&nbsp;码：<input type="password" name="password"></p>
        <p>
            <input type="submit" value="登录">
            <input type="reset" value="重置">
        </p>
    </form>
</center>
</body>
</html>
