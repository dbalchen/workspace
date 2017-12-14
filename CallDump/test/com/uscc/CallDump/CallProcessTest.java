package com.uscc.CallDump;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import junit.framework.TestCase;

public class CallProcessTest extends TestCase {
	
	private static CallProcess cp = null;
	private String exec1 = "dir";
	private String exec2 = "LESS";
	private String buff = "";
	private String buffer = "";
	
	public void testExecString() {
		cp = new CallProcess();
		try {
			String output = cp.exec(exec1);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void testExecStringString() throws IOException {
		BufferedReader br = new BufferedReader(new FileReader("log\\CallDump.20071114105500.log"));
	    while ((buffer = br.readLine()) != null) {
	    	buff = buff + buffer + "\n";
	    }
		cp = new CallProcess();
		try {
			String output = cp.exec(exec2, buff);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}