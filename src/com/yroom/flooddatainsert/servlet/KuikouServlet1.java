package com.yroom.flooddatainsert.servlet;

import com.yroom.flooddatainsert.dao.FdDao;
import com.yroom.flooddatainsert.entity.*;
import org.gdal.gdal.Dataset;
import org.gdal.gdal.Driver;
import org.gdal.gdal.gdal;
import org.gdal.gdalconst.gdalconstConstants;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;


public class KuikouServlet1 extends HttpServlet {
    /**
     * m_XSize：图像的宽度（列数），m_YSize：图像的高度（行数）
     */
    static int m_XSize = 0;
    static int m_YSize = 0;
    //初始化洪水淹没体积为0
    static int Watervolume = 0;
    /// 影像坐标6变化参数
    static double[] m_adfGeoTransform = new double[6];
    //初始化用来存放淹没点的list
    static List<Fpointsll> Inundation_points = new ArrayList<>();
    //投影
    static String projection = null;
    // 缓冲区，按行优先存储
    // static double[] m_FloodBuffer=null;
    static short m_FloodBuffer[] = null;
    //存放大坝经纬度坐标，可以是多个种子点
    static List<PoiD> dabapois = new ArrayList<>();

    //读取tif
    public static void Form1_Load(String fileName) {
        gdal.AllRegister();
        //   gdal.SetConfigOption("GDAL_FILENAME_IS_UTF8","YES");
        //读取影像数据
        Dataset dataset = gdal.Open(fileName, gdalconstConstants.GA_ReadOnly);
        Driver driver = dataset.GetDriver();
        System.out.println("Driver:" + driver.getShortName() + "/" + driver.getLongName());
        //读取影像信息
        m_XSize = dataset.getRasterXSize();
        System.out.println("m_XSize:" + m_XSize);
        m_YSize = dataset.getRasterYSize();
        System.out.println("m_YSize:" + m_YSize);
        m_FloodBuffer = new short[m_XSize * m_YSize];
        System.out.println(m_FloodBuffer.length);
        int dataType = dataset.GetRasterBand(1).GetRasterDataType();
        System.out.println(dataType);
        dataset.GetRasterBand(1).ReadRaster(0, 0, m_XSize, m_YSize, m_XSize, m_YSize, dataType, m_FloodBuffer, 0, 0);
        dataset.GetGeoTransform(m_adfGeoTransform);
        /**
         * 118.24772031857694  左上角X坐标  经
         * 2.930517163138736E-4  像元宽度
         * 0.0
         * 29.776257151229988  左上角Y坐标  纬
         * 0.0
         * -2.9305171631386837E-4
         */
        for (int i = 0; i < m_adfGeoTransform.length; i++) {
            System.out.println(m_adfGeoTransform[i]);
        }

        projection = dataset.GetProjection();
        System.out.println(projection);
    }

    /**
     * 获取某点的索引
     *
     * @param point
     * @return
     */

//获取在列表中的index
    public static int getIndex(PointEleva point) {
        return point.getY() * m_XSize + point.getX();
    }

    //获取经纬度信息
    public static int getll(PointEleva point) {
        return point.getY() * m_XSize + point.getX();
    }

    public static int getIndex(NewPoint point) {
        return point.getY() * m_XSize + point.getX();
    }

    //找到某个点在数组中
    public static double GetElevation(PointEleva m_point) {
        int idx = getIndex(m_point);
        //如果下标越界或者小于0GG
        if (idx >= m_FloodBuffer.length || idx < 0) {
            return -32768;
        }
        return m_FloodBuffer[idx];
    }

    public static double GetElevation(NewPoint m_point) {
        int idx = getIndex(m_point);
        if (idx >= m_FloodBuffer.length || idx < 0) {
            return -32768;
        }
        return m_FloodBuffer[idx];
    }

