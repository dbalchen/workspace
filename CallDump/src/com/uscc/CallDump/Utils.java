/*
 *  @Utils.java
 */

/****************************************************************************************************************
 * Authors     : MPS Team
 * Date        : January 10, 2002.
 * --------------------------------------------------------------------------------------------------------------
 * Revision(s) :
 * --------------------------------------------------------------------------------------------------------------
 * 1) Added Comments
 *    - Craig J. Stalsberg -
 * 2) Added copy()
 *    - Craig J. Stalsberg - Tue Apr 30 10:30:58 CDT 2002
 *
 * ################# Version 2.40 ############################################
 * 3) Removed all unecessary inport statements.
 *    - Craig J. Stalsberg - Tue Jul  2 07:58:14 CDT 2002
 * 4) Added ConvertData to convert a byte array from one encoding scheme to another.
 *    - Craig J. Stalsberg - Thu Jul 25 12:40:39 CDT 2002
 *
 * ################# Version 2.50 ############################################
 * 5) Added class fields to access RCS keyword variables.
 *    - Jacob Ray - Tue Oct  8 10:32:28 CDT 2002
 *
 * ################# Version 2.60 ############################################
 * 6) Added LocateFileinClasspath method.
 *    - Craig J. Stalsberg - Thu Mar 13 10:25:38 CST 2003
 * 7) Moved GetVolSerIdFromFilePath from InFiles.TransFile to here to make it
 *    available to other objects.
 *    - Craig J. Stalsberg - Thu Mar 27 14:49:56 CST 2003
 * 8) Added EXIT_SUCCESS and EXIT_FAILURE.
 *    - Craig J. Stalsberg - Thu Jun  5 08:11:48 CDT 2003
 * 9) Added clearByteArray
 *    - Pete Chudykowski - Mon Sep  8 09:34:40 CDT 2003
 * 10) Removed change in 9).
 *    - Pete Chudykowski - Mon Sep 15 09:08:51 CDT 2003
 * 11) Added '.' to enCodeString and deCodeString.
 *    - Pete Chudykowski - Fri Sep 26 08:00:23 CDT 2003
 *
 * ################# Version 2.80 ############################################
 * 12) Fixed unlinkFile method to not check to see if the method can write over
 *     a file before it removes it.  This prevented .FIN files from being removed
 *     in the IEL process.
 *    - Craig J. Stalsberg - Mon Oct 18 08:51:00 CDT 2004
 *
 * ################# Version 2.9x ############################################
 * 11) Added GetFileTypefromFilePath(), GetSwitchfromFilePath() and GetSwitchfromFileName()
 *     methods for SMSC Upgrade.
 *    - Craig J. Stalsberg - Mon Apr 11 11:06:09 CDT 2005
 ****************************************************************************************************************/

package com.uscc.CallDump;

import java.util.StringTokenizer;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

public class Utils {
    // Static Members

    public static final String LASTMODIFIEDDATE = "$Date:   09 Sep 2005 15:00:40  $";
    public static final String LASTMODIFIEDVERSION = "$Revision:   1.0.8.1  $";
    public static final String LASTMODIFIEDBY = "$Author:   pvcs  $";
    public static final String SOURCETAG = "$Name: v28_0 $";

    /** decode string */
    private static String deCodeString = "0123456789abcdefghijklmnopqrstuvwxyz.";

    /** encode string */
    private static String enCodeString = "ufzty4xvsqpmkji8golredcba976h53n210w.";

    public static final String EBCDIC = "Cp037";
    public static final String ASCII = "8859_1";

    public static final int EXIT_SUCCESS = 0;
    public static final int EXIT_FAILURE = 255;

    /** EndCode a string
     * @param InComing     String to Encode
     * @return             Encoded String
     */
    public static String enCode(String InComing) {
        StringBuffer work = new StringBuffer();

        for (int a = 0; a < InComing.length(); a++) {
            work.append(enCodeString.charAt(deCodeString.indexOf(InComing.charAt(a))));
        }
        return work.toString();
    }

    /** Decode a string
     * @param InComing     String to Decode
     * @return             Decoded String
     */
    public static String deCode(String InComing) {
        StringBuffer work = new StringBuffer();

        for (int a = 0; a < InComing.length(); a++) {
            work.append(deCodeString.charAt(enCodeString.indexOf(InComing.charAt(a))));
        }
        return work.toString();
    }

