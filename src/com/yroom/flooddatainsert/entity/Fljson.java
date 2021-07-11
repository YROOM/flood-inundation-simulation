package com.yroom.flooddatainsert.entity;

public class Fljson {
    public int fl;
    public String js;

    public Fljson(int fl, String js) {
        this.fl = fl;
        this.js = js;
    }

    public Fljson() {
    }

    @Override
    public String toString() {
        return "Fljson{" +
                "fl=" + fl +
                ", js='" + js + '\'' +
                '}';
    }

    public int getFl() {
        return fl;
    }

    public void setFl(int fl) {
        this.fl = fl;
    }

    public String getJs() {
        return js;
    }

    public void setJs(String js) {
        this.js = js;
    }
}
