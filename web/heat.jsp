<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: YROOM
  Date: 2021/3/29
  Time: 14:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Flood inundation simulation 1207test with3D</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
    <script src="assets/cesiumbul/Cesium.js"></script>
    <script src="assets/js/copyCesiumHeatmap.js"></script>
    <script type="text/javascript" src="assets/cesiumbul/Apps/Sandcastle/Sandcastle-header.js"></script>
    <title>水深图</title>
</head>
<style>
    @import url("assets/cesiumbul/Apps/Sandcastle/templates/bucket.css");
    html,
    body,
      html,
           body,
            #cesiumContainer {
        width: 100%;
        height: 100%;
        margin: 0;
        padding: 0;
        overflow: hidden;
    }

    #menu {
        position: absolute;
        top: 80px;
        left: 10px;
        z-index: 999;
    }
</style>
<body>
<div id="cesiumContainer" ></div>
<script>
    var viewer = new Cesium.Viewer("cesiumContainer");
    // 视图区域

    // 矩形坐标
    var bounds = {
        west: 118.25, south:29.66, east:118.36, north: 29.77
    };

    // 初始化CesiumHeatmap
    var heatMap = CesiumHeatmap.create(
        viewer, // 视图层
        bounds, // 矩形坐标
        { // heatmap相应参数
            backgroundColor: "rgba(0,0,0,0)",
            radius: 5,
            maxOpacity: .5,
            minOpacity: 0,
            blur: .75
        }
    );
    var data = [];

    <c:forEach items="${fldpoints }" var="FloodPoint"  >
    var x = ${FloodPoint.longitude};
    var y = ${FloodPoint.latitude};
    var value =${FloodPoint.grid};
    data.push({x: x, y: y, value: value});
    </c:forEach>

    // 添加数据 最小值，最大值，数据集
    heatMap.setWGS84Data(0, 100, data);

    viewer.zoomTo(viewer.entities);
    // 动态数据 [{x: -97.6433525165054, y: 45.61443064377248, value: 11.409122369106317}]






</script>

    </body>
</html>