package com.uscc.CallDump;

import junit.framework.TestCase;

public class CallDumpSessionTest extends TestCase {
	
	private static CallDumpSession cds = null;
	
	int id = 1065;

	public void testGetCallDumpId() {
		cds = new CallDumpSession(1065);
		int expectedReturn = id;
		int actualReturn = cds.getSessionId();
		assertEquals("return value",expectedReturn, actualReturn);
		System.out.println("expectedReturn = " + expectedReturn);
		System.out.println("actualReturn   = " + actualReturn);		
	}
}
