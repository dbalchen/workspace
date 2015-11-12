package com.uscc.monitor;

import java.io.IOException;
import junit.framework.TestCase;

public class LogWriterTest extends TestCase {
	
	public void testLogWriter() throws IOException {
		
		LogWriter LOG = null;
	    LOG = new LogWriter("", "LogWriterTest.log");
	    LOG.println("hello");
	    LOG.println("goodbye");
	    
	}
}
