<%--
  Created by IntelliJ IDEA.
  User: YROOM
  Date: 2020/12/10
  Time: 17:14
  To change this template use File | Settings | File Templates.
--%>
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
    </style>
</head>
<body>
<div id="cesiumContainer" class="fullSize"></div>
<div id="loadingOverlay">
    <h1>Loading...</h1>
</div>
<div id="toolbar"></div>

</body>
<script>
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

    viewer.scene.globe.depthTestAgainstTerrain = true;
    var myVar;

    Sandcastle.addDefaultToolbarButton("有源淹没",
        function () {
            <c:forEach items="${fldpoints }" var="FloodPoint" >
            var waterPrimitive = new Cesium.GroundPrimitive({
                show: true, // 默认隐藏
                allowPicking: false,
                geometryInstances: new Cesium.GeometryInstance({
                    geometry: new Cesium.RectangleGeometry({
                        rectangle: Cesium.Rectangle.fromDegrees(${FloodPoint.longitude}-0.000138888888889,
                            ${FloodPoint.latitude}-0.000138888888889, ${FloodPoint.longitude}+0.000138888888889,
                            ${FloodPoint.latitude}+0.000138888888889),
                        height:2,
                      //  extrudedHeight:2,
                        vertexFormat: Cesium.EllipsoidSurfaceAppearance.VERTEX_FORMAT,
                    }),
                }),
                // 可以设置内置的水面shader
                appearance: new Cesium.EllipsoidSurfaceAppearance({
                    material: new Cesium.Material({
                        fabric: {
                            type: 'Water',
                            uniforms: {
                                normalMap: 'assets/img/waterNormals.jpg',
                                frequency: 100.0,
                                animationSpeed: 0.1,
                                amplitude: 10.0
                            }
                        }
                    }),
                })
            });
            viewer.scene.primitives.add(waterPrimitive);
            </c:forEach>
        }
    );





    //显示图标11个水位站点
    var pinBuilder = new Cesium.PinBuilder();

    var mxPin = viewer.entities.add({
        name: "黟县",
        position: Cesium.Cartesian3.fromDegrees(117.961563, 29.92579),
        billboard: {
            image: pinBuilder.fromText("黟县", Cesium.Color.ROYALBLUE, 48).toDataURL(),
            verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
        },
    });
    var rcPin = viewer.entities.add({
        name: "儒村",
        position: Cesium.Cartesian3.fromDegrees(118.091714, 29.966923),
        billboard: {
            image: pinBuilder.fromText("儒村", Cesium.Color.ROYALBLUE, 48).toDataURL(),
            verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
        },
    });
    var yqPin = viewer.entities.add({
        name: "岩前",
        position: Cesium.Cartesian3.fromDegrees(118.056214, 29.823565),
        billboard: {
            image: pinBuilder.fromText("岩前", Cesium.Color.ROYALBLUE, 48).toDataURL(),
            verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
        },
    });
    var xnPin = viewer.entities.add({
        name: "休宁",
        position: Cesium.Cartesian3.fromDegrees(118.204276, 29.794456),
        billboard: {
            image: pinBuilder.fromText("休宁", Cesium.Color.ROYALBLUE, 48).toDataURL(),
            verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
        },
    });
    var ccPin = viewer.entities.add({
        name: "呈村",
        position: Cesium.Cartesian3.fromDegrees(117.809915, 29.715327),
        billboard: {
            image: pinBuilder.fromText("呈村", Cesium.Color.ROYALBLUE, 48).toDataURL(),
            verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
        },
    });
    var txPin = viewer.entities.add({
        name: "屯溪",
        position: Cesium.Cartesian3.fromDegrees(118.313043, 29.698819),
        billboard: {
            image: pinBuilder.fromText("屯溪", Cesium.Color.ROYALBLUE, 48).toDataURL(),
            verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
        },
    });
    var smPin = viewer.entities.add({
        name: "石门",
        position: Cesium.Cartesian3.fromDegrees(118.145478, 29.584716),
        billboard: {
            image: pinBuilder.fromText("石门", Cesium.Color.ROYALBLUE, 48).toDataURL(),
            verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
        },
    });
    var sxkPin = viewer.entities.add({
        name: "上溪口",
        position: Cesium.Cartesian3.fromDegrees(118.018801, 29.692538),
        billboard: {
            image: pinBuilder.fromText("上溪口", Cesium.Color.ROYALBLUE, 48).toDataURL(),
            verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
        },
    });
    var wcPin = viewer.entities.add({
        name: "五城",
        position: Cesium.Cartesian3.fromDegrees(118.188223, 29.604602),
        billboard: {
            image: pinBuilder.fromText("五城", Cesium.Color.ROYALBLUE, 48).toDataURL(),
            verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
        },
    });
    var dlPin = viewer.entities.add({
        name: "大连",
        position: Cesium.Cartesian3.fromDegrees(117.895092, 29.580809),
        billboard: {
            image: pinBuilder.fromText("大连", Cesium.Color.ROYALBLUE, 48).toDataURL(),
            verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
        },
    });
    var zlPin = viewer.entities.add({
        name: "左龙",
        position: Cesium.Cartesian3.fromDegrees(117.723304, 29.601894),
        billboard: {
            image: pinBuilder.fromText("左龙", Cesium.Color.ROYALBLUE, 48).toDataURL(),
            verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
        },
    });
    //展示11个水文点
    var bluePin = viewer.entities.add({
        name: "Blank blue pin",
        position: Cesium.Cartesian3.fromDegrees(117.93331944110889, 29.93471013128955),
        billboard: {
            image: pinBuilder.fromColor(Cesium.Color.ROYALBLUE, 48).toDataURL(),
            verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
        },
    });
    Cesium.when.all(
        [bluePin, mxPin, rcPin, yqPin, xnPin, ccPin, sxkPin, wcPin, smPin, txPin, zlPin, dlPin],
        function (pins) {
            viewer.zoomTo(pins);
        }
    );
</script>
</html>
