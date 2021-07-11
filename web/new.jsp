<%--
  Created by IntelliJ IDEA.
  User: YROOM
  Date: 2021/1/4
  Time: 11:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Flood inundation simulation 1207test with3D</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
    <script src="assets/cesiumbul/Cesium.js"></script>
    <script type="text/javascript" src="assets/cesiumbul/Apps/Sandcastle/Sandcastle-header.js"></script>
    <style>
        @import url("assets/cesiumbul/Apps/Sandcastle/templates/bucket.css");
    </style>
</head>
<body>
<div id="cesiumContainer" class="fullSize"></div>
<div id="loadingOverlay"><h1>Loading...</h1>
</div>
<div id="toolbar"></div>
</body>
<script type="text/javascript">
    //创建底层图
    var viewer = new Cesium.Viewer("cesiumContainer", {
        
        terrainProvider: Cesium.createWorldTerrain(),
    });

    //加入OSMBuilding层显示建筑物
    viewer.scene.primitives.add(Cesium.createOsmBuildings());
    //加载屯溪范围文件
    var dataSource = Cesium.GeoJsonDataSource.load("assets/geojson/tx.json", {
        clampToGround: true //设置贴地显示，避免图层分离
    });
    viewer.dataSources.add(dataSource);

    viewer.cesiumWidget.screenSpaceEventHandler.removeInputAction(
        Cesium.ScreenSpaceEventType.LEFT_DOUBLE_CLICK
    );
    /*//向屯溪流域
    viewer.scene.camera.flyTo({
            destination: Cesium.Cartesian3.fromDegrees(118.306, 29.699, 750),
            orientation: {
                heading: Cesium.Math.toRadians(20),
                pitch: Cesium.Math.toRadians(-20),
            },
        }

    );*/

    //显示图标11个水位站点
    var pinBuilder = new Cesium.PinBuilder();
    var txPin = viewer.entities.add({
        name: "屯溪",
        position: Cesium.Cartesian3.fromDegrees(118.313043, 29.698819),
        billboard: {
            image: pinBuilder.fromText("屯溪", Cesium.Color.ROYALBLUE, 48).toDataURL(),
            verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
        },
    });

    Cesium.when.all(
        [ txPin],
        function (pins) {
            viewer.zoomTo(pins);
        }
    );
</script>
</html>

