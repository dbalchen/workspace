package com.uscc.beans;

public class Navigation {
    public String prevstartkey;
    public String prevendkey;
    public String status;
    public String restrict;
    public String timeframe;
    public String nextstartkey; 
    public String nextendkey;
    public String getNextendkey() {
        return nextendkey;
    }
    public void setNextendkey(String nextendkey) {
        this.nextendkey = nextendkey;
    }
    public String getNextstartkey() {
        return nextstartkey;
    }
    public void setNextstartkey(String nextstartkey) {
        this.nextstartkey = nextstartkey;
    }
    public String getPrevendkey() {
        return prevendkey;
    }
    public void setPrevendkey(String prevendkey) {
        this.prevendkey = prevendkey;
    }
    public String getPrevstartkey() {
        return prevstartkey;
    }
    public void setPrevstartkey(String prevstartkey) {
        this.prevstartkey = prevstartkey;
    }
    public String getRestrict() {
        return restrict;
    }
    public void setRestrict(String restrict) {
        this.restrict = restrict;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public String getTimeframe() {
        return timeframe;
    }
    public void setTimeframe(String timeframe) {
        this.timeframe = timeframe;
    }
    


}
