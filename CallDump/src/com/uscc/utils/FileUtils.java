package com.uscc.utils;

import java.util.List;
import java.io.File;
import java.util.Hashtable;
//import com.enterprisedt.net.ftp.FTPClient;
//import com.enterprisedt.net.ftp.FTPConnectMode;
//import com.enterprisedt.net.ftp.FTPTransferType;
import com.jcraft.jsch.*;

import com.uscc.beans.CallDumpReport;
import com.uscc.beans.Developer;


public class FileUtils {
    protected JSch conn;
    private Hashtable<String, Developer> connects = new Hashtable<String, Developer>();
    
    public FileUtils() {     
        Developer knx = new Developer();
        knx.setUserId("calldmp5");
        knx.setPassword("cal5dmp");
        
        Developer mad = new Developer();
        mad.setUserId("calldmp6");
        mad.setPassword("cal6dmp");
        
        Developer kpr0 = new Developer();
        kpr0.setUserId("calldmp");
        kpr0.setPassword("BooGoo900");    
        
        connects.put("knx1scd1", knx);
        connects.put("mad1scd1", mad);     
        connects.put("kpr01scdap", kpr0);
    }
    public String [] getFiles(List<CallDumpReport> files, String localdir)
    {
       String [] rpts = new String[files.size()];
       
       for (int i=0;i<files.size();i++) {
           CallDumpReport rpt = files.get(i);
           File rptfile = new File(rpt.getFile());
           String dest = localdir + "/" + rptfile.getName();
           getFile(rpt.getHost(),connects.get(rpt.getHost()).getUserId(),
                   connects.get(rpt.getHost()).getPassword(),rpt.getFile(),dest);
           rpts[i]=dest;
       }
       return rpts;
    }
    private void getFile(String host, String user, String pass, String src, String dest) {
		JSch jsch = new JSch();
        Session session = null;
        try {
            session = jsch.getSession(user, host, 22);
            session.setConfig("StrictHostKeyChecking", "no");
            session.setPassword(pass);
            session.connect();

            Channel channel = session.openChannel("sftp");
            channel.connect();
            ChannelSftp sftpChannel = (ChannelSftp) channel;
            sftpChannel.get(src,dest);
            sftpChannel.exit();
            session.disconnect();
//            conn = new FTPClient(host, 21);
//            conn.login(user, pass);
//            conn.setType(FTPTransferType.BINARY);
//            conn.setConnectMode(FTPConnectMode.ACTIVE);
//            conn.get(dest,src);
//            conn.quit();
        } catch (Exception e) {
            System.out.println("--------------------------: ");
            System.out.println("Exception in file transfer: ");
            System.out.println("--------------------------: ");
            System.out.println("SRC: " + src + " on " + host);
            System.out.println("DES: " + dest);
            System.out.println("");
            System.out.println(e.getMessage());
        }
    }
}
