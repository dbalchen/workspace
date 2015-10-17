package com.uscc.beans;

public class CallDumpDate {

    public String year;
    public String month;
    public String day;
    public String hour;
    public String minute;

    public CallDumpDate(String year) {
       this.year = year;
    }
    public String getYear() {
       return year;
    }
    public void setYear(String year) {
       this.year = year;
    }
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getHour() {
		return hour;
	}
	public void setHour(String hour) {
		this.hour = hour;
	}
	public String getMinute() {
		return minute;
	}
	public void setMinute(String minute) {
		this.minute = minute;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
}
