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
    <p>
        <button onclick="tiaozhuanyj()">定位研究区域</button>
    </p>
    <p>
        <button onclick="SetMode('drawPloy')">面积&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;测量</button>
    </p>

    <p>
        <button onclick="wuyuanzs()">无源淹没展示</button>
    </p>
    <form action="KuikouServlet1" method="post">
        <p>
            <font size="3" color="blue">溃口&nbsp;&nbsp;&nbsp;水量：</font><input type="text" name="waterq"></p>
        <p>
            <font size="3" color="blue">溃口点经度：</font><input type="text" name="klongitude"></p>
        <p>
            <font size="3" color="blue">溃口点纬度：</font><input type="text" name="klatitude"></p>
        <p>
            <input type="submit" value="溃口淹没展示">
            <input type="reset" value="重置">
        </p>
    </form>
    <p>
        <button onclick="clearDrawingBoard()">清&nbsp;&nbsp;除</button>
    </p>
    <p>
        <input id="upfile" name="upfile" type="file" multiple="multiple" />
    </p>
</div>



<div id="result"></div>




<script>
    Cesium.Ion.defaultAccessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJlMzQ4YWJlNi0xOGJmLTQ4MjItOGFjOS0xNzAyZWRjM2ExYjQiLCJpZCI6MzgwNTIsImlhdCI6MTYwNTgzOTkyOX0.5QaAqcjfTZ_mX8m726Kny-c6_1MOQpkkdexS_46yfZA'
    document.getElementById("upfile").addEventListener("change",function () {

        var file = document.getElementById('upfile').files[0];

        console.log(file);

        var reader = new FileReader();

        console.log(reader);

        reader.readAsText(file,'utf-8');

        reader.onload = function () {
            document.getElementById('result').innerHTML = reader.result;
        }
    });
    var viewer = new Cesium.Viewer("cesiumContainer", {
        selectionIndicator: false,
        fullscreenButton: true,
        animation: false, //是否显示动画控件
        baseLayerPicker: true, //是否显示图层选择控件
        geocoder: true, //是否显示地名查找控件
        timeline: false, //是否显示时间线控件
        sceneModePicker: true, //是否显示投影方式控件
        navigationHelpButton: false, //是否显示帮助信息控件
        infoBox: true, //是否显示点击要素之后显示的信息
        CreditsDisplay:false,
        creditContainer: "creditContainer",
        terrainProvider: new Cesium.CesiumTerrainProvider({
            url: "assets/cesiumlabterrain"
        }),
    });

    viewer.scene.primitives.add(Cesium.createOsmBuildings());
    var dataSource = Cesium.GeoJsonDataSource.load("assets/geojson/txdqfill.json", {
        clampToGround: true //设置贴地显示，避免图层分离
    });
    viewer.dataSources.add(dataSource);
















    var scene = viewer.scene;

    var loadedModels = [];

    var tempPoints = [];
    var tempEntities = [];
    var tempPinEntities = [];
    var tempPinLon, tempPinLat;

    var handler = null;

    function clearEffects() {
        if(handler != null) {
            handler.destroy();
        }
    }

    //设置各种操作模式
    function SetMode(mode) {
        if(mode == "drawPloy") {
            tempPoints = [];
            handler = new Cesium.ScreenSpaceEventHandler(scene.canvas);
            handler.setInputAction(function(click) {
                var cartesian = viewer.camera.pickEllipsoid(click.position, scene.globe.ellipsoid);
                if(cartesian) {
                    var cartographic = Cesium.Cartographic.fromCartesian(cartesian);
                    var longitudeString = Cesium.Math.toDegrees(cartographic.longitude);
                    var latitudeString = Cesium.Math.toDegrees(cartographic.latitude);
                    tempPoints.push({
                        lon: longitudeString,
                        lat: latitudeString
                    });
                    var tempLength = tempPoints.length;
                    drawPoint(tempPoints[tempPoints.length - 1]);
                    if(tempLength > 1) {
                        drawLine(tempPoints[tempPoints.length - 2], tempPoints[tempPoints.length - 1], true);
                    }
                }
            }, Cesium.ScreenSpaceEventType.LEFT_CLICK);

            handler.setInputAction(function(click) {
                var cartesian = viewer.camera.pickEllipsoid(click.position, scene.globe.ellipsoid);
                if(cartesian) {
                    var tempLength = tempPoints.length;
                    if(tempLength < 3) {
                        alert('请选择3个以上的点再执行闭合操作命令');
                    } else {
                        drawLine(tempPoints[0], tempPoints[tempPoints.length - 1], true);
                        drawPoly(tempPoints);
                        <!-- highLightAssetsInArea(tempPoints); -->

                        var ent =
                            viewer.entities.add({
                                position: Cesium.Cartesian3.fromDegrees(((tempPoints[0].lon + (tempPoints[tempPoints.length - 1].lon + tempPoints[tempPoints.length - 2].lon) / 2) / 2),
                                    ((tempPoints[0].lat + (tempPoints[tempPoints.length - 1].lat + tempPoints[tempPoints.length - 2].lat) / 2) / 2)),
                                label: {
                                    text: SphericalPolygonAreaMeters(tempPoints).toFixed(1) + '㎡',
                                    font: '22px Helvetica',
                                    fillColor: Cesium.Color.RED
                                }
                            });
                        tempEntities.push(ent);
                        tempPoints = [];
                        clearEffects();
                    }

                }
            }, Cesium.ScreenSpaceEventType.RIGHT_CLICK);
        } else if("drawLine" == mode) {
            tempPoints = [];
            handler = new Cesium.ScreenSpaceEventHandler(scene.canvas);
            handler.setInputAction(function(click) {
                var cartesian = viewer.camera.pickEllipsoid(click.position, scene.globe.ellipsoid);
                if(cartesian) {
                    var cartographic = Cesium.Cartographic.fromCartesian(cartesian);
                    var longitudeString = Cesium.Math.toDegrees(cartographic.longitude);
                    var latitudeString = Cesium.Math.toDegrees(cartographic.latitude);
                    tempPoints.push({
                        lon: longitudeString,
                        lat: latitudeString
                    });
                    var tempLength = tempPoints.length;
                    drawPoint(tempPoints[tempPoints.length - 1]);
                    if(tempLength > 1) {
                        drawLine(tempPoints[tempPoints.length - 2], tempPoints[tempPoints.length - 1], true);
                    }
                }
            }, Cesium.ScreenSpaceEventType.LEFT_CLICK);
            handler.setInputAction(function(click) {
                tempPoints = [];
                clearEffects();
            }, Cesium.ScreenSpaceEventType.RIGHT_CLICK);
        }
    }

    function drawPoint(point) {
        var entity =
            viewer.entities.add({
                position: Cesium.Cartesian3.fromDegrees(point.lon, point.lat),
                label: {
                    text: '',
                    font: '22px Helvetica'
                },
                point: {
                    pixelSize: 10,
                    color: Cesium.Color.ORANGE
                }
            });
        tempEntities.push(entity);
    }

    function drawLine(point1, point2, showDistance) {
        var entity =
            viewer.entities.add({
                polyline: {
                    positions: [Cesium.Cartesian3.fromDegrees(point1.lon, point1.lat), Cesium.Cartesian3.fromDegrees(point2.lon, point2.lat)],
                    width: 10.0,
                    material: new Cesium.PolylineGlowMaterialProperty({
                        color: Cesium.Color.WHITE.withAlpha(.5)
                    })
                }
            });
        tempEntities.push(entity);
        if(showDistance) {
            var w = Math.abs(point1.lon - point2.lon);
            var h = Math.abs(point1.lat - point2.lat);
            var offsetV = w >= h ? 0.0005 : 0;
            var offsetH = w < h ? 0.001 : 0;
            var distance = getFlatternDistance(point1.lat, point1.lon, point2.lat, point2.lon);
            entity =
                viewer.entities.add({
                    position: Cesium.Cartesian3.fromDegrees(((point1.lon + point2.lon) / 2) + offsetH,
                        ((point1.lat + point2.lat) / 2) + offsetV),
                    label: {
                        text: distance.toFixed(1) + 'm',
                        font: '22px Helvetica',
                        fillColor: Cesium.Color.RED
                    }
                });
            tempEntities.push(entity);
        }
    }

    function drawPoly(points) {
        var pArray = [];
        for(var i = 0; i < points.length; i++) {
            pArray.push(points[i].lon);
            pArray.push(points[i].lat);
        }
        var entity =
            viewer.entities.add({
                polygon: {
                    hierarchy: new Cesium.PolygonHierarchy(Cesium.Cartesian3.fromDegreesArray(pArray)),
                    material: Cesium.Color.PINK.withAlpha(.5)
                }
            });
        tempEntities.push(entity);
    }

    //计算两点间距离
    function getFlatternDistance(lat1, lng1, lat2, lng2) {
        var EARTH_RADIUS = 6378137.0; //单位M
        var PI = Math.PI;

        function getRad(d) {
            return d * PI / 180.0;
        }
        var f = getRad((lat1 + lat2) / 2);
        var g = getRad((lat1 - lat2) / 2);
        var l = getRad((lng1 - lng2) / 2);

        var sg = Math.sin(g);
        var sl = Math.sin(l);
        var sf = Math.sin(f);

        var s, c, w, r, d, h1, h2;
        var a = EARTH_RADIUS;
        var fl = 1 / 298.257;

        sg = sg * sg;
        sl = sl * sl;
        sf = sf * sf;

        s = sg * (1 - sl) + (1 - sf) * sl;
        c = (1 - sg) * (1 - sl) + sf * sl;

        w = Math.atan(Math.sqrt(s / c));
        r = Math.sqrt(s * c) / w;
        d = 2 * w * a;
        h1 = (3 * r - 1) / 2 / c;
        h2 = (3 * r + 1) / 2 / s;

        return d * (1 + fl * (h1 * sf * (1 - sg) - h2 * (1 - sf) * sg));
    }

    //计算多边形面积
    var earthRadiusMeters = 6371000.0;
    var radiansPerDegree = Math.PI / 180.0;
    var degreesPerRadian = 180.0 / Math.PI;

    function SphericalPolygonAreaMeters(points) {
        var totalAngle = 0;
        for(var i = 0; i < points.length; i++) {
            var j = (i + 1) % points.length;
            var k = (i + 2) % points.length;
            totalAngle += Angle(points[i], points[j], points[k]);
        }
        var planarTotalAngle = (points.length - 2) * 180.0;
        var sphericalExcess = totalAngle - planarTotalAngle;
        if(sphericalExcess > 420.0) {
            totalAngle = points.length * 360.0 - totalAngle;
            sphericalExcess = totalAngle - planarTotalAngle;
        } else if(sphericalExcess > 300.0 && sphericalExcess < 420.0) {
            sphericalExcess = Math.abs(360.0 - sphericalExcess);
        }
        return sphericalExcess * radiansPerDegree * earthRadiusMeters * earthRadiusMeters;
    }

    /*角度*/
    function Angle(p1, p2, p3) {
        var bearing21 = Bearing(p2, p1);
        var bearing23 = Bearing(p2, p3);
        var angle = bearing21 - bearing23;
        if(angle < 0) {
            angle += 360;
        }
        return angle;
    }
    /*方向*/
    function Bearing(from, to) {
        var lat1 = from.lat * radiansPerDegree;
        var lon1 = from.lon * radiansPerDegree;
        var lat2 = to.lat * radiansPerDegree;
        var lon2 = to.lon * radiansPerDegree;
        var angle = -Math.atan2(Math.sin(lon1 - lon2) * Math.cos(lat2), Math.cos(lat1) * Math.sin(lat2) - Math.sin(lat1) * Math.cos(lat2) * Math.cos(lon1 - lon2));
        if(angle < 0) {
            angle += Math.PI * 2.0;
        }
        angle = angle * degreesPerRadian;
        return angle;
    }
    /**
     * 清除地图痕迹
     */
    function clearDrawingBoard() {
        <!-- viewer.entities.removeAll(); -->
        var primitives = viewer.entities;
        for(i = 0; i < tempEntities.length; i++) {
            primitives.remove(tempEntities[i]);
        }
        tempEntities = [];
        clearEffects();
    }
    function wuyuanzs() {
        window.location.href="wuyuanzs.jsp";
    }

    function tiaozhuanyj() {
        viewer.camera.flyTo({
            destination : Cesium.Cartesian3.fromDegrees( 118.313043, 29.698819, 15000.0)

        });
    }
</script>
</body>

</html>