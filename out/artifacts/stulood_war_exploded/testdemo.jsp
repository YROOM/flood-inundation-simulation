<%@ page import="com.yroom.flooddatainsert.entity.Tryjw" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: YROOM
  Date: 2020/12/11
  Time: 14:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
hhh

<%
    //获取后台数据
    List<Tryjw> ans= (List<Tryjw>) request.getAttribute("fldpoints");
    int len=ans.size();
    List<Tryjw> show=new ArrayList<>();
    int count=0;
    while (count+10<len){
        for (int i = count; i <count+10 ; i++) {
            show.add(ans.get(i));
        }
        count=count+10;
        request.setAttribute("show",show);
%>

<%

    }
%>

    <c:forEach items="${show}" var="FloodPoint">
    ${FloodPoint.longitude},
    ${FloodPoint.latitude},
    10,
    </c:forEach>





</body>

</html>