    //从地理空间转换为像素空间
    public static int[] geoToImageSpace(double[] m_GeoTransform, int sizex, int sizey, double x, double y, int col, int row, int totalindx) {
        int ans[] = new int[3];
        System.out.println("x:" + x);
        System.out.println("y:" + y);
        //int h= 0;
        for (double t : m_GeoTransform) {
            System.out.println("m_GeoTransform的属性：" + t);
        }

        row = (int) ((y * m_GeoTransform[1] - x * m_GeoTransform[4] + m_GeoTransform[0] * m_GeoTransform[4] - m_GeoTransform[3] * m_GeoTransform[1]) / (m_GeoTransform[5] * m_GeoTransform[1] - m_GeoTransform[2] * m_GeoTransform[4]));
        // h=(int)((y-m_GeoTransform[3])/m_GeoTransform[5]);
        col = (int) ((x - m_GeoTransform[0] - row * m_GeoTransform[2]) / m_GeoTransform[1]);
        System.out.println("row: " + row);
        System.out.println("col: " + col);
        totalindx = sizex * row + col;
        ans[0] = row;
        ans[1] = col;
        ans[2] = totalindx;
        return ans;
    }

    /**
     * 种子扩散算法淹没分析
     *
     * @param m_FloodLevel 淹没水位
     * @param size
     */
    public static void FloodFill8Direct(double m_FloodLevel, String size) {
        //淹没缓冲区堆栈
        List<PointEleva> m_FloodBufferList = new ArrayList<>();
        //淹没区域标记二维数组，用于标记是否可以淹没
        boolean IsFlood[][] = new boolean[m_XSize][m_YSize];
        //洪水的级别
        double IsFloodLevel[][] = new double[m_XSize][m_YSize];
        //洪水淹没区域的水深
        int floodDepth[][] = new int[m_XSize][m_YSize];
        //最大洪水级别
        double maxfloodlevel = 1;
        //横向初始化数组，外循环控制行，内循环控制列
        for (int i = 0; i < m_YSize; i++) {
            for (int j = 0; j < m_XSize; j++) {
                //初始化全部标记没有淹没
                IsFlood[j][i] = false;
                //floodDepth[j, i] = -32768;
                //初始化全部水深为-9999
                floodDepth[j][i] = -9999;
            }
        }
        //将大坝点放入列表
        for (PoiD daba : dabapois) {
            //输出大坝点的经纬度
            System.out.println(daba.getX());
            System.out.println(daba.getY());
            //首先根据种子点经纬度获取其所在行列号
            PointEleva pFloodSourcePoint = new PointEleva();
            int col = 0;
            int row = 0;
            int idx = 0;
            int ans[] = geoToImageSpace(m_adfGeoTransform, m_XSize, m_YSize, daba.getX(), daba.getY(), col, row, idx);
            System.out.println("-------------------------------------------");
            System.out.println("---idx----:" + ans[2]);
            System.out.println("---x----:" + ans[1]);
            System.out.println("---y----:" + ans[0]);
            System.out.println("******************************************");
//            System.out.println(m_FloodBuffer.length);
            System.out.println("--------------------------------------------");
            //X=col,y=row
            pFloodSourcePoint.setX(ans[1]);
            pFloodSourcePoint.setY(ans[0]);
            pFloodSourcePoint.setDaba(true);
            //pFloodSourcePoint其实是存放大坝点的，他的源点为null
            pFloodSourcePoint.setOriginPoi(null);
            pFloodSourcePoint.setFloodLevel(0);
            System.out.println(m_FloodBuffer.length);
            System.out.println("**********************");
            System.out.println(m_FloodBuffer[(m_XSize * ans[0] + ans[1])]);
            pFloodSourcePoint.setElevation(m_FloodBuffer[(m_XSize * ans[0] + ans[1])]);
            //将淹没源点种子点放入列表中
            m_FloodBufferList.add(pFloodSourcePoint);
            //创建对象将源点的坐标存入
            Fpointsll db = new Fpointsll(String.valueOf(m_adfGeoTransform[0] + pFloodSourcePoint.X * m_adfGeoTransform[1]), String.valueOf(m_adfGeoTransform[3] + pFloodSourcePoint.Y * m_adfGeoTransform[5]), pFloodSourcePoint.Elevation, pFloodSourcePoint.IsFlooded, pFloodSourcePoint.getFloodLevel());
            //放入淹没list
            Inundation_points.add(db);
        }

        while (m_FloodBufferList.size() != 0) {
            // System.out.println(m_FloodBufferList.size());
            //堆栈中存在点都是可以淹没的，应该计算体积
            PointEleva pFloodSourcePoint_temp = m_FloodBufferList.get(0);//获取堆栈链表中第一个元素
            int colX = pFloodSourcePoint_temp.getX();//列号
            int rowY = pFloodSourcePoint_temp.getY();//行号
            boolean isdaba = pFloodSourcePoint_temp.isDaba();
            //标记可淹没,并从淹没堆栈中移出
            IsFlood[colX][rowY] = true;
            IsFloodLevel[colX][rowY] = pFloodSourcePoint_temp.getFloodLevel();
            //水位减去此地的高程值就得到淹没的水深
            floodDepth[colX][rowY] = (int) (m_FloodLevel - pFloodSourcePoint_temp.getElevation());
            //30*30表示单元高程的表面积，floodDepth[][]表示当前高程对应的水位对应的高程值
            //计算之后自加，最终得到
            Watervolume = Watervolume + 30 * 30 * floodDepth[colX][rowY];
            //  System.out.println(colX+" "+rowY+" "+Watervolume);
            //移出这个点
            m_FloodBufferList.remove(0);
            //向中心格栅单元的8个临近方向搜索连通域
            //i为先从列开始先第一列，然后三行遍历
            for (int i = colX - 1; i < colX + 2; i++) {
                for (int j = rowY - 1; j < rowY + 2; j++) {
                    if (Math.sqrt((i - colX) * (i - colX) + (j - rowY) * (j - rowY)) > 3)
                        continue;
                    if (isdaba && (i + j) <= (colX + rowY))
                        continue;
                    //判断是否到达栅格边界
                    if (i < m_XSize && i >= 0 && j < m_YSize && j >= 0) {
                        PointEleva temp_point = new PointEleva();
                        temp_point.setX(i);
                        temp_point.setY(j);
                        temp_point.setElevation(GetElevation(temp_point));
                        temp_point.IsDaba = false;
                        temp_point.parentPoint = pFloodSourcePoint_temp;
                        if (temp_point.Elevation <= 0)
                            continue;
                        boolean isflood = IsFlood[temp_point.getX()][temp_point.Y];
                        //搜索可以淹没且未被标记的栅格单元
                        //如果当前点的高程值小于m_FloodLevel或者小于中心节点的高程值并且当前节点没有被淹没
                        if ((temp_point.Elevation <= m_FloodLevel || temp_point.Elevation <= pFloodSourcePoint_temp.Elevation) && IsFlood[temp_point.X][temp_point.Y] == false) {
                            //没有被淹没就标记为淹没
                            IsFlood[temp_point.X][temp_point.Y] = true;
                            temp_point.IsFlooded = true;

                            PointEleva flagpoi = pFloodSourcePoint_temp;
                            PointEleva newflagpoi = pFloodSourcePoint_temp;
                            //  boolean flag = true;
                           /* while (flag && newflagpoi.FloodLevel > 1) {
                                flagpoi = newflagpoi;
                                newflagpoi = flagpoi.originPoi;
                                flag = PointsCanReturn(IsFlood, new Fpoint(temp_point.X, temp_point.Y), new Fpoint(newflagpoi.X, newflagpoi.Y));
                            }*/
                            temp_point.originPoi = flagpoi;
                            temp_point.FloodLevel = temp_point.originPoi.FloodLevel + temp_point.PerDistance();
                            //将符合条件的栅格单元加入堆栈，标记为淹没，避免重复运算
                            m_FloodBufferList.add(temp_point);
                            Fpointsll pointsll = new Fpointsll(String.valueOf(m_adfGeoTransform[0] + temp_point.X * m_adfGeoTransform[1]), String.valueOf(m_adfGeoTransform[3] + temp_point.Y * m_adfGeoTransform[5]), temp_point.Elevation, temp_point.IsFlooded, temp_point.getFloodLevel());
                            Inundation_points.add(pointsll);
                            IsFloodLevel[temp_point.X][temp_point.Y] = temp_point.FloodLevel;
                            if (temp_point.Elevation < m_FloodLevel) {
                                floodDepth[temp_point.X][temp_point.Y] = (int) (m_FloodLevel - temp_point.Elevation);
                            }
                            if (IsFloodLevel[temp_point.X][temp_point.Y] > maxfloodlevel) {
                                maxfloodlevel = IsFloodLevel[temp_point.X][temp_point.Y];
                            }
                        }
                    }
                }
            }
        }
        //设置缓冲数组
        // double[] waterbuffer = new double[m_FloodBuffer.length];
        float[] waterbuffer = new float[m_FloodBuffer.length];
        System.out.println(waterbuffer.length);
        //对缓冲数组赋值操作
        for (int i = 0; i < m_XSize; i++)
            for (int j = 0; j < m_YSize; j++) {
                //waterbuffer[j * m_XSize + i] = IsFloodLevel[i, j];
                waterbuffer[j * m_XSize + i] = (float) floodDepth[i][j];
            }

        String a = m_FloodLevel + "";
        System.out.println("写了");
        writegeotif("C:\\Users\\YROOM\\Desktop\\FloodSimulation\\floodWithSeed_" + size + "_" + a + ".tif",
                waterbuffer, m_adfGeoTransform, m_XSize, m_YSize);
        System.out.println("写完了");
        System.out.println("水的体积为" + Watervolume);

    }

