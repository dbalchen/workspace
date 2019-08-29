package com.uscc.dao;

import com.uscc.beans.*;

import java.lang.Character;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

public class UserDAO extends DAO {
    /**
     * Constructs the data accessor with the given data source
     */
    public UserDAO(DataSource theDataSource) {
        super(theDataSource);
    }

    public UserDAO(Connection con) {
        super(con);
    }

    public List<Developer> getAllUsers(String app) {
        ArrayList<Developer> theList = new ArrayList<Developer>();
        Connection tempConn = null;
        Statement myStmt = null;
        ResultSet myRs = null;
        String color = "white";

        if (app == null) {
            app = "all";
        }
        try {
            tempConn = getConnection();
            myStmt = tempConn.createStatement();

            String Sql = "select t1.*, decode(t1.status,1,'Active','Inactive') dcst";
            Sql += "  from users t1, user_roles t2, application_roles t3, applications t4 ";
            Sql += " where t1.userid = t2.userid ";
            Sql += "   and t2.role_name = t3.role_name ";
            Sql += "   and t3.appname = t4.appname ";
            if (!app.equalsIgnoreCase("all")) {
                Sql += "   and t4.appname = '" + app + "'";
            }
            Sql += "union ";
            Sql += " select t2.*, decode(t2.status,1,'Active','Inactive') dcst";
            Sql += "   from users t2";
            Sql += "  where not exists (select 'x' from user_roles ur " ;
            Sql += "                               where t2.userid = ur.userid and ur.role_name in (select role_name from application_roles ap";
            Sql += "  where appname = '" + app + "'))";
            Sql += "  order by 3,2";

            myRs = myStmt.executeQuery(Sql);
            while (myRs.next()) {
                Developer usr = new Developer();
                usr.setUserId(myRs.getString("userid"));
                usr.setFirstName(myRs.getString("first"));
                usr.setLastName(myRs.getString("last"));
                usr.setEmailAddress(myRs.getString("email_address"));
                usr.setStatus(myRs.getString("dcst"));
                usr.setUtil(color);
                if (color.equalsIgnoreCase("white")) {
                    color = "#E0E0E0";
                } else {
                    color = "white";
                }
                theList.add(usr);
            }
        } catch (SQLException exc) {
            logError(exc);

            // throw new DAOException(exc);
        } finally {
            cleanup(myRs, myStmt, tempConn);
        }

        return theList;
    }

    public List<User> getUsers() {
        ArrayList<User> theList = new ArrayList<User>();
        Connection tempConn = null;
        Statement myStmt = null;
        ResultSet myRs = null;

        try {
            tempConn = getConnection();
            myStmt = tempConn.createStatement();

            String Sql = " select userid from users";
            myRs = myStmt.executeQuery(Sql);

            while (myRs.next()) {
                User usr = new User();
                usr.setUserName(myRs.getString("userid"));
                theList.add(usr);
            }
        } catch (SQLException exc) {
            logError(exc);

            // throw new DAOException(exc);
        } finally {
            cleanup(myRs, myStmt, tempConn);
        }

        return theList;
    }

    public List<Developer> getApprovers(String userid) {
        ArrayList<Developer> theList = new ArrayList<Developer>();
        Connection tempConn = null;
        Statement myStmt = null;
        ResultSet myRs = null;

        try {
            tempConn = getConnection();
            myStmt = tempConn.createStatement();

            String Sql = " select t1.approver, t2.first fn, t2.last ln, t2.email_address em";
            Sql += "         from developer_approver t1, users t2 ";
            Sql += ("        where t1.approver = t2.userid and t1.developer = '"
                    + userid + "'");

            myRs = myStmt.executeQuery(Sql);

            while (myRs.next()) {
                Developer dev = new Developer();
                dev.setFirstName(myRs.getString("fn"));
                dev.setLastName(myRs.getString("ln"));
                dev.setEmailAddress(myRs.getString("em"));
                theList.add(dev);
            }
        } catch (SQLException exc) {
            logError(exc);

            // throw new DAOException(exc);
        } finally {
            cleanup(myRs, myStmt, tempConn);
        }

        return theList;
    }

