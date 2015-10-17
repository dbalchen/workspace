package com.uscc.CallDump;

import java.util.Hashtable;
import java.util.Vector;
import junit.framework.TestCase;

public class XMLdomReaderTest extends TestCase {
	
	private static XMLdomReader xml = null;

	public void testXMLdomReaderString() {
		XMLdomReader xml = new XMLdomReader("config/calldump.xml");
		System.out.println("testXMLdomReaderString - calldump.xml");
		System.out.println("machine   : " + xml.getTagValue("machine"));
		System.out.println("serverport: " + xml.getTagValue("serverport"));
		System.out.println("path      : " + xml.getTagValue("path"));
		System.out.println("\n");
	}

	public void testXMLdomReader() {
		XMLdomReader xml = new XMLdomReader("config/calldumpb.xml");
		System.out.println("testXMLdomReader - calldumpb.xml");
		System.out.println("machine   : " + xml.getTagValue("machine"));
		System.out.println("serverport: " + xml.getTagValue("serverport"));
		System.out.println("path      : " + xml.getTagValue("path"));
		System.out.println("\n");
	}

	public void testGetSubTreeStringIntString() throws Exception {
		XMLdomReader xml = new XMLdomReader("config/calldump.xml");

		String tag = "database";
		int ListItem = 0;
		String target = null;
		int a = 0;
		
		Vector<Hashtable<String, String>> Vec = xml.getSubTree(tag, ListItem, target);

		assertTrue("Actual Value: " + Vec.size(), Vec.size()==5);
		System.out.println("testGetSubTreeStringIntString");
		System.out.println("Actual Value = " + Vec.size());
		
		while (( a < Vec.size()) && ( a < 5 )) {
			System.out.println(Vec.get(a).toString());
			a++;
		}
		System.out.println("\n");
	}

	public void testGetSubTreeStringInt() throws Exception {
		XMLdomReader xml = new XMLdomReader("config/calldump.xml");

		String tag = "manager";
		int ListItem = 0;
		int a = 0;
		
		Vector<Hashtable<String, String>> Vec = xml.getSubTree(tag, ListItem);

		assertTrue("Actual Value: " + Vec.size(), Vec.size()==4);
		System.out.println("testGetSubTreeStringInt");
		System.out.println("Actual Value = " + Vec.size());
		
		while (( a < Vec.size()) && ( a < 5 )) {
			System.out.println(Vec.get(a).toString());
			a++;
		}
		System.out.println("\n");
	}

	public void testGetTags() throws Exception {
		XMLdomReader xml = new XMLdomReader("config/calldump.xml");

		String startTag = "timedprocess";
		String target = null;
		int a = 0;
		
		Vector<Hashtable<String, String>> Vec = xml.getTags(startTag, target);

		assertTrue("Actual Value: " + Vec.size(), Vec.size()==17);
		System.out.println("testGetTags");
		System.out.println("Actual Value = " + Vec.size());
		
		while (( a < Vec.size()) && ( a < 5 )) {
			System.out.println(Vec.get(a).toString());
			a++;
		}
		System.out.println("\n");
	}

	public void testGetSubTreeString() throws Exception {
		XMLdomReader xml = new XMLdomReader("config/calldump.xml");

		String tag = "server";
		int a = 0;
		
		Vector<Hashtable<String, String>> Vec = xml.getSubTree(tag);

		assertTrue("Actual Value: " + Vec.size(), Vec.size()==4);
		System.out.println("testGetSubTreeString");
		System.out.println("Actual Value = " + Vec.size());
		
		while (( a < Vec.size()) && ( a < 5 )) {
			System.out.println(Vec.get(a).toString());
			a++;
		}
		System.out.println("\n");
	}

	public void testGetAllTagValue() {
		XMLdomReader xml = new XMLdomReader("config/calldump.xml");

//		String tag = "from";
		String tag = "to";		
		int a = 0;
		
		Vector<String> Vec = xml.getAllTagValue(tag);

		assertTrue("Actual Value: " + Vec.size(), Vec.size()==3);
		System.out.println("testGetAllTagValue");
		System.out.println("Actual Value = " + Vec.size());
		while (( a < Vec.size()) && ( a < 5 )) {
			System.out.println("Vec.get(a).toString = " + Vec.get(a).toString());
			System.out.println("Vec.get(a).length   = " + Vec.get(a).length());
			System.out.println("Vec.get(a).hashCode = " + Vec.get(a).hashCode());
			a++;
		}
		System.out.println("\n");
	}

	public void testGetChildTags() throws Exception {
		XMLdomReader xml = new XMLdomReader("config/calldump.xml");

		String tag = "database";
		int childnum = 1;
		int a = 0;
		
		Vector<Hashtable<String, String>> Vec = xml.getChildTags(tag, childnum);

		assertTrue("Actual Value: " + Vec.size(), Vec.size()==4);
		System.out.println("testGetChildTags");
		System.out.println("Actual Value = " + Vec.size());
		while (( a < Vec.size()) && ( a < 5 )) {
			System.out.println("Vec.get(a).toString = " + Vec.get(a).toString());
			a++;
		}
		System.out.println("\n");
	}
}
