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
    var waterPrimitive5 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="20001" end="24000">
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
    var waterPrimitive6 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="24001" end="28000">
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
    var waterPrimitive7 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="28001" end="32000">
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
    var waterPrimitive8 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="32001" end="36000">
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
    var waterPrimitive9 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="36001" end="40000">
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
    var waterPrimitive10 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="40001" end="44000">
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
    var waterPrimitive11 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="44001" end="48000">
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
    var waterPrimitive12 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="48001" end="52000">
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
    var waterPrimitive13 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="52001" end="56000">
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
    var waterPrimitive14 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="56001" end="60000">
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
    var waterPrimitive15 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="60001" end="64000">
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
    var waterPrimitive16 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="64001" end="68000">
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
    var waterPrimitive17 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="68001" end="72000">
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
    var waterPrimitive18 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="72001" end="76000">
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
    var waterPrimitive19 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="76001" end="80000">
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
    var waterPrimitive20 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="80001" end="84000">
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
    var waterPrimitive21 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="84001" end="88000">
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
    var waterPrimitive22 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="88001" end="92000">
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
    var waterPrimitive23 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="92001" end="96000">
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
    var waterPrimitive24 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="96001" end="100000">
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
    var waterPrimitive25 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="100001" end="104000">
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
    var waterPrimitive26 = new Cesium.GroundPrimitive({
        show: true, // 默认隐藏
        allowPicking: false,
        geometryInstances: new Cesium.GeometryInstance({
            geometry: new Cesium.PolygonGeometry({
                polygonHierarchy: new Cesium.PolygonHierarchy(
                    Cesium.Cartesian3.fromDegreesArrayHeights([
                            <c:forEach items="${fldpoints }" var="FloodPoint"  begin="104001" end="107419">
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
            viewer.scene.primitives.add(waterPrimitive0);
        }
        if (i == 1) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
        }
        if (i == 2) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);

        }
        if (i = 3) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
        }
        if (i == 4) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
        }
        if (i == 5) {
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
        if (i == 8) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);
            viewer.scene.primitives.add(waterPrimitive7);
            viewer.scene.primitives.add(waterPrimitive8);

        }
        if (i == 9) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);
            viewer.scene.primitives.add(waterPrimitive7);
            viewer.scene.primitives.add(waterPrimitive8);
            viewer.scene.primitives.add(waterPrimitive9);

        }
        if (i == 10) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);
            viewer.scene.primitives.add(waterPrimitive7);
            viewer.scene.primitives.add(waterPrimitive8);
            viewer.scene.primitives.add(waterPrimitive9);
            viewer.scene.primitives.add(waterPrimitive10);

        }
        if (i == 11) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);
            viewer.scene.primitives.add(waterPrimitive7);
            viewer.scene.primitives.add(waterPrimitive8);
            viewer.scene.primitives.add(waterPrimitive9);
            viewer.scene.primitives.add(waterPrimitive10);
            viewer.scene.primitives.add(waterPrimitive11);

        }
        if (i == 12) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);
            viewer.scene.primitives.add(waterPrimitive7);
            viewer.scene.primitives.add(waterPrimitive8);
            viewer.scene.primitives.add(waterPrimitive9);
            viewer.scene.primitives.add(waterPrimitive10);
            viewer.scene.primitives.add(waterPrimitive11);
            viewer.scene.primitives.add(waterPrimitive12);

        }
        if (i == 13) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);
            viewer.scene.primitives.add(waterPrimitive7);
            viewer.scene.primitives.add(waterPrimitive8);
            viewer.scene.primitives.add(waterPrimitive9);
            viewer.scene.primitives.add(waterPrimitive10);
            viewer.scene.primitives.add(waterPrimitive11);
            viewer.scene.primitives.add(waterPrimitive12);
            viewer.scene.primitives.add(waterPrimitive13);
        }
        if (i == 14) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);
            viewer.scene.primitives.add(waterPrimitive7);
            viewer.scene.primitives.add(waterPrimitive8);
            viewer.scene.primitives.add(waterPrimitive9);
            viewer.scene.primitives.add(waterPrimitive10);
            viewer.scene.primitives.add(waterPrimitive11);
            viewer.scene.primitives.add(waterPrimitive12);
            viewer.scene.primitives.add(waterPrimitive13);
            viewer.scene.primitives.add(waterPrimitive14);

        }
        if (i == 15) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);
            viewer.scene.primitives.add(waterPrimitive7);
            viewer.scene.primitives.add(waterPrimitive8);
            viewer.scene.primitives.add(waterPrimitive9);
            viewer.scene.primitives.add(waterPrimitive10);
            viewer.scene.primitives.add(waterPrimitive11);
            viewer.scene.primitives.add(waterPrimitive12);
            viewer.scene.primitives.add(waterPrimitive13);
            viewer.scene.primitives.add(waterPrimitive14);
            viewer.scene.primitives.add(waterPrimitive15);

        }
        if (i == 16) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);
            viewer.scene.primitives.add(waterPrimitive7);
            viewer.scene.primitives.add(waterPrimitive8);
            viewer.scene.primitives.add(waterPrimitive9);
            viewer.scene.primitives.add(waterPrimitive10);
            viewer.scene.primitives.add(waterPrimitive11);
            viewer.scene.primitives.add(waterPrimitive12);
            viewer.scene.primitives.add(waterPrimitive13);
            viewer.scene.primitives.add(waterPrimitive14);
            viewer.scene.primitives.add(waterPrimitive15);
            viewer.scene.primitives.add(waterPrimitive16);

        }
        if (i == 17) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);
            viewer.scene.primitives.add(waterPrimitive7);
            viewer.scene.primitives.add(waterPrimitive8);
            viewer.scene.primitives.add(waterPrimitive9);
            viewer.scene.primitives.add(waterPrimitive10);
            viewer.scene.primitives.add(waterPrimitive11);
            viewer.scene.primitives.add(waterPrimitive12);
            viewer.scene.primitives.add(waterPrimitive13);
            viewer.scene.primitives.add(waterPrimitive14);
            viewer.scene.primitives.add(waterPrimitive15);
            viewer.scene.primitives.add(waterPrimitive16);
            viewer.scene.primitives.add(waterPrimitive17);

        }
        if (i == 18) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);
            viewer.scene.primitives.add(waterPrimitive7);
            viewer.scene.primitives.add(waterPrimitive8);
            viewer.scene.primitives.add(waterPrimitive9);
            viewer.scene.primitives.add(waterPrimitive10);
            viewer.scene.primitives.add(waterPrimitive11);
            viewer.scene.primitives.add(waterPrimitive12);
            viewer.scene.primitives.add(waterPrimitive13);
            viewer.scene.primitives.add(waterPrimitive14);
            viewer.scene.primitives.add(waterPrimitive15);
            viewer.scene.primitives.add(waterPrimitive16);
            viewer.scene.primitives.add(waterPrimitive17);
            viewer.scene.primitives.add(waterPrimitive18);

        }
        if (i == 19) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);
            viewer.scene.primitives.add(waterPrimitive7);
            viewer.scene.primitives.add(waterPrimitive8);
            viewer.scene.primitives.add(waterPrimitive9);
            viewer.scene.primitives.add(waterPrimitive10);
            viewer.scene.primitives.add(waterPrimitive11);
            viewer.scene.primitives.add(waterPrimitive12);
            viewer.scene.primitives.add(waterPrimitive13);
            viewer.scene.primitives.add(waterPrimitive14);
            viewer.scene.primitives.add(waterPrimitive15);
            viewer.scene.primitives.add(waterPrimitive16);
            viewer.scene.primitives.add(waterPrimitive17);
            viewer.scene.primitives.add(waterPrimitive18);
            viewer.scene.primitives.add(waterPrimitive19);

        }
        if (i == 20) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);
            viewer.scene.primitives.add(waterPrimitive7);
            viewer.scene.primitives.add(waterPrimitive8);
            viewer.scene.primitives.add(waterPrimitive9);
            viewer.scene.primitives.add(waterPrimitive10);
            viewer.scene.primitives.add(waterPrimitive11);
            viewer.scene.primitives.add(waterPrimitive12);
            viewer.scene.primitives.add(waterPrimitive13);
            viewer.scene.primitives.add(waterPrimitive14);
            viewer.scene.primitives.add(waterPrimitive15);
            viewer.scene.primitives.add(waterPrimitive16);
            viewer.scene.primitives.add(waterPrimitive17);
            viewer.scene.primitives.add(waterPrimitive18);
            viewer.scene.primitives.add(waterPrimitive19);
            viewer.scene.primitives.add(waterPrimitive20);


        }
        if (i == 21) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);
            viewer.scene.primitives.add(waterPrimitive7);
            viewer.scene.primitives.add(waterPrimitive8);
            viewer.scene.primitives.add(waterPrimitive9);
            viewer.scene.primitives.add(waterPrimitive10);
            viewer.scene.primitives.add(waterPrimitive11);
            viewer.scene.primitives.add(waterPrimitive12);
            viewer.scene.primitives.add(waterPrimitive13);
            viewer.scene.primitives.add(waterPrimitive14);
            viewer.scene.primitives.add(waterPrimitive15);
            viewer.scene.primitives.add(waterPrimitive16);
            viewer.scene.primitives.add(waterPrimitive17);
            viewer.scene.primitives.add(waterPrimitive18);
            viewer.scene.primitives.add(waterPrimitive19);
            viewer.scene.primitives.add(waterPrimitive20);
            viewer.scene.primitives.add(waterPrimitive21);

        }
        if (i == 22) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);
            viewer.scene.primitives.add(waterPrimitive7);
            viewer.scene.primitives.add(waterPrimitive8);
            viewer.scene.primitives.add(waterPrimitive9);
            viewer.scene.primitives.add(waterPrimitive10);
            viewer.scene.primitives.add(waterPrimitive11);
            viewer.scene.primitives.add(waterPrimitive12);
            viewer.scene.primitives.add(waterPrimitive13);
            viewer.scene.primitives.add(waterPrimitive14);
            viewer.scene.primitives.add(waterPrimitive15);
            viewer.scene.primitives.add(waterPrimitive16);
            viewer.scene.primitives.add(waterPrimitive17);
            viewer.scene.primitives.add(waterPrimitive18);
            viewer.scene.primitives.add(waterPrimitive19);
            viewer.scene.primitives.add(waterPrimitive20);
            viewer.scene.primitives.add(waterPrimitive21);
            viewer.scene.primitives.add(waterPrimitive22);

        }
        if (i == 23) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);
            viewer.scene.primitives.add(waterPrimitive7);
            viewer.scene.primitives.add(waterPrimitive8);
            viewer.scene.primitives.add(waterPrimitive9);
            viewer.scene.primitives.add(waterPrimitive10);
            viewer.scene.primitives.add(waterPrimitive11);
            viewer.scene.primitives.add(waterPrimitive12);
            viewer.scene.primitives.add(waterPrimitive13);
            viewer.scene.primitives.add(waterPrimitive14);
            viewer.scene.primitives.add(waterPrimitive15);
            viewer.scene.primitives.add(waterPrimitive16);
            viewer.scene.primitives.add(waterPrimitive17);
            viewer.scene.primitives.add(waterPrimitive18);
            viewer.scene.primitives.add(waterPrimitive19);
            viewer.scene.primitives.add(waterPrimitive20);
            viewer.scene.primitives.add(waterPrimitive21);
            viewer.scene.primitives.add(waterPrimitive22);
            viewer.scene.primitives.add(waterPrimitive23);

        }
        if (i == 24) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);
            viewer.scene.primitives.add(waterPrimitive7);
            viewer.scene.primitives.add(waterPrimitive8);
            viewer.scene.primitives.add(waterPrimitive9);
            viewer.scene.primitives.add(waterPrimitive10);
            viewer.scene.primitives.add(waterPrimitive11);
            viewer.scene.primitives.add(waterPrimitive12);
            viewer.scene.primitives.add(waterPrimitive13);
            viewer.scene.primitives.add(waterPrimitive14);
            viewer.scene.primitives.add(waterPrimitive15);
            viewer.scene.primitives.add(waterPrimitive16);
            viewer.scene.primitives.add(waterPrimitive17);
            viewer.scene.primitives.add(waterPrimitive18);
            viewer.scene.primitives.add(waterPrimitive19);
            viewer.scene.primitives.add(waterPrimitive20);
            viewer.scene.primitives.add(waterPrimitive21);
            viewer.scene.primitives.add(waterPrimitive22);
            viewer.scene.primitives.add(waterPrimitive23);
            viewer.scene.primitives.add(waterPrimitive24);

        }
        if (i == 25) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);
            viewer.scene.primitives.add(waterPrimitive7);
            viewer.scene.primitives.add(waterPrimitive8);
            viewer.scene.primitives.add(waterPrimitive9);
            viewer.scene.primitives.add(waterPrimitive10);
            viewer.scene.primitives.add(waterPrimitive11);
            viewer.scene.primitives.add(waterPrimitive12);
            viewer.scene.primitives.add(waterPrimitive13);
            viewer.scene.primitives.add(waterPrimitive14);
            viewer.scene.primitives.add(waterPrimitive15);
            viewer.scene.primitives.add(waterPrimitive16);
            viewer.scene.primitives.add(waterPrimitive17);
            viewer.scene.primitives.add(waterPrimitive18);
            viewer.scene.primitives.add(waterPrimitive19);
            viewer.scene.primitives.add(waterPrimitive20);
            viewer.scene.primitives.add(waterPrimitive21);
            viewer.scene.primitives.add(waterPrimitive22);
            viewer.scene.primitives.add(waterPrimitive23);
            viewer.scene.primitives.add(waterPrimitive24);
            viewer.scene.primitives.add(waterPrimitive25);

        }
        if (i == 26) {
            viewer.scene.primitives.add(waterPrimitive0);
            viewer.scene.primitives.add(waterPrimitive1);
            viewer.scene.primitives.add(waterPrimitive2);
            viewer.scene.primitives.add(waterPrimitive3);
            viewer.scene.primitives.add(waterPrimitive4);
            viewer.scene.primitives.add(waterPrimitive5);
            viewer.scene.primitives.add(waterPrimitive6);
            viewer.scene.primitives.add(waterPrimitive7);
            viewer.scene.primitives.add(waterPrimitive8);
            viewer.scene.primitives.add(waterPrimitive9);
            viewer.scene.primitives.add(waterPrimitive10);
            viewer.scene.primitives.add(waterPrimitive11);
            viewer.scene.primitives.add(waterPrimitive12);
            viewer.scene.primitives.add(waterPrimitive13);
            viewer.scene.primitives.add(waterPrimitive14);
            viewer.scene.primitives.add(waterPrimitive15);
            viewer.scene.primitives.add(waterPrimitive16);
            viewer.scene.primitives.add(waterPrimitive17);
            viewer.scene.primitives.add(waterPrimitive18);
            viewer.scene.primitives.add(waterPrimitive19);
            viewer.scene.primitives.add(waterPrimitive20);
            viewer.scene.primitives.add(waterPrimitive21);
            viewer.scene.primitives.add(waterPrimitive22);
            viewer.scene.primitives.add(waterPrimitive23);
            viewer.scene.primitives.add(waterPrimitive24);
            viewer.scene.primitives.add(waterPrimitive25);
            viewer.scene.primitives.add(waterPrimitive26);
        }


    }


</script>
</html>