    public boolean isApprover(String approver, String developer) {
        Connection tempConn = null;
        Statement myStmt = null;
        ResultSet myRs = null;
        boolean result = false;

        try {
            tempConn = getConnection();
            myStmt = tempConn.createStatement();

            String Sql = " select t1.approver, t1.developer";
            Sql += "         from developer_approver t1";
            Sql += ("        where t1.approver = '" + approver
                    + "' and t1.developer = '" + developer + "'");
            myRs = myStmt.executeQuery(Sql);

            while (myRs.next()) {
                result = true;

                break;
            }
        } catch (SQLException exc) {
            logError(exc);

            // throw new DAOException(exc);
        } finally {
            cleanup(myRs, myStmt, tempConn);
        }

        return result;
    }

    public List<Developer> getApprovers() {
        ArrayList<Developer> theList = new ArrayList<Developer>();
        Connection tempConn = null;
        Statement myStmt = null;
        ResultSet myRs = null;

        try {
            tempConn = getConnection();
            myStmt = tempConn.createStatement();

            String Sql = " select usr.userid ui, usr.first fn, usr.last ln, usr.email_address em";
            Sql += " from users usr, user_roles usrr ";
            Sql += " where usr.userid = usrr.userid and usrr.role_name = 'managers' order by usr.userid";

            myRs = myStmt.executeQuery(Sql);

            while (myRs.next()) {
                Developer dev = new Developer();
                dev.setFirstName(myRs.getString("fn"));
                dev.setLastName(myRs.getString("ln"));
                dev.setEmailAddress(myRs.getString("em"));
                dev.setUserId(myRs.getString("ui"));
                theList.add(dev);
            }
        } catch (SQLException exc) {
            logError(exc);

            // throw new DAOException(exc);
        } finally {
            cleanup(myRs, myStmt, tempConn);
        }

        return theList;
    }

    public List<Developer> getGroups() {
        ArrayList<Developer> theList = new ArrayList<Developer>();
        Connection tempConn = null;
        Statement myStmt = null;
        ResultSet myRs = null;

        try {
            tempConn = getConnection();
            myStmt = tempConn.createStatement();

            String Sql = " select groupid, group_name from groups";
            myRs = myStmt.executeQuery(Sql);

            while (myRs.next()) {
                Developer dev = new Developer();
                dev.setFirstName(myRs.getString("fn"));
                dev.setLastName(myRs.getString("ln"));
                dev.setEmailAddress(myRs.getString("em"));
                dev.setUserId(myRs.getString("ui"));
                theList.add(dev);
            }
        } catch (SQLException exc) {
            logError(exc);

            // throw new DAOException(exc);
        } finally {
            cleanup(myRs, myStmt, tempConn);
        }

        return theList;
    }

    /**
     * Return a List of Release objects for all Open releases
     * 
     * @return List of Open Releases (sorted by version)
     */
    public List<Developer> getDevelopers() {
        ArrayList<Developer> theList = new ArrayList<Developer>();
        Connection tempConn = null;
        Statement myStmt = null;
        ResultSet myRs = null;

        try {
            tempConn = getConnection();
            myStmt = tempConn.createStatement();

            String Sql = " select usr.userid, usr.first,usr.last from users usr, user_roles usrr ";
            Sql += " where usr.userid = usrr.userid and usrr.role_name = 'developers' order by usr.userid";
            myRs = myStmt.executeQuery(Sql);

            while (myRs.next()) {
                Developer dev = new Developer();
                dev.setUserId(myRs.getString("userid"));
                dev.setFirstName(myRs.getString("first"));
                dev.setLastName(myRs.getString("last"));
                theList.add(dev);
            }
        } catch (SQLException exc) {
            logError(exc);

            // throw new DAOException(exc);
        } finally {
            cleanup(myRs, myStmt, tempConn);
        }

        return theList;
    }

