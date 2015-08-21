package com.uscc.CallDump;

import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.IOException;
import java.net.Socket;
import java.net.ServerSocket;
import java.util.Vector;
/**
* <p> CallDumpServer.java </p> 
* <p> The CallDumpServer class is the starting class for the CallDump process. It's main job is read the configuration
* XML file and pass it to the CallDumpManager class. Wants thats complete it goes into a loop waiting for a network
* connection where a client process can interact with the system. Some of things a client can do is find the status,
* kill processes and stop everything.</p>
* @author MPS
* @version 1.0
*/
public class CallDumpServer {

	private static boolean flag = true;

	private static int port;

	private XMLdomReader xml;

	private CallDumpManager cdm = null;
	
	public CallDumpServer(String xmlfile) {

		xml = new XMLdomReader(xmlfile);

		try {
			port = Integer.parseInt(xml.getTagValue("serverport"));

			ServerSocket s = new ServerSocket(port);
			System.out.println("port number = " + port + "\n");
			
			cdm = new CallDumpManager(xml);
			cdm.start();

			while (flag) {
				// Blocks until a connection occurs:

				Socket socket = s.accept();

				new CallDumpConnect(socket,cdm);
			}

		} catch (Exception e) {

			System.out.println("CallDump Server failed to start..... Exiting!!!!!");
			e.printStackTrace();
			System.exit(2);
		}

	}

	/**
	 * Sets the flag variable were when it is set to true continiues looping waiting for a socket connection.
	 * When set to false it exits the program stopping the CallDump Process.
	 * @param set
	 */
	public void setFlag(boolean set) {
		flag = set;
	}

	/**
	 * Final cleanup method once a shutdown request has been made.
	 *
	 */
	private void exitCallDumpServer() {
		cdm.shutdown();
		System.exit(0);
	}

	/**
	 * This is an inner class used when a network client makes a socket connection. This will handle all 
	 * client communication.
	 */
	private class CallDumpConnect extends Thread {

		private Socket socket;

		private BufferedReader in;

		private PrintWriter out;

		private CallDumpManager cdm = null;
		
		private String Introduction = "Howdy from the CallDumpServer";
		
		/**
		 * Sets up the client communication on a network then class run to start the client server interaction.
		 * @param s: Socket connection
		 * @param cdm: The CallDumpManager object.
		 */

		public CallDumpConnect(Socket s, CallDumpManager cdm) {
			socket = s;
			this.cdm = cdm;
			
			try {
				in = new BufferedReader(new InputStreamReader(socket
						.getInputStream()));

				out = new PrintWriter(new BufferedWriter(
						new OutputStreamWriter(socket.getOutputStream())), true);

			} catch (IOException e) {
				e.printStackTrace();
			}
			start(); // Calls run()
		}

		/**
		 * Threads run method.
		 */
		public void run() {
			String SocString;
			CallDumpSession cds = null;

			try {
				out.println(Introduction);

				SocString = in.readLine();

				if (SocString.equalsIgnoreCase("stop")) {
					setFlag(false);
					exitCallDumpServer();
				} else {
					if (SocString.equalsIgnoreCase("status")) {
						Vector cdt = cdm.getCallDumpThreads();
						
						out.println("Total number of CallDumps running: " + cdt.size()+"\n");
						for(int a = 0; a < cdt.size(); a++)
						{
							cds = (CallDumpSession) cdt.get(a);
							out.println("CallDump ID: " + cds.getSessionId());
							out.println("Requested by: " + cds.getEmail());
							out.println("Looking for the following: " + cds.getSearchAndType());
							out.println("On the following Markets and Switches: " + cds.getSwitches());
							out.println("With StartDate of: " + cds.getStartDate() + " and EndDate of " + cds.getEndDate());
						}
					}
					else {
						if(SocString.indexOf("bigkill") >= 0)
						{
							out.println("The command bigkill has been given"); 
							cdm.BigKill();
							exitCallDumpServer();
						}
						if(SocString.indexOf("kill ") >= 0)
						{
							String pid = SocString.trim();
							pid = ((String)pid.substring(pid.indexOf(" "))).trim();
							out.println("The command kill " + pid + " has been given"); 
							cdm.Kill(Integer.parseInt(pid));
						}
					}
					
				}

				in.close();
				out.close();
				socket.close();
			} catch (Exception e) {
				System.out.println("Not a valid Request");
				e.printStackTrace();
				try {
					in.close();
					out.close();
					socket.close();
				} catch (Exception f) {
					f.printStackTrace();
				}
			}
		}
	}

	/**
	 * The main startup method takes the name and location of the XML configuration.
	 * @param args: The XML configuration file.
	 */
	public static void main(String[] args) {
		
		CallDumpServer cds = new CallDumpServer(args[0]);
	}

}
