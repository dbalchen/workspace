package com.uscc.monitor;

import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.IOException;
import java.net.Socket;
import java.net.ServerSocket;
import java.util.Vector;
import java.util.Hashtable;

/**
 *
 * <p>
 * <b>Title: </b> MpsMonitor
 * </p>
 * <p>
 * <b>Description: </b> * The Collecter class handles all client server communication. Plus manages all
 * the audit/Checks and dialing operations.
 * </p>
 * <p>
 * <b>Copyright: </b> Copyright (c) 2005
 * </p>
 * <p>
 * <b>Company: </b> US Cellular
 * </p>
 *
 * @author David Balchen
 * @version 2.0
 */

public class MpsMonitor {

  /** Date File was Last Modified */
  public static final String LASTMODIFIEDDATE =
      "$Date:   14 Jan 2008 09:10:10  $";
  /** Version of this file */
  public static final String LASTMODIFIEDVERSION = "$Revision:   1.1  $";
  /** Last person to modify this file */
  public static final String LASTMODIFIEDBY = "$Author:   md1dsmi1  $";

  private static int port;

  private static boolean flag = true;

  /**
   * The main method of the Monitor.
   * <li> Gets the Market and the XML file name from the command line.</li>
   * <li> Parses the XML file</li>
   * <li> Creates the MarketInformation Class</li>
   * <li> Creates a Dialer class thread which handles calling the oncall person.</li>
   * <li> Waits in a loop for a network connection.</li>
   * <li> Once a connection is received, it starts a MonitorConnect thread
   * that handles all interaction between the client an server. </li>
   */

  public MpsMonitor(String market, String xml_file) {

    XMLReader xml = new XMLReader(xml_file);

    try {

      Vector<Hashtable<String, String>> ConfigVec = xml.getSubTree(market);
      port = Integer.parseInt( ( (Hashtable<String, String>) ConfigVec
                                         .elementAt(0)).get("port"));

      String StartHour =  ( (Hashtable<String, String>) ConfigVec
                                   .elementAt(0)).get("StartHour");

      ServerSocket s = new ServerSocket(port);
      System.out.println("port number = " + port + "\n");

      System.out.println("Starting the audit load\n\n");
       MarketInformation mi = new MarketInformation(ConfigVec);
      mi.start();

      Vector<Hashtable<String, String>> genVec = xml.getSubTree("general");
      System.out.println("Starting the Dialer load\n\n");
      Dialer di = new Dialer(ConfigVec, genVec, mi, StartHour);
      di.start();

      System.out.println("Mps Monitor Server Has Started!!!!");

      while (flag) {
        // Blocks until a connection occurs:

        Socket socket = s.accept();

        new MonitorConnect(socket, mi);
      }
      s.close();
    }
    catch (Exception e) {
      e.printStackTrace();
      System.exit(2);
    }
  }

  public void setFlag(boolean set) {
    flag = set;
  }

  private void exitMpsMonitor() {
    System.exit(0);
  }

  /**
   *
   * <p>
   * Title: MonitorConnect
   * </p>
   * <p>
   * Description: When a connection is made this class is created to handle
   * all client interaction.
   * </p>
   * <p>
   * Copyright: Copyright (c) 2005
   * </p>
   * <p>
   * Company: US Cellular
   * </p>
   *
   * @author David Balchen
   * @version 2.0
   */
  private class MonitorConnect
      extends Thread {
    private Socket socket;

    private MarketInformation SysInfo;

    private BufferedReader in;

    private PrintWriter out;

    private String Introduction = "Howdy from the MPS Monitor";

    /**
     * MonitorConnect constructor.
     *
     * @param s
     *            Network Socket
     * @param si
     *            An instance of the MarketInformation class.
     */
    public MonitorConnect(Socket s, MarketInformation si) {
      socket = s;
      SysInfo = si;

      try {

        in = new BufferedReader(new InputStreamReader(socket
            .getInputStream()));

        out = new PrintWriter(new BufferedWriter(
            new OutputStreamWriter(socket.getOutputStream())), true);

      }
      catch (IOException e) {
        e.printStackTrace();
      }

      start(); // Calls run()
    }

    /**
     * Threads run method.
     */
    public void run() {
      String SocString;

      try {
        out.println(Introduction);

        SocString = in.readLine();

        if (SocString.equalsIgnoreCase("stop")) {
          setFlag(false);
          exitMpsMonitor();
        }
        else {
          SysInfo.GetSysInfo(SocString.trim(), out);
        }
        
        socket.close();
        in.close();
        out.close();

      }
      catch (Exception e) {
        System.out.println("Not a valid Request");
        e.printStackTrace();
        try {
          socket.close();
          in.close();
          out.close();

        }
        catch (Exception f) {
          f.printStackTrace();
        }
      }
    }
  }

  /**
   * MpsMonitors main method.
   * @param args -- command line arguments.
   */
  public static void main(String args[]) {
    MpsMonitor mon = new MpsMonitor(args[0], args[1]);

  }

}