    public void updateStatus(String user, String status) throws DAOException {
        Connection tempConn = null;
        PreparedStatement myStmt = null;
        ResultSet myRs = null;
        int intstatus = 1;

        if (user.equalsIgnoreCase("root")) {
            return;
        }

        try {
            tempConn = getConnection();
            tempConn.setAutoCommit(false);
            if (status.equalsIgnoreCase("Active")) {
                intstatus = 0;
                String sqlupdate = "update users set password = 'SUSPENDED'||password where userid = '"
                        + user + "'";
                myStmt = tempConn.prepareStatement(sqlupdate);
                myStmt.executeUpdate();
                tempConn.commit();
                myStmt.close();

            } else {
                String sqlupdate = "update users set password = 'password', status = 1, PASSWORD_EFF_DATE = to_date('01-JAN-2000','DD-MON-YYYY') where userid = '"
                        + user + "'";
                myStmt = tempConn.prepareStatement(sqlupdate);
                myStmt.executeUpdate();
                tempConn.commit();
                myStmt.close();
            }

            String sql = "update users set status = " + intstatus
                    + " where userid = ? ";
            myStmt = tempConn.prepareStatement(sql);
            myStmt.setString(1, user);
            myStmt.executeUpdate();
            tempConn.commit();
            myStmt.close();
        } catch (SQLException se) {
            System.out.println("SQLERROR: " + se.getMessage());
        } finally {
            cleanup(myRs, myStmt, tempConn);
        }
    }

    public void updateDeveloperApproverMapping(String developer,
            String approver, String status) throws DAOException {
        Connection tempConn = null;
        PreparedStatement myStmt = null;
        ResultSet myRs = null;

        try {
            tempConn = getConnection();
            tempConn.setAutoCommit(false);

            if (status.equalsIgnoreCase("disable")) {
                String sql = "delete from developer_approver where developer = ? ";
                sql += " and approver = ?";
                myStmt = tempConn.prepareStatement(sql);
                myStmt.setString(1, developer);
                myStmt.setString(2, approver);
                myStmt.executeUpdate();
                tempConn.commit();
            } else {
                String sql = "insert into developer_approver values (?,?,?) ";
                myStmt = tempConn.prepareStatement(sql);
                myStmt.setString(1, developer);
                myStmt.setString(2, approver);
                myStmt.setString(3, "S");
                myStmt.executeUpdate();
                tempConn.commit();
            }

            myStmt.close();
        } catch (SQLException se) {
            System.out.println("SQLERROR: " + se.getMessage());
        } finally {
            cleanup(myRs, myStmt, tempConn);
        }
    }

    public List<Role> getRoleNotAssignedtoUser(String user, String app) {
        ArrayList<Role> theList = new ArrayList<Role>();
        Connection tempConn = null;
        Statement myStmt = null;
        ResultSet myRs = null;
        if (user == null) {
            return theList;
        }
        try {
            tempConn = getConnection();
            myStmt = tempConn.createStatement();
            String Sql  = "select '"+ user + "' userid, t1.role_name ";
                   Sql += "  from application_roles t1 ";
                   Sql += " where t1.appname = '" + app + "'";
                   Sql += " minus ";
                   Sql += "select '" + user + "', t2.role_name ";
                   Sql += "  from user_roles t2 ";
                   Sql += "  where userid = '" + user + "'";

            myRs = myStmt.executeQuery(Sql);
            while (myRs.next()) {
                Role rl = new Role();
                rl.setRoleName(myRs.getString("role_name"));
                rl.setuserid(myRs.getString("userid"));
                theList.add(rl);
            }
        } catch (SQLException exc) {
            logError(exc);

            // throw new DAOException(exc);
        } finally {
            cleanup(myRs, myStmt, tempConn);
        }
        return theList;
    }
    
