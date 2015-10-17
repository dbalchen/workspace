package com.uscc.beans;

public class SwitchEntry {
    public String market;
    public String name;
    public String identifier;
    public String type;
    public String manufacturer;

    public String getMarket() {
       return market;
    }
    public void setMarket(String mkt) {
       this.market = mkt;
    }
    public String getName() {
       return name;
    }
    public void setName(String nm) {
       this.name = nm;
    }
    public String getIdentifier() {
       return identifier;
    }
    public void setIdentifier(String id) {
       this.identifier = id;
    }
    public String getType() {
       return type;
    }
    public void setType(String t) {
       this.type = t;
    }
    public String getManufacturer() {
       return manufacturer;
    }
    public void setManufacturer(String manu) {
       this.manufacturer = manu;
    }
}
