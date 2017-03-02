package com.uscc.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;
import com.uscc.CallDump.CallDumpManager;
import com.uscc.CallDump.XMLdomReader;
import com.uscc.beans.Developer;
import com.uscc.beans.Role;
import com.uscc.beans.User;

import junit.framework.TestCase;

public class UserDAOTest extends TestCase {
	
	private UserDAO dao = null;
	private static CallDumpManager cdm = null;
	String markets = "m01";
	String ids = "0";
	int pid = 0;
	int numberOfSeconds = 30;
	int numberOfThreads = 0;
	int x = 0;
	
	private Connection getConnection() throws SQLException {
		XMLdomReader xml = new XMLdomReader("calldump/config/calldump.xml");
		try {
			cdm = new CallDumpManager(xml);
			numberOfThreads = Integer.parseInt((String) xml.getTagValue("threads"));
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		cdm.start();
		try {
			Thread.sleep(numberOfSeconds * 1000);
		} catch (InterruptedException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			Class.forName(xml.getTagValue("dbdriver"));
			return (Connection) DriverManager.getConnection(xml
					.getTagValue("dburl"), xml.getTagValue("dbuser"), xml
					.getTagValue("dbpass"));
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public void testGetAllUsers() {
		Connection conn = null;
		try {
			conn = getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		dao = new UserDAO(conn);
		
		List <Developer> users = dao.getAllUsers("calldump");
		assertTrue("Actual Value: " + users.size(), users.size()==138);
		System.out.println("testGetAllUser - calldump");
		int a = 0;
		System.out.println("Actual Value = " + users.size());
		while (( a < users.size()) && ( a < 5 )) {
			System.out.println(users.get(a).userid);
			a++;
		}
		System.out.println("\n");	
	}

	public void testGetUsers() {
		Connection conn = null;
		try {
			conn = getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		dao = new UserDAO(conn);
		
		List <User> users = dao.getUsers();
		assertTrue("Actual Value: " + dao.getUsers(), users.size()==138);
		System.out.println("testGetUsers");
		int a = 0;
		System.out.println("Actual Value = " + users.size());
		while (( a < users.size()) && ( a < 5 )) {
			System.out.println(users.get(a).user_name);
			a++;
		}
		System.out.println("\n");
	}

	public void testGetUser() {
		Connection conn = null;
		try {
			conn = getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		dao = new UserDAO(conn);
		
		List <User> users = dao.getUsers();
		assertTrue("Actual Value: " + dao.getUsers(), users.size()==138);
		System.out.println("testGetUser");
		int a = 0;
		System.out.println("Actual Value = " + users.size());
		while (( a < users.size()) && ( a < 5 )) {
			System.out.println(users.get(a).user_name);
			a++;
		}
		System.out.println("\n");
	}	
	
	public void testGetApproversString() {
		Connection conn = null;
		try {
			conn = getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		dao = new UserDAO(conn);
		
		List <Developer> users = dao.getApprovers("md1dbal1");
		assertTrue("Actual Value: " + users.size(), users.size()==2);
		System.out.println("testGetApproversString - md1dbal1");
		int a = 0;
		System.out.println("Actual Value = " + users.size());
		while (( a < users.size()) && ( a < 5 )) {
			System.out.print(users.get(a).firstname); System.out.print(" "); System.out.println(users.get(a).lastname);
			a++;
		}
		System.out.println("\n");
	}

	public void testGetApprovers() {
		Connection conn = null;
		try {
			conn = getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		dao = new UserDAO(conn);
		
		List <Developer> users = dao.getApprovers();
		assertTrue("Actual Value: " + users.size(), users.size()==16);
		System.out.println("testGetApprovers");
		int a = 0;
		System.out.println("Actual Value = " + users.size());
		while (( a < users.size()) && ( a < 5 )) {
			System.out.print(users.get(a).firstname); System.out.print(" "); System.out.println(users.get(a).lastname);
			a++;
		}
		System.out.println("\n");
	}
	
	public void testGetDevelopers() {
		Connection conn = null;
		try {
			conn = getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		dao = new UserDAO(conn);

		List <Developer> users = dao.getDevelopers();
		assertTrue("Actual Value: " + users.size(), users.size()==62);
		System.out.println("testGetDevelopers");
		int a = 0;
		System.out.println("Actual Value = " + users.size());
		while (( a < users.size()) && ( a < 5 )) {
			System.out.println(users.get(a).userid);
			a++;
		}
		System.out.println("\n");
	}

	public void testGetRoleNotAssignedtoUser() {
		Connection conn = null;
		try {
			conn = getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		dao = new UserDAO(conn);
		
		List <Role> users = dao.getRoleNotAssignedtoUser("md1dsmi1", "calldump");
		assertTrue("Actual Value: " + users.size(), users.size()==2);
		System.out.println("testGetRoleNotAssignedtoUser - md1dsmi1, calldump");
		int a = 0;
		System.out.println("Actual Value = " + users.size());
		while (( a < users.size()) && ( a < 5 )) {
			System.out.print(users.get(a).userid); System.out.print(", "); System.out.println(users.get(a).role_name);
			a++;
		}
		System.out.println("\n");
	}

	public void testGetRolesbyUser() {
		Connection conn = null;
		try {
			conn = getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		dao = new UserDAO(conn);

		List <Role> users = dao.getRolesbyUser("md1dsmi1", "calldump");
		assertTrue("Actual Value: " + users.size(), users.size()==1);
		System.out.println("testGetRolesbyUser - md1dsmi1, calldump");
		int a = 0;
		System.out.println("Actual Value = " + users.size());
		while (( a < users.size()) && ( a < 5 )) {
			System.out.print(users.get(a).userid); System.out.print(", "); System.out.println(users.get(a).role_name);
			a++;
		}
		System.out.println("\n");
	}

	public void testGetRoles() {
		Connection conn = null;
		try {
			conn = getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		dao = new UserDAO(conn);

		List <Role> users = dao.getRoles("calldump");
		assertTrue("Actual Value: " + users.size(), users.size()==3);
		System.out.println("testGetRoles - calldump");
		int a = 0;
		System.out.println("Actual Value = " + users.size());
		while (( a < users.size()) && ( a < 5 )) {
			System.out.println(users.get(a).role_name);
			a++;
		}
		System.out.println("\n");
	}
}