    public List<Role> getRolesbyUser(String user, String app) {
        ArrayList<Role> theList = new ArrayList<Role>();
        Connection tempConn = null;
        Statement myStmt = null;
        ResultSet myRs = null;
        if (user == null) {
            return theList;
        }
        try {
            tempConn = getConnection();
            myStmt = tempConn.createStatement();

            String Sql  = " select t1.userid, t1.role_name ";
                   Sql += " from user_roles t1, application_roles t2";
                   Sql += " where t1.userid = '" + user + "' ";
                   Sql += " and t2.role_name = t1.role_name ";
                   Sql += " and t2.appname = '" + app + "'"; 
                   Sql += " order by role_name";

            myRs = myStmt.executeQuery(Sql);
            while (myRs.next()) {
                Role rl = new Role();
                rl.setRoleName(myRs.getString("role_name"));
                rl.setuserid(myRs.getString("userid"));
                theList.add(rl);
            }
        } catch (SQLException exc) {
            logError(exc);

            // throw new DAOException(exc);
        } finally {
            cleanup(myRs, myStmt, tempConn);
        }
        return theList;
    }

    public List<Role> getRoles(String app) {
        ArrayList<Role> theList = new ArrayList<Role>();
        Connection tempConn = null;
        Statement myStmt = null;
        ResultSet myRs = null;
        if (app == null) {
            app = "all";
        }
        try {
            tempConn = getConnection();
            myStmt = tempConn.createStatement();

            String Sql = " select t1.role_name from roles t1, application_roles t2";
            Sql += " where t1.role_name = t2.role_name ";
            if (!app.equalsIgnoreCase("all")) {
                Sql += "   and t2.appname = '" + app + "'";
            }
            Sql += " order by role_name";

            myRs = myStmt.executeQuery(Sql);

            while (myRs.next()) {
                Role rl = new Role();
                rl.setRoleName(myRs.getString("role_name"));
                theList.add(rl);
            }
        } catch (SQLException exc) {
            logError(exc);

            // throw new DAOException(exc);
        } finally {
            cleanup(myRs, myStmt, tempConn);
        }

        return theList;
    }

    public void addUser(String user, String first, String last, String email,
            String role, String user_priority,String phone) throws DAOException {
        Connection tempConn = null;
        PreparedStatement myStmt = null;
        ResultSet myRs = null;

        try {
            tempConn = getConnection();
            tempConn.setAutoCommit(false);

            if (user == null || first == null || last == null || email == null
                    || role == null || phone == null) {
                throw new DAOException("Missing Data");
            }
            if (user.equalsIgnoreCase("") || first.equalsIgnoreCase("")
                    || last.equalsIgnoreCase("") || email.equalsIgnoreCase("")
                    || role.equalsIgnoreCase("") || phone.equalsIgnoreCase("")) {
                throw new DAOException("Missing Data");
            }
            phone = stripNonNumeric(phone);
            if (!(phone.length() == 10)) {
                throw new DAOException("Missing Data");
            }
            String sql = "insert into users"
                    + " (userid, first, last, password, password_eff_date, email_address,status,phone,user_priority)"
                    + " values" + " (?, ?, ?, 'cares123',SYSDATE-365, ?,1,?,?)";

            myStmt = tempConn.prepareStatement(sql);

            // set the parameters
            myStmt.setString(1, user);
            myStmt.setString(2, first);
            myStmt.setString(3, last);
            myStmt.setString(4, email);
            myStmt.setLong(5, Long.parseLong(phone));
            myStmt.setInt(6,Integer.parseInt(user_priority));
            myStmt.executeUpdate();

            sql = "insert into user_roles (userid, role_name) values (?,?)";
            myStmt = tempConn.prepareStatement(sql);
            myStmt.setString(1, user);
            myStmt.setString(2, role);
            myStmt.executeUpdate();
            tempConn.commit();
            myStmt.close();
        } catch (SQLException exc) {
            logError(exc);
            throw new DAOException(exc);
        } finally {
            cleanup(myRs, myStmt, tempConn);
        }
    }