    /** Pad a string with another string before the current string
     * @param   string2pad    String to Pad
     * @param   tosize        Length of Padded String
     * @param   padwith       String to Pad Input String with
     * @return                Padded String
     */
    public static String PadStringBefore(String string2pad, int tosize, String padwith) {
        for (int a = string2pad.length(); a < tosize; a++) {
            string2pad = padwith + string2pad;

        }
        return string2pad;
    }

    /** Pad a string with another string after the current string
     * @param   string2pad    String to Pad
     * @param   tosize        Length of Padded String
     * @param   padwith       String to Pad Input String with
     * @return                Padded String
     */
    public static String PadStringAfter(String string2pad, int tosize, String padwith) {
        for (int a = string2pad.length(); a < tosize; a++) {
            string2pad = string2pad + padwith;
        }
        return string2pad;
    }

    /** Copy a String to a Byte Array
     * @param   buff    byte array to write String
     * @param   strt    index into array to start copy
     * @param   data    String to write to array
     */
    public static void writeStringtoByteArray(byte[] buff, int strt, String data) {
        // Get the array of bytes from the String
        byte[] x = data.getBytes();

        // Loop through copying bytes from String to byte array.
        for (int cnt = strt; cnt < x.length; cnt++) {
            buff[cnt] = x[cnt - strt];
        }
    }

    /** Write a short to a byte Array
     * @param   buff    byte array to write String
     * @param   strt    index into array to start copy
     * @param   data    short to write to array
     */
    public static void writeShortToByteArray(byte[] buff, int strt, short data) {
        buff[strt++] = (byte) (data & 0xFF);
        buff[strt] = (byte) ((data >> 8) & 0xFF);
    }

    /** read a short from a byte array
     * @param   buff    byte array that contains the short
     * @param   strt    index into array to start read
     * @return          short from array
     */
    public static short readShortfromByteArray(byte[] buff, int strt) {
        return ((short) ((buff[strt] << 8) + (buff[strt + 1] & 0x00FF)));
    }

    /** Read an int from a byte array
     * @param  buff     byte array that contains the int
     * @param  strt     index into array to start read
     * @return          int from array
     */
    public static int readIntfromByteArray(byte[] buff, int strt) {
        int temp = 0;

        for (int j = strt; j < strt + 4; ++j) {
            temp = (temp << 8) + (buff[j] & 0x00FF);
        }
        return (temp);
    }

    /** Read a long from a byte array
     * @param  buff     byte array that contains the long
     * @param  strt     index into array to start read
     * @return          long from array
     */
    public static long readLongfromByteArray(byte[] buff, int strt) {
        long temp = 0L;

        // Build the long from the array
        for (int j = strt; j < strt + 8; ++j) {
            temp = (temp << 8) + (buff[j] & 0x00FF);
        }
        return (temp);
    }

    /** Write an int to a byte array
     * @param  buff    byte array to write int
     * @param  strt    index to start the write
     * @param  data    int to write to array
     */
    public static void writeIntToByteArray(byte[] buff, int strt, int data) {
        buff[strt++] = (byte) ((data >> 24) % 256); // highest byte
        buff[strt++] = (byte) ((data >> 16) % 256);
        buff[strt++] = (byte) ((data >> 8) % 256);
        buff[strt++] = (byte) (data % 256); // lowest byte
    }

    /**
     * Converts a byte into a long
     * @param b The byte
     * @return The long
     */
    public static long byteToLong(byte b) {
        return (long) (((int) b & 0x07f) + (int) ((b < 0) ? 0x80 : 0));
    }

    /**
     * Converts 8 bytes from a byte array to a long value
     * @param b The byte array
     * @param pos Position within the byte array to start
     * @return The long value
     */
    public static long byteToLong(byte b[], int pos) {
        long l;

        l = byteToLong(b[pos++]) << 56;
        l |= byteToLong(b[pos++]) << 48;
        l |= byteToLong(b[pos++]) << 40;
        l |= byteToLong(b[pos++]) << 32;
        l |= byteToLong(b[pos++]) << 24;
        l |= byteToLong(b[pos++]) << 16;
        l |= byteToLong(b[pos++]) << 8;
        l |= byteToLong(b[pos]);
        return l;
    }