    private static void writegeotif(String path, float[] data, double[] transform, int width, int height) {
        //在GDAL中创建影像,先需要明确待创建影像的格式,并获取到该影像格式的驱动
        gdal.AllRegister();
        Driver driver = gdal.GetDriverByName("GTiff");
        //调用Creat函数创建影像
        //Driver driver.Create(路径，x方向的尺寸，y方向的尺寸，像素带，数据的类型，一些配置选项：内容是字符串类型的数组);
        Dataset m_FloodSimulatedDataSet = driver.Create(path, width, height, 1, 6, (String[]) null);
        //以下是设置影像属性
        m_FloodSimulatedDataSet.SetGeoTransform(transform); //影像转换参数
        m_FloodSimulatedDataSet.SetProjection(projection); //投影
        //writeRaster(x方向的偏移量，y方向的偏移量，x方向上的尺寸，y方向上的尺寸，缓存数据，缓存数据的宽，缓存数据的高，像素空间，线空间)
        m_FloodSimulatedDataSet.GetRasterBand(1).WriteRaster(0, 0, width, height, width, height, 6, data, 0, 0);

        //刷新像素带的缓存
        m_FloodSimulatedDataSet.GetRasterBand(1).FlushCache();
        //刷新影像数据的缓存
        m_FloodSimulatedDataSet.FlushCache();
    }