    public void addUserRole(String user, String role) throws DAOException {
        Connection tempConn = null;
        PreparedStatement myStmt = null;
        ResultSet myRs = null;

        try {
            tempConn = getConnection();
            tempConn.setAutoCommit(false);
            String sql = "insert into user_roles (userid, role_name) values (?,?)";
            myStmt = tempConn.prepareStatement(sql);
            myStmt.setString(1, user);
            myStmt.setString(2, role);
            myStmt.executeUpdate();
            tempConn.commit();
            myStmt.close();
        } catch (SQLException exc) {
            logError(exc);
            throw new DAOException(exc);
        } finally {
            cleanup(myRs, myStmt, tempConn);
        }
    }
    public void removeUserRole(String user, String role) throws DAOException {
        Connection tempConn = null;
        PreparedStatement myStmt = null;
        ResultSet myRs = null;

        try {
            tempConn = getConnection();
            tempConn.setAutoCommit(false);
            String sql  = "delete from user_roles ";
                   sql += " where userid = ?";
                   sql += "   and role_name = ?";
                   System.out.println("TEST: " + sql);
                   System.out.println("USER: " + user);
                   System.out.println("ROLE: " + role);
                   
            myStmt = tempConn.prepareStatement(sql);
            myStmt.setString(1, user);
            myStmt.setString(2, role);
            myStmt.executeUpdate();
            tempConn.commit();
            myStmt.close();
        } catch (SQLException exc) {
            logError(exc);
            throw new DAOException(exc);
        } finally {
            cleanup(myRs, myStmt, tempConn);
        }
    }
    
    public static String stripNonNumeric(String s) {
        char[] chars = s.toCharArray();
        StringBuffer sb = new StringBuffer();
        for (int j = 0; j < chars.length; j++) {
            if (Character.isDigit(chars[j]))
                sb.append(chars[j]);
        }
        return sb.toString();
    }

    /**
     * The backend process that expires passwords will set them to 'expired'
     */
    public boolean getPasswordExpired(String userid) {
        Connection tempConn = null;
        Statement myStmt = null;
        ResultSet myRs = null;
        boolean expired = false;

        try {
            tempConn = getConnection();
            myStmt = tempConn.createStatement();

            String Sql = " select * from users usr where usr.password = 'expired' and usr.userid = '"
                    + userid + "'";
            myRs = myStmt.executeQuery(Sql);

            if (myRs.next()) {
                expired = true;
            }
        } catch (SQLException exc) {
            logError(exc);

            // throw new DAOException(exc);
        } finally {
            cleanup(myRs, myStmt, tempConn);
        }

        return expired;
    }

    public boolean isPassWordExpired(String userid) {
        Connection tempConn = null;
        Statement myStmt = null;
        ResultSet myRs = null;
        boolean expired = false;

        if (userid.equalsIgnoreCase("guest")) {
            return false;
        }
        try {
            tempConn = getConnection();
            myStmt = tempConn.createStatement();

            String sql = "select userid from users where userid = '" + userid
                    + "'";
            sql += " and password_eff_date < sysdate - 90";
            myRs = myStmt.executeQuery(sql);

            if (myRs.next()) {
                expired = true;
            }
        } catch (SQLException se) {
        } finally {
            cleanup(myRs, myStmt, tempConn);
        }

        return expired;
    }

