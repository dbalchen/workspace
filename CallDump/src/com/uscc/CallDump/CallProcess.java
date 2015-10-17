package com.uscc.CallDump;

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
 */
public class CallProcess {
  /** Date File was Last Modified */
  public static final String LASTMODIFIEDDATE =
      "$Date: 2007/04/23 19:10:01 $";
  /** Version of this file */
  public static final String LASTMODIFIEDVERSION = "$Revision: 1.1 $";
  /** Last person to modify this file */
  public static final String LASTMODIFIEDBY = "$Author: rbwrk1 $";

  /**
   * Runs the executable and returns the output as a String.
   * @param Script -- Program/Script to run.
   * @return -- Executables output.
   */

  public String exec(String Script) throws IOException {
    return exec(Script, null);
  }

  /**
   * Runs the executable passing STDIN and returns the output as a String.
   * @param Script -- Program/Script to run.
   * @param stdInput -- String to be sent to the Programs/Scripts STDIN.
   * @return -- Executables output.
   */
  public String exec(String Script, String stdInput) throws IOException{
	BufferedReader STDOUT;
    DataOutputStream STDIN;

    String buffer, buff;

    buff = "";

    try {
      Process PROC = Runtime.getRuntime().exec(Script);
      //      System.out.println("Running Script --> " + Script);

      if (stdInput != null) {
        STDIN = new DataOutputStream(new BufferedOutputStream(PROC
            .getOutputStream()));

        STDIN.writeBytes(stdInput);
        STDIN.flush();
        STDIN.close();
      }

      STDOUT = new BufferedReader(new InputStreamReader(PROC
    		  .getInputStream()));
    		  
      while ( ((buffer = STDOUT.readLine()) != null) && (stdInput == null)) {
        buff = buff + buffer + "\n";
      }
      STDOUT.close();
    }
    catch (java.io.IOException e) {
      System.out.println("Cannot execute process --: " + Script);
      e.printStackTrace();
      throw new java.io.IOException();      
     
    }
    return buff;
  }
}