    /**
     * Converts an long into a byte array
     * @param l The long
     * @param b The byte array
     * @param pos Position within the byte array to start
     * @return The position after the long
     */
    public static int longToByte(long l, byte b[], int pos) {
        b[pos++] = (byte) ((l >> 56) & 0xff);
        b[pos++] = (byte) ((l >> 48) & 0xff);
        b[pos++] = (byte) ((l >> 40) & 0xff);
        b[pos++] = (byte) ((l >> 32) & 0xff);
        b[pos++] = (byte) ((l >> 24) & 0xff);
        b[pos++] = (byte) ((l >> 16) & 0xff);
        b[pos++] = (byte) ((l >> 8) & 0xff);
        b[pos++] = (byte) (l & 0xff);
        return pos;
    }

    /** Read double from byte array
     * @param  buff    byte array to read from
     * @param  strt    index to start read
     * @return         double from array
     */
    public static double readDoublefromByteArray(byte[] buff, int strt) {
        return Double.longBitsToDouble(byteToLong(buff, strt));
    }

    /**
     * Converts a double into a byte array
     * @param d The double
     * @param b The byte array
     * @param pos Position within the byte array to start
     * @return The position after the double     */
    public static int doubleToByte(double d, byte b[], int pos) {
        return longToByte(Double.doubleToLongBits(d), b, pos);
    }

    /**
     * Converts byte array from one character set to another
     * @param in The byte array
     * @param inenc Character Encoding of input buffer
     * @param outenc Character Encoding of output buffer
     * @return A Byte array converted from one encoding to another. */
    public static byte[] ConvertData(byte[] in, String inenc, String outenc) throws UnsupportedEncodingException {
        return new String(in, inenc).getBytes(outenc);
    }

    /** Convert an ASCII char to an EBCDIC char
     * @param  ascii    ASCII char to convert
     * @return          EBCDIC equivalent char
     */
    public static int ASCIIToEBCDIC(int ascii) {
        return AToE[ascii & 0xff] & 0xff;
    }

    /** Convert an EBCDIC char to an ASCII char
     * @param  ebcdic   EBCDIC char to convert
     * @return          ASCII equivalent char
     */
    public static int EBCDICToASCII(int ebcdic) {
        return EToA[ebcdic & 0xff] & 0xff;
    }

    // ASCII to EBCDIC conversion table
    private static byte[] AToE = {
        0, 1, 2, 3, 55, 45, 46, 47, 22, 5, 21, 11, 12, 13, 14, 15,
        16, 17, 18, 63, 60, 61, 50, 38, 24, 25, 63, 39, 28, 29, 30, 31,
        64, 90, 127, 123, 91, 108, 80, 125, 77, 93, 92, 78, 107, 96, 75, 63,
        -16, -15, -14, -13, -12, -11, -10, -9, -8, -7, 122, 94, 76, 126, 110, 111,
        124, -63, -62, -61, -60, -59, -58, -57, -56, -55, -47, -46, -45, -44,
        -43, -42, -41, -40, -39, -30, -29, -28, -27, -26, -25, -24, -23, 63,
        63, 63, 63, 109, -71, -127, -126, -125, -124, -123, -122, -121, -120,
        -119, -111, -110, -109, -108, -107, -106, -105, -104, -103, -94, -93, -92,
        -91, -90, -89, -88, -87, 63, 79, 63, 63, 7, 63, 63, 63, 63, 63, 63, 63,
        63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63,
        63, 63, 63, 63, 63, 63, 63, 63, 64, 63, 74, 123, 63, 63, 63, 63,
        63, 63, 63, 63, 95, 63, 63, 63,
        63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63,
        63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63,
        63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63,
        63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63,
        63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63
    };

