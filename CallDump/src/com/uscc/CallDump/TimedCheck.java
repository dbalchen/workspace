package com.uscc.CallDump;
/**
 *
 * <p>Title: TimedCheck</p>
 * <p>Description: Interface used in all the timed threads.</p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: US Cellular</p>
 * @author David Balchen
 * @version 1.0
 */
public interface TimedCheck {
	/**
	 * The Threads run method.
	 */
	public abstract void start();

	/**
	 * Gets the information of the last timed run.
	 * @return String
	 */
	public abstract String getInfo();
}