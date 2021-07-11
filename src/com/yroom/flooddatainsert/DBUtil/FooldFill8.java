package com.yroom.flooddatainsert.DBUtil;

import com.yroom.flooddatainsert.dao.FdDao;
import com.yroom.flooddatainsert.entity.*;

import org.gdal.gdal.Dataset;
import org.gdal.gdal.Driver;
import org.gdal.gdal.gdal;
import org.gdal.gdalconst.gdalconstConstants;

import java.awt.*;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class FooldFill8 {
    /**
     * m_XSize：图像的宽度（列数），m_YSize：图像的高度（行数）
     */
    static int m_XSize = 0;
    static int m_YSize = 0;
    //初始化洪水淹没体积为0
    static double Watervolume = 0;
    //初始化溃口水量，应该从前台获取  这个模拟150米的水体积
    static double QuantityofBreach = 90654048.2799981;

    static FileWriter fw=null;
    static  List<Wv> wv=new ArrayList<>();
    /// 影像坐标6变化参数
    static double[] m_adfGeoTransform = new double[6];
    //投影
    static String projection = null;
    // 缓冲区，按行优先存储
    // static double[] m_FloodBuffer=null;
    static short m_FloodBuffer[] = null;
    //存放大坝经纬度坐标，可以是多个种子点
    static List<PoiD> dabapois = new ArrayList<>();
    static double peradddem = 2;//设定死的每秒单个格子上升多少m
    static double perextend = 1;//设定死一次扩充1个格子

    public static void main(String[] args) {
        FooldFill8 t = new FooldFill8();
     /*  double a= t.getwlfromQ(275156985.0700004);
        System.out.println(a);*/
      /*  t.Form1_Load("C:\\Users\\YROOM\\Desktop\\tif数据\\屯溪大桥\\fill_txdq\\Fill_txdq1.tif");
        //对象调用加载tif数据
       dabapois.add(new PoiD(118.29587,29.71072));*/

        t.Form1_Load("C:\\Users\\FloodV\\Desktop\\屯溪大桥切割后\\河道切割3.tif");

        //对象调用加载tif数据
        //118.29878213359326  29.707149475420845  118.293 29.699十进制度
        //实验用点137
        dabapois.add(new PoiD(118.30767708040135,29.705766652836747));
        //129

        Watervolume = 0;
        t.FloodFill8Direct(165,"30m");

     /*   for (double i =119; i <304 ; i=i+0.2) {
            java.text.DecimalFormat df = new java.text.DecimalFormat("0.00");
            String str = df.format(i);
            double wf=Double.valueOf(str);
            Watervolume = 0;
            t.FloodFill8Direct(wf,"30");
        }

       FdDao fd=new FdDao();
        for (int i = 0; i <wv.size() ; i++) {
            fd.addwv(wv.get(i));
        }*/


       // t.FloodFill8Direct(140,"30");
        //dabapois.add(new PoiD(118.357614712196,29.7566226862));
       /* for(double i=139;i<401;i=i+0.2) {
            java.text.DecimalFormat df = new java.text.DecimalFormat("0.00");
            String str = df.format(i);
            double wf = Double.valueOf(str);*/

   /* for (double i =130; i <170 ; i=i+10) {
            java.text.DecimalFormat df = new java.text.DecimalFormat("0.00");
             String str = df.format(i);
             double wf=Double.valueOf(str);
            Watervolume = 0;
            t.FloodFill8Direct(wf,"30");
        }*/
        /*FdDao fd=new FdDao();
        for (int i = 0; i <wv.size() ; i++) {
            fd.addwv(wv.get(i));
        }*/
            //t.FloodFill8Direct(150, "30m");
            // }
       /* java.text.NumberFormat nf = java.text.NumberFormat.getInstance(); nf.setGroupingUsed(false);
        System.out.println(wv.toString());*/
            /*FdDao fd = new FdDao();
            for (int i = 0; i < wv.size(); i++) {
                fd.addwv(wv.get(i));
            }*/








        //设置上限和下限[120,160]
      /* double min_FloodLevel = 137;
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
        System.out.println(Watervolume);
        System.out.println("最后的水位" + m_RealFloodLevel);*/

        }


    //读取tif
    public static void Form1_Load(String fileName) {
        gdal.AllRegister();
        // gdal.SetConfigOption("GDAL_FILENAME_IS_UTF8","YES");
        //读取影像数据
        Dataset dataset = gdal.Open(fileName, gdalconstConstants.GA_ReadOnly);
        //数据为空
      /*  if (dataset == null) {
            System.err.println("GDALOpen failed - " + gdal.GetLastErrorNo());
            System.err.println(gdal.GetLastErrorMsg());
            System.exit(1);
        }*/

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
        //  int a[]=new int[3];
        //dataType=3,对应16位,所以用short类型数组接受，这行代码可以把高程值读出来
        dataset.GetRasterBand(1).ReadRaster(0, 0, m_XSize, m_YSize, m_XSize, m_YSize, dataType, m_FloodBuffer, 0, 0);
      /*  for (int i = 0; i <m_FloodBuffer.length ; i++) {
            System.out.println(m_FloodBuffer[i]);
        }*/
        dataset.GetGeoTransform(m_adfGeoTransform);
        projection = dataset.GetProjection();
        System.out.println(projection);

    }

    /**
     * 获取某点的索引
     *
     * @param point
     * @return
     */
    public static int getIndex(PointEleva point) {
        return point.getY() * m_XSize + point.getX();
    }

    public static int getIndex(NewPoint point) {
        return point.getY() * m_XSize + point.getX();
    }

    /**
     * 计算以ecenter为中心的
     *
     * @param center 中心点
     * @return
     */
    public static double getSlope(PointEleva center, int cellsize) {
        List<PointEleva> ecenter = new ArrayList<>();
        int x = center.getX();
        int y = center.getY();
        for (int i = x - 1; i < x + 2; i++) {
            for (int j = y - 1; j < y + 2; j++) {
                PointEleva temp = new PointEleva();
                temp.setX(i);
                temp.setY(j);
                //高程值没有得到
                if (GetElevation(temp) == -32768) {
                    temp.setElevation(center.Elevation);
                } else {
                    temp.setElevation(GetElevation(temp));
                }
                //装进列表
                ecenter.add(temp);
            }
        }
        double slope_degrees = 0;
        //像元ecenter在x上的变化率
        double dzdx = ((ecenter.get(2).getElevation() + 2 * ecenter.get(5).getElevation() + ecenter.get(8).getElevation()) - (ecenter.get(0).getElevation() + 2 * ecenter.get(3).getElevation()) + ecenter.get(6).getElevation()) / (8 * cellsize);
        //像元ecenter在y上的变化率
        double dzdy = ((ecenter.get(6).getElevation() + 2 * ecenter.get(7).getElevation() + ecenter.get(8).getElevation()) - (ecenter.get(0).getElevation() + 2 * ecenter.get(1).getElevation()) + ecenter.get(2).getElevation()) / (8 * cellsize);

        double rise_run = Math.sqrt((dzdx * dzdx) + (dzdy * dzdy));
        //坡度

        slope_degrees = Math.atan(rise_run) * 57.29578;

        return slope_degrees;
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

        for (double t : m_GeoTransform) {
            System.out.println("m_GeoTransform的属性：" + t);
        }
        //新加代码
        //line = (int)((m_GeoTransform[4] * (x - m_GeoTransform[0]) - m_GeoTransform[1] * (y - m_GeoTransform[3])) / (m_GeoTransform[2] * m_GeoTransform[4] - m_GeoTransform[1] * m_GeoTransform[5]));
        //pixel = (int)((m_GeoTransform[5] * (x - m_GeoTransform[0]) - m_GeoTransform[2] * (y - m_GeoTransform[3])) / (m_GeoTransform[1] * m_GeoTransform[5] - m_GeoTransform[2] * m_GeoTransform[4]));
        ///*******************///
        row = (int) ((y * m_GeoTransform[1] - x * m_GeoTransform[4] + m_GeoTransform[0] * m_GeoTransform[4] - m_GeoTransform[3] * m_GeoTransform[1]) / (m_GeoTransform[5] * m_GeoTransform[1] - m_GeoTransform[2] * m_GeoTransform[4]));
        col = (int) ((x - m_GeoTransform[0] - row * m_GeoTransform[2]) / m_GeoTransform[1]);//列

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
        double floodDepth[][] = new double[m_XSize][m_YSize];
        //最大洪水级别
        double maxfloodlevel = 1;
        //横向初始化数组，外循环控制行，内循环控制列
        for (int i = 0; i < m_YSize; i++) {
            for (int j = 0; j < m_XSize; j++) {
                //初始化全部标记没有淹没
                IsFlood[j][i] = false;
                //floodDepth[j, i] = -32768;
                //初始化全部水深为-9999
                //列行
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
            pFloodSourcePoint.setX(ans[1]);//列
            pFloodSourcePoint.setY(ans[0]);//行
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
            System.out.println("种子点的高程值"+pFloodSourcePoint.getElevation());
        }

        while (m_FloodBufferList.size() != 0) {
            // System.out.println(m_FloodBufferList.size());
            //堆栈中存在点都是可以淹没的，应该计算体积
            PointEleva pFloodSourcePoint_temp = m_FloodBufferList.get(0);//获取堆栈链表中第一个元素
            if(pFloodSourcePoint_temp.getElevation()>m_FloodLevel){
                break;
            }
            int colX = pFloodSourcePoint_temp.getX();//列号
            int rowY = pFloodSourcePoint_temp.getY();//行号
            boolean isdaba = pFloodSourcePoint_temp.isDaba();
            //标记可淹没,并从淹没堆栈中移出
            IsFlood[colX][rowY] = true;
            IsFloodLevel[colX][rowY] = pFloodSourcePoint_temp.getFloodLevel();
            //水位减去此地的高程值就得到淹没的水深
            floodDepth[colX][rowY] =  (m_FloodLevel - pFloodSourcePoint_temp.getElevation());
            //30*30表示单元高程的表面积，floodDepth[][]表示当前高程对应的水位对应的高程值
            //计算之后自加，最终得到

          //  System.out.println(colX + " " + rowY + " " + pFloodSourcePoint_temp.getElevation() + "  " + Watervolume);
            double ans=getSlope(pFloodSourcePoint_temp,35);
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
                            IsFloodLevel[temp_point.X][temp_point.Y] = temp_point.FloodLevel;
                            if (temp_point.Elevation < m_FloodLevel) {
                                floodDepth[temp_point.X][temp_point.Y] = (int)(m_FloodLevel - temp_point.Elevation);
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
        System.out.println("waterbuffer"+waterbuffer.length);
        //对缓冲数组赋值操作
        for (int i = 0; i < m_XSize; i++)
            for (int j = 0; j < m_YSize; j++) {
                //waterbuffer[j * m_XSize + i] = IsFloodLevel[i, j];
                waterbuffer[j * m_XSize + i] = (float) floodDepth[i][j];
            }
        String a = m_FloodLevel + "";
        System.out.println("写了");
        writegeotif("C:\\Users\\FloodV\\Desktop\\FloodSimulation\\floodWithSeed_" + size + "_" + a + ".tif",
                waterbuffer, m_adfGeoTransform, m_XSize, m_YSize);
        System.out.println("写完了");
        //横向初始化数组，外循环控制行，内循环控制列
        for (int i = 0; i < m_YSize; i++) {
            for (int j = 0; j < m_XSize; j++) {
                if (floodDepth[j][i] != -9999){
                    Watervolume=Watervolume+34.9*34.9*floodDepth[j][i];
                }
            }
        }
       System.out.println(m_FloodLevel+"水的体积为" + Watervolume);
        Wv s=new Wv(m_FloodLevel,Watervolume);
        wv.add(s);

    }


    public void FloodWithoutSeedPoint(double m_FloodLevel, String size){
          //行在前，列在后
        double wufloodDepth[][] = new double[m_YSize][m_XSize];
        //外循环控制行，内循环控制列
        for (int i = 0; i < m_YSize; i++) {
            for (int j = 0; j < m_XSize; j++) {
                //floodDepth[j, i] = -32768;
                //初始化全部水深为-9999
                wufloodDepth[i][j] = -9999;
            }
        }
        //外循环控制行，内循环控制列
        for (int i = 0; i < m_YSize; i++)
        {
            for (int j = 0; j < m_XSize; j++)
            {
                NewPoint temp_point = new NewPoint();
                temp_point.X = j;//列
                temp_point.Y = i;
                temp_point.Elevation = GetElevation(temp_point);
                if(temp_point.Elevation == 32768)
                {
                    continue;
                }
                if (temp_point.Elevation < m_FloodLevel)
                {
                    wufloodDepth[temp_point.Y][temp_point.X]=m_FloodLevel-temp_point.getElevation();
                }

            }

        }

        for (int i = 0; i < m_YSize; i++) {
            for (int j = 0; j < m_XSize; j++) {
                if (wufloodDepth[i][j] != -9999){
                    Watervolume=Watervolume+34.9*34.9*wufloodDepth[i][j];
                }
            }
        }
        System.out.println(m_FloodLevel+"  "+Watervolume);
        Wv s=new Wv(m_FloodLevel,Watervolume);
        wv.add(s);

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


  /*  public static double getRealfloodlevel(int Q, int V, double Hlow, double Hhigh) {

        //设置初始H水位的取值范围为（89，250）因为DEM数据最小高程值为89
        //初始的H水位是150的水位因为溃点是148
        //如果河道外的体积小于外面的体积的话，调整水位使得水位变小
        double waterh =(Hlow+Hhigh)/2;
        if (V > Q) {
            waterh=

        }
        return 0;
    }*/
 /* public static double getwlfromQ(double Q){
      double ans=0;
      double a0 = -2.823*Math.pow(10,10);
      double a1 =  3.752*Math.pow(10,10);
      double b1 =3.393*Math.pow(10,10);
      double a2 = -3.635*Math.pow(10,9);
      double b2 =  -3.608*Math.pow(10,10);
      double a3 =  -1.221*Math.pow(10,10);
      double b3 = 1.658*Math.pow(10,10);
      double a4 =8.893*Math.pow(10,9);
      double b4 =  -1.808*Math.pow(10,9);
      double a5 = -2.583*Math.pow(10,9);
      double b5 =-1.531*Math.pow(10,9);
      double a6 =2.079*Math.pow(10,8);
      double b6 = 6.719*Math.pow(10,8);
      double a7 = 4.402*Math.pow(10,7);
      double b7 = -9.452*Math.pow(10,7);
      double a8 = -6.794*Math.pow(10,6);
      double b8 = 2.862*Math.pow(10,6);
      double w =3.013*Math.pow(10,-11);
     ans =a0 + a1*Math.cos(Q*w) + b1*Math.sin(Q*w) +
                      a2*Math.cos(2*Q*w) + b2*Math.sin(2*Q*w) + a3*Math.cos(3*Q*w) + b3*Math.sin(3*Q*w) +
                      a4*Math.cos(4*Q*w) + b4*Math.sin(4*Q*w) + a5*Math.cos(5*Q*w) + b5*Math.sin(5*Q*w) +
                      a6*Math.cos(6*Q*w) + b6*Math.sin(6*Q*w) + a7*Math.cos(7*Q*w) + b7*Math.sin(7*Q*w) +
                      a8*Math.cos(8*Q*w) + b8*Math.sin(8*Q*w);



     return ans;

  }*/



}