    // EBCDIC to ASCII conversion table
    private static byte[] EToA = {
        0, 1, 2, 3, 26, 9, 26, 127, 26, 26, 26, 11, 12, 13, 14, 15,
        16, 17, 18, 26, 26, 10, 8, 26, 24, 25, 26, 26, 28, 29, 30, 31,
        26, 26, 28, 26, 26, 10, 23, 27, 26, 26, 26, 26, 26, 5, 6, 7,
        26, 26, 22, 26, 26, 30, 26, 4, 26, 26, 26, 26, 20, 21, 26, 26,
        32, 26, 26, 26, 26, 26, 26, 26, 26, 26, -94, 46, 60, 40, 43, 124,
        38, 26, 26, 26, 26, 26, 26, 26, 26, 26, 33, 36, 42, 41, 59, -84,
        45, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 44, 37, 95, 62, 63,
        26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 58, 35, 64, 39, 61, 34,
        26, 97, 98, 99, 100, 101, 102, 103, 104, 105, 26, 26, 26, 26, 26, 26,
        26, 106, 107, 108, 109, 110, 111, 112, 113, 114, 26, 26, 26, 26, 26, 26,
        26, 26, 115, 116, 117, 118, 119, 120, 121, 122, 26, 26, 26, 26, 26, 26,
        26, 26, 26, 26, 26, 26, 26, 26, 26, 96, 26, 26, 26, 26, 26, 26,
        26, 65, 66, 67, 68, 69, 70, 71, 72, 73, 26, 26, 26, 26, 26, 26,
        26, 74, 75, 76, 77, 78, 79, 80, 81, 82, 26, 26, 26, 26, 26, 26,
        26, 26, 83, 84, 85, 86, 87, 88, 89, 90, 26, 26, 26, 26, 26, 26,
        48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 26, 26, 26, 26, 26, 26
    };

    /**
     * Remove the EXTENSION from a FileName
     * e.g. for "filename.next.txt" return "filename.next"
     * @param  filename   FileName to remove extension from
     * @return            FileName without extension
     */
    public static String RemoveExtensionfromFileName(String filename) {
        int i = filename.lastIndexOf('.');
        return (filename.substring(0, i));
    }

    /**
     * The static method that actually performs the file copy.
     * Before copying the file, however, it performs a lot of tests to make
     * sure everything is as it should be.
     */
    public static void copy(String from_name, String to_name) throws IOException {
        File from_file = new File(from_name); // Get File objects from Strings
        File to_file = new File(to_name);

        // First make sure the source file exists, is a file, and is readable.
        if (!from_file.exists()) {
            throw new IOException("File Does not exist: " + from_file.getName());
        }
        if (!from_file.isFile()) {
            throw new IOException("File to Transfer is not a File: " + from_file.getName());
        }
        if (!from_file.canRead()) {
            throw new IOException("File to Transfer is not readable: " + from_file.getName());
        }

        // If the destination is a directory, use the source file name
        // as the destination file name
        if (to_file.isDirectory()) {
            to_file = new File(to_file, from_file.getName());

            // If the destination exists, make sure it is a writeable file
            // and ask before overwriting it.  If the destination doesn't
            // exist, make sure the directory exists and is writeable.
        }
        if (to_file.exists()) {
            if (!to_file.canWrite()) {
                throw new IOException("Destination is not writeable: " + to_file.getName());
            }
        }

        // If we've gotten this far, then everything is okay.
        // So we copy the file, a buffer of bytes at a time.
        FileInputStream from = null; // Stream to read from source
        FileOutputStream to = null; // Stream to write to destination

        try {
            from = new FileInputStream(from_file); // Create input stream
            to = new FileOutputStream(to_file); // Create output stream
            byte[] buffer = new byte[4096]; // To hold file contents
            int bytes_read; // How many bytes in buffer

            // Read a chunk of bytes into the buffer, then write them out,
            // looping until we reach the end of the file (when read() returns
            // -1).  Note the combination of assignment and comparison in this
            // while loop.  This is a common I/O programming idiom.
            while ((bytes_read = from.read(buffer)) != -1) { // Read until EOF
                to.write(buffer, 0, bytes_read); // write
            }
        } finally { // Always close the streams, even if exceptions were thrown
            if (from != null) {
                try {
                    from.close();
                } catch (IOException e) {
                    ;
                }
            }
            if (to != null) {
                try {
                    to.close();
                } catch (IOException e) {
                    ;
                }
            }
        }
    }

    /**
     * unlinks ( removes ) a file
     * @param fn file name to unlink
     * @return true if file unlinked
     */
    public static boolean unlinkFile(String fn) {
        File f = new File(fn);
        boolean deleted = true;
        if (f.exists() && f.isFile()) {
            f.delete();
        } else {
            deleted = false;
        }
        return deleted;
    }

    /**
     * touches a file, i.e. if it exists set its modification date
     * otherwise create the file
     * @param fn file name to touch
     * @exception throws IOException
     */
    public static void touchFile(String fn) throws IOException {
        File f = new File(fn);
        if (f.exists() && f.isFile() && f.canWrite()) {
            f.setLastModified(System.currentTimeMillis());
        } else {
            try {
                f.createNewFile();
            } catch (IOException ioe) {
                throw ioe;
            }
        }
    }