    // Status: 1=User didn't enter the correct old password
    // Status: 2=User didn't confirm their new pass
    // Status: 3=User selected a password in their history
    // Status: 4=User selected a password that doesn't match the password
    // criteria
    // Status: 5=SQL Exception thrown during update
    public int changePassword(String userid, String old_pass, String new_pass,
            String conf_new_pass) {
        Connection tempConn = null;
        Statement myStmt = null;
        PreparedStatement updateStmt = null;
        PreparedStatement insertStmt = null;
        ResultSet myRs = null;
        ResultSet myRs2 = null;
        int status = 0;
        String oldpassdb = "";

        try {
            tempConn = getConnection();
            tempConn.setAutoCommit(false);
            
            myStmt = tempConn.createStatement();

            String sql = "select password from users where ";
            sql += (" userid = '" + userid + "'");
            myRs = myStmt.executeQuery(sql);

            if (myRs.next()) {
                oldpassdb = myRs.getString("password");
            }

            String sql2 = "select password from user_password_history where userid = '";
            sql2 += userid + "' and password = '" + new_pass + "'";
            myRs2 = myStmt.executeQuery(sql2);

            if (myRs2.next()) {
                status = 3;
            }
        } catch (SQLException exc) {
            logError(exc);
            status = 5;
        }

        if (!oldpassdb.equals(old_pass)) {
            status = 1;
        }

        else if (!new_pass.equals(conf_new_pass)) {
            status = 2;
        }

        else if (!checkPasswordMask(new_pass)) {
            status = 4;
        }

        // if the status is ok then perform updates
        if (status == 0) {
            String insql = "insert into user_password_history ";
            insql += "(select userid, password,password_eff_date from users where userid = ? )";

            String upsql = "update users set password = ?, password_eff_date = SYSDATE  where userid = ?";

            try {
                insertStmt = tempConn.prepareStatement(insql);
                updateStmt = tempConn.prepareStatement(upsql);
                insertStmt.setString(1, userid);
                updateStmt.setString(1, new_pass);
                updateStmt.setString(2, userid);
                insertStmt.executeUpdate();
                updateStmt.executeUpdate();
                tempConn.commit();
            } catch (SQLException ex) {
                logError(ex);
                System.out.println(ex.getMessage());
                status = 5;
            }
        }

        cleanup(myRs, updateStmt, null);
        cleanup(myRs2, insertStmt, tempConn);
        return status;
    }

    public Developer getUser(String userid) {
        Connection tempConn = null;
        Statement myStmt = null;
        ResultSet myRs = null;
        Developer dev = new Developer();

        try {
            tempConn = getConnection();
            myStmt = tempConn.createStatement();

            String Sql = " select usr.* from users usr where usr.userid = '"
                    + userid + "'";
            myRs = myStmt.executeQuery(Sql);

            if (myRs.next()) {
                dev.setUserId(myRs.getString("userid"));
                dev.setPassword(myRs.getString("password"));
                dev.setFirstName(myRs.getString("first"));
                dev.setLastName(myRs.getString("last"));
                dev.setEmailAddress(myRs.getString("email_address"));
                dev.setUserpriority(Integer.toString(myRs.getInt("user_priority")));
            }
        } catch (SQLException exc) {
            logError(exc);

            // throw new DAOException(exc);
        } finally {
            cleanup(myRs, myStmt, tempConn);
        }

        return dev;
    }

    public List<String> getUnmergedRequests() {
        return null;
    }

    public List<String> getUnbuiltRequests() {
        return null;
    }

    private boolean checkPasswordMask(String password) {
        char[] buffer = password.toCharArray();
        boolean lower = false;
        boolean longenough = false;
        boolean upper = false;
        boolean number = false;
        boolean specialchar = false;

        // Check for aposrophe or double quotes, those chars are not allowed in
        // the password
        if ((password.indexOf("\"") > 0) || (password.indexOf("\'") > 0)) {
            return false;
        }
        for (int i = 0; i < buffer.length; i++) {
            char ch = buffer[i];

            if (Character.isDigit(ch)) {
                number = true;
            }

            if (Character.isUpperCase(ch)) {
                upper = true;
            }

            if (Character.isLowerCase(ch)) {
                lower = true;
            }

            if (!(Character.isLowerCase(ch) || Character.isUpperCase(ch) || Character
                    .isDigit(ch))) {
                specialchar = true;
            }
        }

        if (password.length() > 5) {
            longenough = true;
        }

        return (lower && longenough && upper && number && specialchar);
    }
}
