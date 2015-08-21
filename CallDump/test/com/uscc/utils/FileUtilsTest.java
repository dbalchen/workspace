package com.uscc.utils;

import java.io.File;
import junit.framework.TestCase;

public class FileUtilsTest extends TestCase {
	
	private static FileUtils utils = null;

	public void testGetFiles() {
		System.out.println("testGetFiles");
		utils = new FileUtils();
		File file = new File ("/DOCUME~1/md1dsmi1/LOCALS~1/Temp/craig.dat");
		String tmpdir = System.getProperty("java.io.tmpdir");
		String dir = (tmpdir + "craig.dat");
		System.out.println(dir);
		System.out.println("craig.dat exists?: " + file.exists());
	}
}
