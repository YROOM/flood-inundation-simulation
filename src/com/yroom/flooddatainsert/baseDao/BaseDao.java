package com.yroom.flooddatainsert.baseDao;

import com.yroom.flooddatainsert.DBUtil.DbUtil;

import java.sql.Connection;

public class BaseDao<T> {
    private DbUtil dbUtil = new DbUtil() ;
    public Connection connection = dbUtil.getConnection();
    public void closeConnection() {
        dbUtil.closeConnection();
    }
}
