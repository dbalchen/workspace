package com.uscc.monitor;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.DataOutputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;

/**
 * <p>Title: CallProcess</p>
 * <p>Description: The CallProcess class is used to execute a command line
 * process then retuns the executed processes standard output</p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: US Cellular </p>
 * @author David G. Balchen
 * @version 1.0
 * Glenn Lockwood 6/4/10 
 * cleaned up the code; make sure no file handles leak and return all output
 * to the caller that is produced regardless of whether anything is passed
 * to the external process on its stdin. Also removed the catch block
 * since all it did was rethrow. 
 * Caveat Emptor: This is not a robust implementation.
 * It can hang if the external process terminates without closing its files.
 * It will not work properly with all external processes and could hang or deadlock
 * with complex interaction on the 3 files communicating with the external process.
 * A robust implementation involves reading/writing the 3 files files and/or 
 * calling waitFor() in separate threads. This implementation is intended to be
 *  used in the narrow context of the MPSMonitor program
 *
 */
public class CallProcess {
  /** Date File was Last Modified */
  public static final String LASTMODIFIEDDATE =
      "$Date:   14 Jan 2008 09:10:08  $";
  /** Version of this file */
  public static final String LASTMODIFIEDVERSION = "$Revision:   1.1  $";
  /** Last person to modify this file */
  public static final String LASTMODIFIEDBY = "$Author:   md1dsmi1  $";

  /**
   * Runs the executable and returns the output as a String.
   * @param Script -- Program/Script to run.
   * @return -- Executables output.
   */
  public String exec(String Script) throws IOException {
    return exec(Script, null);
  }

  /**
   * Runs the executable passing stdin and returns the output as a String.
   * @param Script -- Program/Script to run.
   * @param stdInput -- String to be sent to the Programs/Scripts stdin.
   * @return -- Executables output.
   */
  public String exec(String Script, String stdInput) throws IOException{
    BufferedReader stdout = null;
    DataOutputStream stdin = null;
    BufferedReader stderr = null;
    String linebuf, retbfr;
    Process proc=null;
    retbfr = "";

    try {
      proc = Runtime.getRuntime().exec(Script);

      if (stdInput != null) {
        java.io.OutputStream is=proc.getOutputStream();
        BufferedOutputStream ib=new  BufferedOutputStream(is);
        stdin=new DataOutputStream(ib);

        stdin.writeBytes(stdInput);
        stdin.flush();
        /* close is needed so the external process gets EOF on its stdin */
        stdin.close();
	stdin=null;
      }
 
      java.io.InputStream os=proc.getInputStream();
      InputStreamReader or=new InputStreamReader(os);
      stdout = new BufferedReader(or);
  
      java.io.InputStream es=proc.getErrorStream();
      InputStreamReader er= new InputStreamReader(es);
      stderr = new BufferedReader(er);

    		  
      while ( ((linebuf = stdout.readLine()) != null) ) {
        retbfr = retbfr + linebuf + "\n";
      }
    		  
      while ( ((linebuf = stderr.readLine()) != null) ) {
        retbfr = retbfr + linebuf + "\n";
      }

      return(retbfr);
    }

    // It is the responsibility of the caller to figure out what to do with exceptions.
    // It is our responsibility to clean up after ourselves.
    // Code in this finally block is guaranteed to execute regardless of whether
    // the try block terminates via an exception or the return statement, so long as
    // any part of the try block executes.

    finally {
        if (proc !=null){
	    if(stdin !=null)
		proc.getOutputStream().close();
	    proc.getInputStream().close();
	    proc.getErrorStream().close(); 
	    proc.destroy();
	    proc=null;  
	}
    }
  }// method
}// class
