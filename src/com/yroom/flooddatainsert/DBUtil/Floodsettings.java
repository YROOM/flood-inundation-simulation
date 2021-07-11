package com.yroom.flooddatainsert.DBUtil;

import com.yroom.flooddatainsert.entity.ElevationIdx;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class Floodsettings {

    //一个存放高程索引类的集合
    public List<ElevationIdx> _elevationidx;
    //中心格子的索引
    public int _centeridx;
    //单个长度
    public double PerLen;

    //无参构造器
    public Floodsettings() {
    }

    //有参构造器
    public Floodsettings(double perlen, int centeridx, double centerelevation, double centerwaterheight) {
        PerLen = perlen;
        _elevationidx = new ArrayList<ElevationIdx>();
        //int idx, double elevation, int direct, double waterHeight
        _elevationidx.add(new ElevationIdx(centeridx, centerelevation, 0, centerwaterheight));
        _centeridx = centeridx;

    }

    //所有高程索引的信息
    public List<ElevationIdx> AllElevationIdxInfo() {
        //调用这个方法可以获得所有的高程索引
        return _elevationidx;
    }

    //获得左边最大值的信息
    public ElevationIdx MaxLeftInfo(List<ElevationIdx> _elevationidx) {
        //从List中返回e.direct==-1的并且按照水位降序排序（选取水位最大的那一个对象返回）
        //首先找到数组中的方向为-1的
        List<ElevationIdx> temp = null;
        for (ElevationIdx e : _elevationidx) {
            //如果方向为-1
            if (e.getDirect() == -1) {
                //放入temp中
                temp.add(e);
            }
        }
        //temp现在已经按照水位降序了
        Collections.sort(temp, new Comparator<ElevationIdx>() {
            @Override
            public int compare(ElevationIdx o1, ElevationIdx o2) {
                return (int) (o2.WaterElevation(o2.getElevation(), o2.getWaterHeight()) - o1.WaterElevation(o1.getElevation(), o1.getWaterHeight()));
            }
        });
        //取出第一个
        return temp.get(0);
    }

    // 获取右边最大值的信息
    public ElevationIdx MaxRightInfo(List<ElevationIdx> _elevationidx) {
        //从List中返回e.direct==-1的并且按照水位降序排序（选取水位最大的那一个对象返回）
        //首先找到数组中的方向为-1的
        List<ElevationIdx> temp = null;
        for (ElevationIdx e : _elevationidx) {
            //如果方向为-1
            if (e.getDirect() == 1) {
                //放入temp中
                temp.add(e);
            }

        }
        //temp按照水位降序了
        Collections.sort(temp, new Comparator<ElevationIdx>() {
            @Override
            public int compare(ElevationIdx o1, ElevationIdx o2) {
                return (int) (o2.WaterElevation(o2.getElevation(), o2.getWaterHeight()) - o1.WaterElevation(o1.getElevation(), o1.getWaterHeight()));
            }
        });
        //取出第一个
        return temp.get(0);
    }

    //获取左边最大值的索引
    public int MaxLeftIdx(List<ElevationIdx> _elevationidx) {
        return MaxLeftInfo(_elevationidx).Idx;
    }

    //获取左边最大值的水位
    public double MaxLeftElevation(List<ElevationIdx> _elevationidx) {
        ElevationIdx e = MaxLeftInfo(_elevationidx);
        return e.WaterElevation(e.getElevation(), e.getWaterHeight());
    }

    //获取右边最大值的索引
    public int MaxRightIdx(List<ElevationIdx> _elevationidx) {
        return MaxRightInfo(_elevationidx).Idx;
    }

    //获取右边最大值的水位
    public double MaxRightElevation(List<ElevationIdx> _elevationidx) {
        ElevationIdx e = MaxRightInfo(_elevationidx);
        return e.WaterElevation(e.getElevation(), e.getWaterHeight());
    }

    //获取装有短索引的集合
    public List<ElevationIdx> ShortIdx(List<ElevationIdx> _elevationidx) {
        List<ElevationIdx> result = new ArrayList<>();
        ElevationIdx el = MaxLeftInfo(_elevationidx);
        ElevationIdx er = MaxRightInfo(_elevationidx);
        //如果左右最大的高程值相等
        if (MaxRightElevation(_elevationidx) == MaxLeftElevation(_elevationidx)) {
            //将两个都放入result
            result.add(el);
            result.add(er);
        } else {
            //加入左右点高程值中小的那一个
            result.add(MaxRightElevation(_elevationidx) < MaxLeftElevation(_elevationidx) ? er : el);
        }
        return result;

    }

    // 获取最大的高程值
    public double MaxElevation(List<ElevationIdx> _elevationidx) {
        //最大值由最短边决定
        return MaxLeftElevation(_elevationidx) < MaxRightElevation(_elevationidx) ? MaxLeftElevation(_elevationidx) : MaxRightElevation(_elevationidx);//最大值由最短边决定

    }

    //计算获取淹没面积
    public double FullSquare(List<ElevationIdx> _elevationidx) {
        double result = 0;
        for (ElevationIdx eleidx : _elevationidx) {
            //如果当前点的水位小于最大的水位
            if (eleidx.WaterElevation(eleidx.getElevation(), eleidx.getWaterHeight()) < MaxElevation(_elevationidx))
                result += (MaxElevation(_elevationidx) - eleidx.WaterElevation(eleidx.getElevation(), eleidx.getWaterHeight())) * PerLen;
        }
        return result;

    }


    /**
     * 添加索引
     *
     * @param addidx      要添加的索引
     * @param elevation   高程值
     * @param waterheight 水位
     */
    public void Addidx(int addidx, double elevation, double waterheight, List<ElevationIdx> _elevationidx) {
        //int idx, double elevation, int direct, double waterHeight
        _elevationidx.add(new ElevationIdx(addidx, elevation, addidx < _centeridx ? -1 : 1, waterheight));
        //根据高程值中最小的值获取索引
        Collections.sort(_elevationidx, new Comparator<ElevationIdx>() {
            @Override
            public int compare(ElevationIdx o1, ElevationIdx o2) {
                return (int) (o1.getElevation() - o2.getElevation());
            }
        });
        double max1 = _elevationidx.get(0).getElevation();

        double max2 = max1;
        try {
            List<ElevationIdx> temp = null;
            for (ElevationIdx e : _elevationidx) {
                //如果方向为1
                if (e.getDirect() == 1) {
                    //放入temp中
                    temp.add(e);
                }
            }

            Collections.sort(temp, new Comparator<ElevationIdx>() {
                @Override
                public int compare(ElevationIdx o1, ElevationIdx o2) {
                    return (int) (o2.getElevation() - o1.getElevation());
                }
            });
            max1 = temp.get(0).getElevation();
        } catch (Exception ee) {
        }
        try {
            List<ElevationIdx> temp1 = null;
            for (ElevationIdx e : _elevationidx) {
                //如果方向为1
                if (e.getDirect() == -1) {
                    //放入temp中
                    temp1.add(e);
                }
            }

            Collections.sort(temp1, new Comparator<ElevationIdx>() {
                @Override
                public int compare(ElevationIdx o1, ElevationIdx o2) {
                    return (int) (o2.getElevation() - o1.getElevation());
                }
            });
            max2 = temp1.get(0).getElevation();
        } catch (Exception ee) {
        }


    }

    //获取索引集合
    public List<Integer> GetIdxs(List<ElevationIdx> _elevationidx) {
        List<Integer> ans = new ArrayList<>();
        for (ElevationIdx e : _elevationidx) {
            ans.add(e.getIdx());

        }
        return ans;
    }

    //获取高度

    /**
     *
     * @param square 总面积
     * @return
     */
    public double GetHeight(double square,List<ElevationIdx> _elevationidx){
        double result = 0;
        //_elevationidx.OrderBy(e => e.WaterElevation).ToList();
        List<ElevationIdx> elevationids=_elevationidx;
        Collections.sort(elevationids, new Comparator<ElevationIdx>() {
            @Override
            public int compare(ElevationIdx o1, ElevationIdx o2) {
                return (int) (o1.WaterElevation(o1.getElevation(), o1.getWaterHeight()) - o2.WaterElevation(o2.getElevation(), o2.getWaterHeight()));
            }
        });

        double nowsquare = 0;

        for(int i=1;i<elevationids.size();i++)
        {
            double nowheight = (elevationids.get(i).WaterElevation( elevationids.get(i).getElevation(), elevationids.get(i).getWaterHeight()) - elevationids.get(i-1).WaterElevation( elevationids.get(i-1).getElevation(), elevationids.get(i-1).getWaterHeight()));
            double newsquare =nowheight* i*PerLen;
            if(newsquare+nowsquare>square)
            {
                result = (square - nowsquare) * nowheight / newsquare + elevationids.get(i-1).WaterElevation( elevationids.get(i-1).getElevation(), elevationids.get(i-1).getWaterHeight());
                break;
            }
            nowsquare += newsquare;
        }
        return result;
    }


}
