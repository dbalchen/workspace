package com.uscc.beans;


public class CallDumpRequest {

 int id;
 int priority;
 int pid;
 String status;
 String next_status;
 String userid;
 String submit_date;
 String start_date;
 String end_date;
 String switches_m01 = "";
 String switches_m02 = "";
 String switches_m03 = "";
 String switches_m04 = "";
 String switches_m05 = "";
 String switches_m06 = "";
 String switches_Data = "";
 String search_string_1 = "";
 String search_string_2 = "";
 String search_string_3 = "";
 String search_string_4 = "";
 String search_string_5 = "";
 String search_string_6 = "";
 String search_string_type_1 = "";
 String search_string_type_2 = "";
 String search_string_type_3 = "";
 String search_string_type_4 = "";
 String search_string_type_5 = "";
 String search_string_type_6 = "";
 String name = "";
 String color = "";
 
 public CallDumpRequest() {
     setPid(0);
 }
 public void setsubmitName(String d) {this.name = d;}
 public String getsubmitName() {return this.name;}
 public void setColor(String d) {this.color = d;}
 public String getColor() {return this.color;}
 public void setStartDate(String d) {this.start_date = d;}
 public void setEndDate(String d) {this.end_date = d;}
 public void setSubmitDate(String d) {this.submit_date = d;}
 public String getStartDate() {return this.start_date;}
 public String getEndDate() {return this.end_date;}
 public String getSubmitDate() {return this.submit_date;}
 public int getId() {return id;}
 public void setId(int i) {this.id=i;}
 public int getPriority() {return priority;}
 public void setPriority(int p) {this.priority=p;}
 public int getPid() {return pid;}
 public void setPid(int p) {this.pid=p;}

 public String getStatus() {return status;}
 public String getNextStatus() {return next_status;}
 public void setNextStatus(String d) {next_status=d;}
 public void setStatus(String p) {this.status=p;}
 public String getUserid() {return userid;}
 public void setUserid(String p) {this.userid=p;}
 public String getSwitchesM01() {return switches_m01;}
 public void setSwitchesM01(String p) {this.switches_m01=p;}
 public String getSwitchesM02() {return switches_m02;}
 public void setSwitchesM02(String p) {this.switches_m02=p;}
 public String getSwitchesM03() {return switches_m03;}
 public void setSwitchesM03(String p) {this.switches_m03=p;}
 public String getSwitchesM04() {return switches_m04;}
 public void setSwitchesM04(String p) {this.switches_m04=p;}
 public String getSwitchesM05() {return switches_m05;}
 public void setSwitchesM05(String p) {this.switches_m05=p;}
 public String getSwitchesM06() {return switches_m06;}
 public void setSwitchesM06(String p) {this.switches_m06=p;}
 public String getSwitchesData() {return switches_Data;}
 public void setSwitchesData(String p) {this.switches_Data=p;}
 
 public String getSearchString1() {return search_string_1;}
 public void setSearchString1(String p) {this.search_string_1=p;}
 public String getSearchString2() {return search_string_2;}
 public void setSearchString2(String p) {this.search_string_2=p;}
 public String getSearchString3() {return search_string_3;}
 public void setSearchString3(String p) {this.search_string_3=p;}
 public String getSearchString4() {return search_string_4;}
 public void setSearchString4(String p) {this.search_string_4=p;}
 public String getSearchString5() {return search_string_5;}
 public void setSearchString5(String p) {this.search_string_5=p;}
 public String getSearchString6() {return search_string_6;}
 public void setSearchString6(String p) {this.search_string_6=p;}

 public String getSearchStringType1() {return search_string_type_1;}
 public void setSearchStringType1(String p) {this.search_string_type_1=p;}
 public String getSearchStringType2() {return search_string_type_2;}
 public void setSearchStringType2(String p) {this.search_string_type_2=p;}
 public String getSearchStringType3() {return search_string_type_3;}
 public void setSearchStringType3(String p) {this.search_string_type_3=p;}
 public String getSearchStringType4() {return search_string_type_4;}
 public void setSearchStringType4(String p) {this.search_string_type_4=p;}
 public String getSearchStringType5() {return search_string_type_5;}
 public void setSearchStringType5(String p) {this.search_string_type_5=p;}
 public String getSearchStringType6() {return search_string_type_6;}
 public void setSearchStringType6(String p) {this.search_string_type_6=p;}
 public void display() {
    System.out.println("id: " + id);
    System.out.println("pri : " + priority);
    System.out.println("pid : " +  pid);
    System.out.println("sta : " +  status);
    System.out.println("usr : " +  userid);
    System.out.println("sub : " + submit_date);
    System.out.println("srt : " + start_date);
    System.out.println("end : " + end_date);
    System.out.println("sw1 : " + switches_m01);
    System.out.println("sw2 : " + switches_m02);
    System.out.println("sw3 : " + switches_m03);
    System.out.println("sw4 : " + switches_m04);
    System.out.println("sw5 : " + switches_m05);
    System.out.println("sw6 : " + switches_m06);
    System.out.println("swd : " + switches_Data);
    System.out.println("ss1 : " + search_string_1);
    System.out.println("ss2 : " + search_string_2);
    System.out.println("ss3 : " + search_string_3);
    System.out.println("ss4 : " + search_string_4);
    System.out.println("ss5 : " + search_string_5);
    System.out.println("ss6 : " + search_string_6);
    System.out.println("sst1: " + search_string_type_1);
    System.out.println("sst2: " + search_string_type_2);
    System.out.println("sst3: " + search_string_type_3);
    System.out.println("sst4: " + search_string_type_4);
    System.out.println("sst5: " + search_string_type_5);
    System.out.println("sst6: " + search_string_type_6);
    System.out.println("color: " + color);
 }

}

