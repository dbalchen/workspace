/*
 * Created on Apr 19, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.uscc.monitor;

import java.io.IOException;

import junit.framework.TestCase;

/**
 * @author dbalchen
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class CallProcessTest extends TestCase {

	/*
	 * @see TestCase#setUp()
	 */
	protected void setUp() throws Exception {
		super.setUp();
	}

	/*
	 * @see TestCase#tearDown()
	 */
	protected void tearDown() throws Exception {
		super.tearDown();
	}

	/**
	 * Constructor for CallProcessTest.
	 * @param arg0
	 */
	public CallProcessTest(String arg0) {
		super(arg0);
	}

	/*
	 * Class under test for String exec(String)
	 */
	public final void testExecString() throws IOException {
		//TODO Implement exec().
		CallProcess cp = new CallProcess();

		System.out.println(cp.exec("dir"));

	}


}
