package com.uscc.beans;

public class Role {
    public String role_name;

    public String userid;

    public String role_description;

    public String getRoleName() {
        return role_name;
    }

    public String getuserid() {
        return userid;
    }

    public void setuserid(String user) {
        this.userid = user;
    }

    public void setRoleName(String role) {
        this.role_name = role;
    }

    public String getRoleDescription() {
        return role_description;
    }

    public void setRoleDescription(String desc) {
        this.role_description = desc;
    }
}
