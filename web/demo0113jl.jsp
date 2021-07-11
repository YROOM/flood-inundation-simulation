
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Flood inundation simulation 1207test with3D</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
    <script src="assets/cesiumbul/Cesium.js"></script>
    <script type="text/javascript" src="assets/cesiumbul/Apps/Sandcastle/Sandcastle-header.js"></script>
    <style>
        @import url("assets/cesiumbul/Apps/Sandcastle/templates/bucket.css");
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
</head>
<body>
<div id="cesiumContainer"></div>
<div id="creditContainer" style="display: none;"></div>
<div id="menu">

    <form action="KuikouServlet" method="post">

        <p>
            <input type="submit" value="淹没展示">

        </p>
    </form>

</div>
</body>
<script>
    Cesium.Ion.defaultAccessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJlMzQ4YWJlNi0xOGJmLTQ4MjItOGFjOS0xNzAyZWRjM2ExYjQiLCJpZCI6MzgwNTIsImlhdCI6MTYwNTgzOTkyOX0.5QaAqcjfTZ_mX8m726Kny-c6_1MOQpkkdexS_46yfZA'
    // var viewer = new Cesium.Viewer("cesiumContainer", {
    //     terrainProvider: Cesium.createWorldTerrain(),
    // });


    var viewer = new Cesium.Viewer("cesiumContainer", {
        terrainProvider: new Cesium.CesiumTerrainProvider({
            url: "assets/cesiumlabterrain"
        })
    });
    //加入OSMBuilding层显示建筑物
    viewer.scene.primitives.add(Cesium.createOsmBuildings());
    //加载屯溪范围文件
    var dataSource = Cesium.GeoJsonDataSource.load("assets/geojson/txdqfill.json", {
        clampToGround: true //设置贴地显示，避免图层分离
    });

    var pinBuilder = new Cesium.PinBuilder();

    var mxPin = viewer.entities.add({
        name: "溃口点",
        position: Cesium.Cartesian3.fromDegrees(${sessionScope.weidu.getKlongitude()},${sessionScope.weidu.getKlatitude()}),
        billboard: {
            image: pinBuilder.fromText("溃口", Cesium.Color.ROYALBLUE, 48).toDataURL(),
            // verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
        },
    });



    viewer.dataSources.add(dataSource);
    var startTime = new Date().getTime();
    var pointPrimitives = null;// 申明点渲染集合
    pointPrimitives = this.viewer.scene.primitives.add(new Cesium.PointPrimitiveCollection());
    <c:forEach items="${fldpoints }" var="FloodPoint"  >

    var position = Cesium.Cartesian3.fromDegrees( ${FloodPoint.longitude}, ${FloodPoint.latitude},${sessionScope.weidu.getWaterq()});

    pointPrimitives.add({
        pixelSize: 5,
        color: Cesium.Color['BLUE'].withAlpha(),
        outlineColor: false,
        outlineWidth: 0,
        position: position
    });
    </c:forEach>
    var endTime = new Date().getTime();
    console.log(startTime);
    console.log(endTime);
    console.log(endTime-startTime);
    //   viewer.dataSources.add(dataSource);
  </script>
</html>
