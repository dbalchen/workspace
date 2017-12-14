package com.uscc.CallDump;

import java.io.IOException;
import junit.framework.TestCase;

public class LogWriterTest extends TestCase {
	
	private static LogWriter log = null;

	public void testPrintln() throws IOException {
		log = new LogWriter("log/", "LogWriterTestPrintln.log");
		log.println("hello");
	}

	public void testPrint() throws IOException {
		log = new LogWriter("log/", "LogWriterTestPrint.log");
		log.println("goodbye");
	}
}
