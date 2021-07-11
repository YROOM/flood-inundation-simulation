
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
    Cesium.Ion.defaultAccessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJlMzQ4YWJlNi0xOGJmLTQ4MjItOGFjOS0xNzAyZWRjM2ExYjQiLCJpZCI6MzgwNTIsImlhdCI6MTYwNTgzOTkyOX0.5QaAqcjfTZ_mX8m726Kny-c6_1MOQpkkdexS_46yfZA'
    //加入OSMBuilding层显示建筑物


    var viewer = new Cesium.Viewer("cesiumContainer", {
        terrainProvider: new Cesium.CesiumTerrainProvider({
            url: "assets/cesiumlabterrain"
        })
    });
    viewer.scene.primitives.add(Cesium.createOsmBuildings());
    //加入OSMBuilding层显示建筑物
  //  viewer.scene.primitives.add(Cesium.createOsmBuildings());
    //加载屯溪范围文件
    var promise  = Cesium.GeoJsonDataSource.load("assets/geojson/Plus_tif1top.json");
    promise.then(function(dataSource) {
        viewer.dataSources.add(dataSource);
        var entities = dataSource.entities.values;
        var colorHash = {};
        var material = new Cesium.Material({
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
        });

        for(var i = 0; i < entities.length; i++) {
            var entity = entities[i];
            var name = entity.name;
            var color = colorHash[name];
            if(!color) {
                color = Cesium.Color.fromRandom({
                    alpha: 1.0
                });
                colorHash[name] = color;
            }
            entity.polygon.material = 'assets/img/waterNormals.jpg';
            entity.polygon.outline = false;
            entity.polygon.extrudedHeight = 165.0;
        }
    });
    viewer.flyTo(promise);
</script>
</html>