    private static boolean PointsCanReturn(boolean[][] isFlood, Fpoint poi1, Fpoint poi2) {
        //点2到点1，X方向上的距离
        int dx = poi2.getX() - poi1.getY();
        //点2到点1，Y方向上的距离
        int dy = poi2.getY() - poi1.getY();
        List<Fpoint> poi = new ArrayList<>();
        //获取微分，即∆x
        int dtx = (dx == 0) ? 0 : dx / Math.abs(dx);
        int dty = (dy == 0) ? 0 : dy / Math.abs(dy);
        //判断点1到点2的路径上的所有点，将点添加到集合中点
        if (Math.abs(dx) > Math.abs(dy)) {
            //初始化第一个待求点的x坐标
            int xmid = poi1.getX() + dtx;
            while (xmid != poi2.getX()) {
                //获取待求点的y坐标
                int ymid = (xmid - poi1.getX()) * dy / dx + poi1.getY();
                //向点集合中添加该点
                poi.add(new Fpoint(xmid, ymid));
                //待求点的x坐标移动一个单位
                xmid += dtx;
            }
        } else {
            //初始化第一个待求点的y坐标
            int ymid = poi1.getY() + dty;
            while (ymid != poi2.getY()) {
                //获取待求点的x坐标
                int xmid = (ymid - poi1.getY()) * dx / dy + poi1.getX();
                //向点集合中添加该点
                poi.add(new Fpoint(xmid, ymid));
                //待求点的y坐标移动一个单位
                ymid += dty;
            }
        }
        //判断集合中的点是否都被标记为true，如果存在没有被标为true的点，则返回false。
        for (Fpoint p : poi) {
            if (isFlood[p.getX()][p.getY()] == false) {
                return false;
            }
        }
        return true;
    }


    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        KuikouServlet1 t = new KuikouServlet1();

