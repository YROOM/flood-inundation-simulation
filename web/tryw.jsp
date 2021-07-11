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
    //设置地形3D效果
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

    //将数据渲染到前台
    var waterPrimitive0 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="0" end="4000">
                            ${FloodPoint.longitude},
                            ${FloodPoint.latitude},
                            10,
                            </c:forEach>
                        ]
                    )),
                height: 200,
                //extrudedHeight: 200,//注释掉此属性可以只显示水面
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
    var waterPrimitive1 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="4001" end="8000">
                            ${FloodPoint.longitude},
                            ${FloodPoint.latitude},
                            10,
                            </c:forEach>
                        ]
                    )),
                height: 200,
                //extrudedHeight: 200,//注释掉此属性可以只显示水面
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
    var waterPrimitive2 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="8001" end="12000">
                            ${FloodPoint.longitude},
                            ${FloodPoint.latitude},
                            10,
                            </c:forEach>
                        ]
                    )),
                height: 200,
                //extrudedHeight: 200,//注释掉此属性可以只显示水面
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
    var waterPrimitive3 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="12001" end="16000">
                            ${FloodPoint.longitude},
                            ${FloodPoint.latitude},
                            10,
                            </c:forEach>
                        ]
                    )),
                height: 200,
                //extrudedHeight: 200,//注释掉此属性可以只显示水面
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
    var waterPrimitive4 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="16001" end="20000">
                            ${FloodPoint.longitude},
                            ${FloodPoint.latitude},
                            10,
                            </c:forEach>
                        ]
                    )),
                height: 200,
                //extrudedHeight: 200,//注释掉此属性可以只显示水面
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
    var Collection = new Cesium.PrimitiveCollection();

    // viewer.scene.primitives.add(waterPrimitive1);
    var load;
    var i = -1;
    var count = 0;
    Sandcastle.addDefaultToolbarButton("有源淹没",
        function () {

            while (count < 4) {
                load = setInterval(loadfoints, 3000);
                count++;
            }
        }
    );
    function loadfoints() {
        i++;
        if (i == 0) {
            Collection.add(waterPrimitive0);
            viewer.scene.primitives.add(Collection);
        }
        if (i == 1) {
            Collection.add(waterPrimitive1);
            viewer.scene.primitives.add(Collection);
        }
        if (i == 2) {
            Collection.add(waterPrimitive2);
            viewer.scene.primitives.add(Collection);
        }
        if (i = 3) {
            Collection.add(waterPrimitive4);
            viewer.scene.primitives.add(Collection);
        }
        if (i == 4) {
            Collection.add(waterPrimitive5);
            viewer.scene.primitives.add(Collection);
        }
      /*  if (i == 5) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
        }
        if (i == 6) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);

        }
        if (i == 7) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);
            viewer.scene.primitives.add(waterPrimitive7);

        }
*/


    }


</script>
</html>
