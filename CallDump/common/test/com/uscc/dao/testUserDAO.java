/*******************************************************************************
 * Authors      : MPS
 * Date Written : Date
 * -----------------------------------------------------------------------------
 * Revision(s) :
 * -----------------------------------------------------------------------------
 * ################# Version 2.80 ##############################################
 * 1) Initial Revision.
 *    - Craig J. Stalsberg - 3/18/2004
 ******************************************************************************/

package com.uscc.dao;

import junit.framework.TestCase;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;
import java.util.Iterator;

import com.uscc.beans.*;

public class testUserDAO extends TestCase {

    /** Date File was Last Modified */
    public static final String LASTMODIFIEDDATE = "$Date:   03 Jul 2005 09:54:36  $";

    /** Version of this file */
    public static final String LASTMODIFIEDVERSION = "$Revision:   1.0  $";

    /** Last person to modify this file */
    public static final String LASTMODIFIEDBY = "$Author:   md1csta1  $";

    private Connection con = null;

    private UserDAO dao = null;

    /**
     * Open connection to database
     */
    public void setUp() {
        getConnection();
        dao = new UserDAO(con);
    }

    /**
     * Close database connection
     */
    public void tearDown() {
        closeConnection();
    }

    public void testStripNumerics() {
        assertTrue((UserDAO.stripNonNumeric("1.2.3.4.5.6.7.8.9")).equalsIgnoreCase("123456789"));
        assertTrue((UserDAO.stripNonNumeric("1/2/3/4/5/6/7/8/9")).equalsIgnoreCase("123456789"));
        assertTrue((UserDAO.stripNonNumeric("1-2-3-4-5-6-7-8-9")).equalsIgnoreCase("123456789"));
        assertTrue((UserDAO.stripNonNumeric("(123)456-789")).equalsIgnoreCase("123456789"));
    }
    
    public void testEmptyAddUser() {

        try {
            dao.addUser(null, null, null, null, null, null, null);
            assertTrue(false);
        } catch (DAOException e) {
            assertTrue(e.getMessage().equalsIgnoreCase("Missing Data"));
        }

    }
    public void testEmptyAddUser2() {

        try {
            dao.addUser("", "", "", "", "", "", "");
            assertTrue(false);
        } catch (DAOException e) {
            assertTrue(e.getMessage().equalsIgnoreCase("Missing Data"));
        }

    }
    public void testInvalidUserData() {

        try {
            dao.addUser("md1csta4", "Craig", "Stalsberg", "craig.stalsberg@uscellular.com", "developer", "0", "11111111111");
            assertTrue(false);
        } catch (DAOException e) {
            assertTrue(e.getMessage().equalsIgnoreCase("Missing Data"));
        }

    }
    public void testInvalidUserData2() {

        try {
            dao.addUser("md1csta4", "Craig", "Stalsberg", "craig.stalsberg@uscellular.com", "developer", "0", "11111");
            assertTrue(false);
        } catch (DAOException e) {
            assertTrue(e.getMessage().equalsIgnoreCase("Missing Data"));
        }

    }
    public void testAddDuplicateUser() {

        try {
            dao.addUser("md1csta1", "Craig", "Stalsberg", "craig.stalsberg@uscellular.com", "developer", "0", "6084414488");
            assertTrue(false);
        } catch (DAOException e) {
            assertFalse(e.getMessage().equalsIgnoreCase("Missing Data"));
        }
    }
    public void testAddNewUser() {

        try {
            dao.addUser("xxxxxxxx", "Craig", "Stalsberg", "craig.stalsberg@uscellular.com", "developer", "0", "6.0.8.4....4..1..44...88");
            assertTrue(true);
            Developer newuser = dao.getUser("xxxxxxxx");
            assertTrue(newuser.getUserId().equalsIgnoreCase("xxxxxxxx"));
            assertTrue(newuser.getFirstName().equalsIgnoreCase("Craig"));
            assertTrue(newuser.getLastName().equalsIgnoreCase("Stalsberg"));
            assertTrue(newuser.getEmailAddress().equalsIgnoreCase("craig.stalsberg@uscellular.com"));
        } catch (DAOException e) {
            assertFalse(true);
        }
    }

    public void testgetDevelopers() {
        List<Developer> devs = dao.getDevelopers();
        Iterator<Developer> it = devs.iterator();
        assertTrue(devs.size() == 3);
        Developer dev1 = (Developer) it.next();
        Developer dev2 = (Developer) it.next();
        Developer dev3 = (Developer) it.next();
        assertTrue("Developer 1 should be md1csta1", dev1.getUserId().equals(
                "md1csta1"));
        assertTrue("Developer 2 should be md1dbal1", dev2.getUserId().equals(
                "md1dbal1"));
        assertTrue("Developer 3 should be md1rtom1", dev3.getUserId().equals(
                "md1rtom1"));
    }

    public void testgetRoles() {
        List<Role> roles = dao.getRoles("all");
        assertTrue("Actual Value is: " + roles.size(), roles.size() == 10);
        List<Role> roles2 = dao.getRoles("calldump");
        assertTrue("Actual Value is: " + roles2.size(), roles2.size() == 4);
        List<Role> roles3 = dao.getRoles("dsbms");
        assertTrue("Actual Value is: " + roles3.size(), roles3.size() == 6);

    }
    public void testUpdateSuperUser() {
        try {
            dao.updateStatus("root", "Active");
            Developer user = dao.getUser("root");
            assertFalse(user.getPassword().startsWith("SUSPENDED"));
        } catch (DAOException e) {
            assertTrue(false);
            e.printStackTrace();
        }
        
    }
    public void testUpdateRegularUser() {
        try {
            dao.updateStatus("md1csta1", "Active");
            Developer user = dao.getUser("md1csta1");
            assertTrue(user.getPassword().startsWith("SUSPENDED"));
            dao.updateStatus("md1csta1", "InActive");
            Developer user2 = dao.getUser("md1csta1");
            assertTrue(user2.getPassword().startsWith("password"));
            dao.updateStatus("md1csta1", "Active");
            Developer user3 = dao.getUser("md1csta1");
            assertTrue(user3.getPassword().startsWith("SUSPENDED"));
        } catch (DAOException e) {
            assertTrue(false);
            e.printStackTrace();
        }
        
    }
    public void testgetAllUsers() {
        List<Developer> users = dao.getAllUsers("calldump");
        assertTrue("Actual Value: " + users.size(), users.size()==6);

    }
//    public void testgetRolesbyUser() {
//        List roles = dao.getRolesbyUser("md1csta1");
//        assertTrue(roles.size()==2);
//        String role1 = (String) roles.get(0);
//        String role2 = (String) roles.get(1);
//        assertTrue(role1.equalsIgnoreCase("developers"));
//        assertTrue(role2.equalsIgnoreCase("submitter"));
//    }
    private void getConnection() {
        try {
            Class.forName(System.getProperty("DBDRIVER"));
            String url = "jdbc:oracle:thin:@" + System.getProperty("HOST")
                    + ":" + System.getProperty("PORT") + ":"
                    + System.getProperty("SID");
            String user = System.getProperty("DBUSER");
            String pass = System.getProperty("DBPASS");
            con = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException e) {
            System.out.println("Unable to load Driver Class");
            e.printStackTrace(System.out);
            assertTrue(false);
        } catch (SQLException se) {
            System.out.println("SQL Exeption: " + se.getMessage());
            se.printStackTrace(System.out);
            assertTrue(false);
        }
    }

    private void closeConnection() {
        try {
            con.close();
        } catch (SQLException se) {
            return;
        }
    }

}
