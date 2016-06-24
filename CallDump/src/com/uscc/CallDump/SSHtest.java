/**
 * 
 */
package com.uscc.CallDump;
import com.jcraft.jsch.*;
/**
 * @author dbalchen
 *
 */
public class SSHtest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		JSch jsch = new JSch();
        Session session = null;
        try {
            session = jsch.getSession("calldmp", "kpr01scdap", 22);
//            session.setConfig("StrictHostKeyChecking", "no");
            session.setPassword("BooGoo900");
            session.connect();

            Channel channel = session.openChannel("sftp");
            channel.connect();
            ChannelSftp sftpChannel = (ChannelSftp) channel;
            sftpChannel.get("remotefile.txt", "localfile.txt");
            sftpChannel.exit();
            session.disconnect();
        } catch (JSchException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        } catch (SftpException e) {
            e.printStackTrace();
        }
		

	}

}
