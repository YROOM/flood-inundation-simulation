
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

    <form action="WuyuanServlet" method="post">

        <font size="3" color="blue">无源淹没水位：</font><input type="text" name="wuml"></p>
        <p>
            <input type="submit" value="无源展示">
            <input type="reset" value="重置">
        </p>
    </form>

</div>

</body>
<script>

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


    var waterPrimitive0 = new Cesium.Primitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.RectangleGeometry({
                rectangle: Cesium.Rectangle.fromDegrees(118.25,
                    29.66, 118.36,
                    29.77),
                //height: 150,
                extrudedHeight: ${sessionScope.wuml},//注释掉此属性可以只显示水面
                //perPositionHeight : true//注释掉此属性水面就贴地了
            })
        }),
        // 可以设置内置的水面shader
        appearance: new Cesium.EllipsoidSurfaceAppearance({
            material: new Cesium.Material({
                fabric: {
                    type: 'Water',
                    uniforms: {
                        normalMap: 'assets/img/waterNormals.jpg',
                        //频率
                        frequency: 100.0,
                        animationSpeed: 0.1,
                        amplitude: 10.0
                    }
                }
            }),
        })
    });
    viewer.scene.primitives.add(waterPrimitive0);


    //   viewer.dataSources.add(dataSource);


</script>
</html>
