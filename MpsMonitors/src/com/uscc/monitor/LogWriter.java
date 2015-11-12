
/*
 *  @LogWriter.java
 */

/*******************************************************************************
 * Authors     : MPS Team
 * Date        : January 10, 2002.
 * -----------------------------------------------------------------------------
 * Revision(s) :
 * -----------------------------------------------------------------------------
 * 1) Cleaned up the module and implemented all new style formatting.  Also
 *    added Exception handling.
 *    - Craig J. Stalsberg - Mon Mar 11 11:18:11 CST 2002
 * 2) Added Comments.
 *    - Craig J. Stalsberg - Fri Apr 26 11:02:13 CDT 2002
 *
 * ################# Version 2.40 ############################################
 * 3) Removed all unecessary inport statements.
 *    - Craig J. Stalsberg - Tue Jul  2 07:58:14 CDT 2002
 *
 * ################# Version 2.50 ############################################
 * 4) Added class fields to access RCS keyword variables.
 *    - Jacob Ray - Tue Oct  8 10:32:28 CDT 2002
 *
 * ################# Version 2.60 ############################################
 * 5) Added println_nodatetime method to be able to print something to the
 *    log without the time stamp.
 *    - Craig J. Stalsberg - Wed Apr  2 09:58:04 CST 2003
 ******************************************************************************/
package com.uscc.monitor;

import java.util.Calendar;
import java.util.Date;
import java.io.PrintWriter;
import java.io.FileWriter;
import java.io.File;
import java.io.IOException;

/**
 * This class will implement a log file. Entries written to this file via
 * println will contain
 * the date and time that the message was submitted to the file.
 */
public class LogWriter {
    // Static Members

    public static final String LASTMODIFIEDDATE = "$Date:   14 Jan 2008 09:10:10  $";
    public static final String LASTMODIFIEDVERSION = "$Revision:   1.1  $";
    public static final String LASTMODIFIEDBY = "$Author:   md1dsmi1  $";
    public static final String SOURCETAG = "$Name: v26_0 $";

    // Log to Write Entries
    protected PrintWriter log = null;

    /** Get a reference tot he log writer
     * @return      Reference to the PrintWriter for this log
     */
    public PrintWriter getPrintWriter() {
        return (PrintWriter) log;
    }

    /** Create New Instance of a log file
     * @param  dir     Directory to create the log file in
     * @param  name    FileName for the log file
     * @exception java.io.IOException
     *            if the file cannot be created
     */
    public LogWriter(String dir, String name) throws IOException {
        // Open the PrinterWriter Object
        log = OpenLogFile(dir, name);

        // Write the Start Time to the Log file
        log.println("Log file has been open on :");
        log.println(new Date().toString() + "\n\n");
    }

    /** Empty Constructor
     * @exception java.io.IOException
     */
    public LogWriter() throws IOException {}

    /** Close the LogWriter */
    public void close() {
        log.close();
    }

    /** Write a String to the Log File
     * @param   Out    String to Write to Log File
     */
    public void  println(String Out) {
        log.println(GetTimeStamp() + Out);
    }
    public void  print(String Out) {
        log.print(GetTimeStamp() + Out);
    }
    public void  println_nodatetime(String Out) {
        log.println(Out);
    }

    /** Write a string to the Error Log
     * @param  Out    String to Write to Log File
     */
    public void  printerr(String Out) {
        println(Out);
    }

    private String GetTimeStamp() {
        String timestring;

        Calendar CAL = Calendar.getInstance();

        // Build a string with the date and time
        timestring = PadStringBefore(
                Integer.toString(CAL.get(Calendar.HOUR_OF_DAY)), 2, "0") + ":" +
                PadStringBefore(Integer.toString(CAL.get(Calendar.MINUTE)), 2, "0") + ":" +
                PadStringBefore(Integer.toString(CAL.get(Calendar.SECOND)), 2, "0") + "  " +
                PadStringBefore(Integer.toString(CAL.get(Calendar.MONTH) + 1), 2, "0") + "/" +
                PadStringBefore(Integer.toString(CAL.get(Calendar.DATE)), 2, "0") + "/" +
                Integer.toString(CAL.get(Calendar.YEAR)) + "> ";
        return timestring;

    }
    // Open the Log file (PrintWriter)
    private PrintWriter OpenLogFile(String dir, String name) throws IOException {
        PrintWriter tmplog = null;

        new File (dir).mkdirs();
        tmplog = new PrintWriter(new FileWriter(dir + name), true);
        return tmplog;
    }

    /** Pad a string with another string before the current string
 * @param   string2pad    String to Pad
 * @param   tosize        Length of Padded String
 * @param   padwith       String to Pad Input String with
 * @return                Padded String
 */
private String PadStringBefore(String string2pad, int tosize, String padwith) {
    for (int a = string2pad.length(); a < tosize; a++) {
        string2pad = padwith + string2pad;

    }
    return string2pad;
}

}