    /**
     * Test whether a file exists
     * @param fn file name to check
     * @return false if not a file (i.e. is a directory) or not found
     */
    public static boolean existsFile(String fn) {
        File f = new File(fn);
        return (f.exists() && f.isFile());
    }

    /**
     * Test whether a file exists and is empty
     * @param fn file name to check
     * @return false if not a file (i.e. is a directory) or not found
     */
    public static boolean emptyFile(String fn) {
        File f = new File(fn);
        return (f.exists() && f.isFile() && f.length() == 0);
    }

    /**
     * move (rename) a file
     * @param fileName file to rename
     * @param newName new filename
     */
    public static boolean mvFile(String fileName, String newName) {
        File f1 = new File(fileName);
        File f2 = new File(newName);
        return f1.renameTo(f2);
    }

    /**
     * Locate the first occurrance of a file in the java.classpath variable.
     * @param FileToFind - Name of file to locate (the file must actually exist)
     * @return - Path and File name of first instance of file in classpath
     *           otherwise, return null
     */
    public static String LocateFileinClasspath(String FileToFind) {
        // Local Variables
        String FilePath = null;

        StringTokenizer SysPath = new StringTokenizer(System.getProperty("java.class.path"), ":");
        while (SysPath.hasMoreTokens()) {
            try {
                File FiletoCheck = new File(SysPath.nextToken());
                if (FiletoCheck.exists() &&
                    FiletoCheck.getName().equalsIgnoreCase(FileToFind)) {
                    FilePath = FiletoCheck.getAbsolutePath();
                    break;
                }
            } catch (Exception e) {
                return FilePath;
            }
        }
        return FilePath;
    }

    public static String GetVolSerIdFromFilePath(String FilePath) {
        String tok = null;
        String finaltok = null;
        StringTokenizer filetoks;

        // Break File Path into directories
        filetoks = new StringTokenizer(FilePath, "/");

        // Loop through until we get to the last token which is the one we want
        while (filetoks.hasMoreTokens()) {
            tok = filetoks.nextToken();
        }
        // Now tokenize this directory on underscores
        StringTokenizer pathtoks = new StringTokenizer(tok, "_");
        while (pathtoks.hasMoreTokens()) {
            tok = pathtoks.nextToken();
            if (tok.startsWith("ID")) {
                // Found the correct token, now get just the numeric portion
                finaltok = tok.substring(2);
                break;
            }
        }
        return (finaltok);
    }

    /**
     * determine what type of file this is by the path
     * data/MOT/SMOTS_FSMS_ID000900_T20050219210201
     * @param FilePath to search
     * @return
     */
    public static String GetFileTypefromFilePath(String FilePath) {
        String tok = null;
        String finaltok = null;
        StringTokenizer filetoks;

        // Break File Path into directories
        filetoks = new StringTokenizer(FilePath, "/");

        // Loop through until we get to the last token which is the one we want
        while (filetoks.hasMoreTokens()) {
            tok = filetoks.nextToken();
        }
        // Now tokenize this directory on underscores
        StringTokenizer pathtoks = new StringTokenizer(tok, "_");
        while (pathtoks.hasMoreTokens()) {
            tok = pathtoks.nextToken();
            if (tok.startsWith("F")) {
                // Found the correct token, now get just the numeric portion
                finaltok = tok.substring(1);
                break;
            }
        }
        return (finaltok);
    }

    public static String GetSwitchfromFilePath(String FilePath) {
        String tok = null;
        String finaltok = null;
        StringTokenizer filetoks;

        // Break File Path into directories
        filetoks = new StringTokenizer(FilePath, "/");

        // Loop through until we get to the last token which is the one we want
        while (filetoks.hasMoreTokens()) {
            tok = filetoks.nextToken();
        }
        return Utils.GetSwitchfromFileName(tok);
    }
    public static String GetSwitchfromFileName(String FileName) {
        String tok = null;
        String finaltok = null;
        StringTokenizer filetoks;

        // Now tokenize this directory on underscores
        StringTokenizer pathtoks = new StringTokenizer(FileName, "_");
        while (pathtoks.hasMoreTokens()) {
            tok = pathtoks.nextToken();
            // Found the correct token, now get just the numeric portion
            finaltok = tok.substring(1);
            break;
        }
        return (finaltok);
    }
}
