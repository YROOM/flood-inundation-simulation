
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
        terrainProvider: new Cesium.CesiumTerrainProvider({
            url: "assets/cesiumlabterrain"
        })
    });
    //加入OSMBuilding层显示建筑物
    viewer.scene.primitives.add(Cesium.createOsmBuildings());
    //加载屯溪范围文件
    var dataSource = Cesium.GeoJsonDataSource.load("assets/geojson/tx.json", {
        clampToGround: true //设置贴地显示，避免图层分离
    });

    const extrudedPolygon = new Cesium.PolygonGeometry({
        polygonHierarchy: new Cesium.PolygonHierarchy(
            Cesium.Cartesian3.fromDegreesArray([
                <c:forEach items="${fldpoints}" var="FloodPoint" begin="0" end="10000">
                ${FloodPoint.longitude},${FloodPoint.latitude},
                </c:forEach>
            ])
        ),
        extrudedHeight: 150,
    })

    const extrudedPolygon2 = new Cesium.PolygonGeometry({
        polygonHierarchy: new Cesium.PolygonHierarchy(
            Cesium.Cartesian3.fromDegreesArray([
                <c:forEach items="${fldpoints}" var="FloodPoint" begin="10001" end="20000">
                ${FloodPoint.longitude},${FloodPoint.latitude},
                </c:forEach>

            ])
        ),
        extrudedHeight: 150,
    })
    const extrudedPolygon3 = new Cesium.PolygonGeometry({
        polygonHierarchy: new Cesium.PolygonHierarchy(
            Cesium.Cartesian3.fromDegreesArray([
                <c:forEach items="${fldpoints}" var="FloodPoint" begin="20001" end="30000">
                ${FloodPoint.longitude},${FloodPoint.latitude},
                </c:forEach>

            ])
        ),
        extrudedHeight: 150,
    })

    const instance3 = new Cesium.GeometryInstance({
        geometry: extrudedPolygon3,
        id: 'box with height',
    })
    const instance = new Cesium.GeometryInstance({
        geometry: extrudedPolygon,
        id: 'box with height',
    })
    const instance2 = new Cesium.GeometryInstance({
        geometry: extrudedPolygon2,
        id: 'box with height',
    })
   /* const extrudedPolygon2 = new Cesium.PolygonGeometry({
        polygonHierarchy: new Cesium.PolygonHierarchy(
            Cesium.Cartesian3.fromDegreesArray([

            ])
        ),
        extrudedHeight: 150,
    })
    const instance2 = new Cesium.GeometryInstance({
        geometry: extrudedPolygon2,
        id: 'box with height',
    })*/
    // 创建材质，在MaterialAppearance中若不添加基础材质，模型将会透明
    var material=new Cesium.Material({
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

    // 自定义材质
    const aper = new Cesium.EllipsoidSurfaceAppearance({
        material: material,
    })
    // 加载模型
    var p = viewer.scene.primitives.add(
        new Cesium.Primitive({
            geometryInstances: [instance],
          //  geometryInstances: instance,
            appearance: aper,
            releaseGeometryInstances: false,
            compressVertices: false,
        })
    )

</script>
</html>
