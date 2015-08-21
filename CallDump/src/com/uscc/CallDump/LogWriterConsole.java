/*
 *  @LogWriterConsole.java
 */

/****************************************************************************************************************
 * Authors     : MPS Team
 * Date        : January 10, 2002.
 * --------------------------------------------------------------------------------------------------------------
 * Revision(s) :
 * --------------------------------------------------------------------------------------------------------------
 * 1) cloned from LogWriterNull
 *         Glenn Lockwood
**************************************************************/
package com.uscc.CallDump;

import java.io.PrintWriter;
import java.io.IOException;

/** 
  * SubClass of LogWriter that pushes a PrintWriter down over
  * the System buffered console PrintStream "out"
  */
public class LogWriterConsole extends LogWriter
{
    // Static Members

    public static final String LASTMODIFIEDDATE = "$Date:   10 Jun 2004 20:43:02  $";
    public static final String LASTMODIFIEDVERSION = "$Revision:   1.0.1.1  $";
    public static final String LASTMODIFIEDBY = "$Author:   pvcs  $";
    public static final String SOURCETAG = "$Name$";

    public PrintWriter getPrintWriter() {
	return log;
    }

   public LogWriterConsole(String dir, String name) throws IOException {
       log=new PrintWriter(System.out);
   }

   public LogWriterConsole()throws IOException {
       log=new PrintWriter(System.out);
   }


}