        System.out.println("servlet1进来了");
        Userdef ud = new Userdef();
      /*  String path2= Path.class.getClassLoader().getResource("../../web/assets/hd.tif").getPath();
       System.out.println(path2);*/
       // t.Form1_Load("C:\\Users\\YROOM\\Desktop\\tif数据\\屯溪大桥切割后\\河道切割3.tif");
     //  String path=this.getServletContext().getRealPath("hd.tif");
     //   System.out.println(path);

        String path=this.getServletContext().getRealPath("/");
        System.out.println(path);
        String real=path+"assets\\hd.tif";
        System.out.println(real);
      //  System.out.println(path);
       t.Form1_Load(real);
      //  t.Form1_Load("../../");

        //获取溃口经纬度
        dabapois.add(new PoiD(Double.valueOf(req.getParameter("klongitude")), Double.valueOf(req.getParameter("klatitude"))));
        System.out.println(Double.valueOf(req.getParameter("klongitude")));
        //获取溃口洪量
        double QuantityofBreach = Double.valueOf(req.getParameter("waterq"));
        double min_FloodLevel = 119;
        double max_FloodLevel = 160;
        double m_RealFloodLevel = 0;
        while (max_FloodLevel - min_FloodLevel >= 0.5) {
            //初始化一下淹没区体积
            Watervolume = 0;
            //初始化水位140
            m_RealFloodLevel = (min_FloodLevel + max_FloodLevel) / 2;
            //淹没水位初始化之下的体积
            t.FloodFill8Direct(m_RealFloodLevel, "30m");
            //如果当前淹没的水量大于洪水淹没溃堤的水量
            if (Watervolume > QuantityofBreach) {
                max_FloodLevel = m_RealFloodLevel;
                // continue;
            }
            //如果当前
            if (Watervolume < QuantityofBreach) {
                min_FloodLevel = m_RealFloodLevel;
            }
            if (Watervolume == QuantityofBreach) {
                break;
            }
        }
        //  System.out.println(Watervolume);
        System.out.println("最后的水位" + m_RealFloodLevel);
        ud.setWaterq(m_RealFloodLevel);
        ud.setKlongitude(Double.valueOf(req.getParameter("klongitude")));
        ud.setKlatitude(Double.valueOf(req.getParameter("klatitude")));
       // FdDao fd=new FdDao();
       // fd.adduserdef(ud);
        System.out.println(ud.toString());
        t.FloodFill8Direct(m_RealFloodLevel, "30m");
        System.out.println("淹没数据是" + Inundation_points.size());
        // System.out.println(Inundation_points.toString());
        for (int i = 0; i < Inundation_points.size(); i++) {
            Inundation_points.get(i).setFloodLevel((int) Inundation_points.get(i).getFloodLevel());
        }
        Collections.sort(Inundation_points, new Comparator<Fpointsll>() {
                    @Override
                    public int compare(Fpointsll o1, Fpointsll o2) {
                        return (int) o1.getFloodLevel() - (int) o2.getFloodLevel();
                    }
                }
        );
        
        req.getSession().setAttribute("weidu",ud);
        //req.getRequestDispatcher("/demo0113jl.jsp").forward(req, resp);*/
        req.setAttribute("fldpoints", Inundation_points);
        req.getRequestDispatcher("/demo0113jl.jsp").forward(req, resp);


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }


}
