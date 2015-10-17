package com.uscc.utils;

import junit.framework.TestCase;
import java.util.ArrayList;
import java.io.File;

import com.uscc.beans.CallDumpReport;

public class testFileUtils extends TestCase { 
  private FileUtils utils = null;

  public void setUp() {
      utils = new FileUtils();
  }
  public void testRetrieve() {
      File file = new File ("/tmp/craig.dat");
      if (file.exists()) {
          file.delete();
      }
      CallDumpReport rpt = new CallDumpReport();
      rpt.setHost("knx1scd1");
      rpt.setFile("/users/calldmp5/unittest/craig.dat");
      ArrayList<CallDumpReport> theList = new ArrayList<CallDumpReport>();
      theList.add(rpt);
      String tmpdir = System.getProperty("java.io.tmpdir");
      String [] files = utils.getFiles(theList, tmpdir);
      assertTrue(files.length==1);
      File file2 = new File (tmpdir + System.getProperty("file.separator") + "craig.dat");
      assertTrue(file2.getPath(), file2.exists());
      file2.delete();
  }
}
