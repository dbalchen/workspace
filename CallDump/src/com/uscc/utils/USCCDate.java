
/*
 *  @USCCDate.java
 */

/****************************************************************************************************************
 * Authors     : MPS Team
 * Date        : January 10, 2002.
 * --------------------------------------------------------------------------------------------------------------
 * Revision(s) :
 * --------------------------------------------------------------------------------------------------------------
 * 1) Cleaned up the module and implemented all new style formatting.
 *    - Craig J. Stalsberg - Tue Feb 26 13:19:47 CST 2002
 * 2) Added comments.
 *    - Craig J. Stalsberg - Fri Apr 26 10:06:47 CDT 2002
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
 * 5) Added getAdjustedSysDateTime and CompareDates methods.
 *    - Craig J. Stalsberg - Mon Apr 14 21:30:46 CDT 2003
 * 6) Added some missing javadoc comments as well as the
 *    TWO_DIGIT_DATE_TIME_FORMAT constant.
 *    - Craig J. Stalsberg - Mon Apr 21 15:54:11 CDT 2003
 * 7) Added ConvertFormatTimeZone method for converting between time zones.
 *    - Pete Chudykowski - Thu May  8 17:11:14 CDT 2003
 * 8) Added ConvertDatetoEpochTime()
 *    - Craig J. Stalsberg - Fri Jun  6 12:13:16 CDT 2003
 *
 * ################# Version 2.9x ############################################
 * 9) Added getAdjustedDateTime() method for SMSC upgrade.
 *    - Craig J. Stalsberg - Mon Apr 11 11:01:10 CDT 2005
 *
 * ################# Version 3.1x ############################################
 * 10) Modified getAdjustedDateTime() to take into account that month is
 * zero offset.
 *    - David Balchen - Fri Dec 02 8:33 CDT 2005
 ****************************************************************************************************************/
package com.uscc.utils;

import java.util.TimeZone;
import java.util.Calendar;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import com.uscc.CallDump.Utils;
/**
 * Class with all static methods for performing various date related tasks
 */
public class USCCDate {
    // Static Members

    public static final String LASTMODIFIEDDATE = "$Date:   02 Dec 2005 12:03:36  $";
    public static final String LASTMODIFIEDVERSION = "$Revision:   1.0.7.1  $";
    public static final String LASTMODIFIEDBY = "$Author:   pvcs  $";
    public static final String SOURCETAG = "$Name: v26_0 $";

    public static final String DEF_DATE_TIME_FORMAT = "yyyyMMddHHmmss";
    public static final String TWO_DIGIT_DATE_TIME_FORMAT = "MM/dd/yy HH:mm:ss";


    public static final int DATE_NEWER = 1;
    public static final int DATE_OLDER = -1;
    public static final int DATE_EQUAL = 0;

    /**
     * Get the Current System Date and Time in YYYYMMDDHH24MISS format
     * @return    Current System Date and Time
     */
    public static String getSysDateTime() {
        // Get an instance of the calender class
        Calendar CAL = Calendar.getInstance();
        String CurDateTime = Integer.toString(CAL.get(Calendar.YEAR)) +
            Utils.PadStringBefore(Integer.toString(CAL.get(Calendar.MONTH) + 1), 2, "0") +
            Utils.PadStringBefore(Integer.toString(CAL.get(Calendar.DATE)), 2, "0") +
            Utils.PadStringBefore(Integer.toString(CAL.get(Calendar.HOUR_OF_DAY)), 2, "0") +
            Utils.PadStringBefore(Integer.toString(CAL.get(Calendar.MINUTE)), 2, "0") +
            Utils.PadStringBefore(Integer.toString(CAL.get(Calendar.SECOND)), 2, "0");

        return (CurDateTime);
    }

    /**
     * Get the Current System Date and Time adjusted by a specified amount.
     * @param  WhatToAdjust     Which part of the date should be adjusted.
     * @param  AmountToAdjust   Adjust the date by how much.
     * @return    Current System Date and Time adjuste by specified amount.
     */
    public static String getAdjustedSysDateTime(int WhatToAdjust, int AmountToAdjust) {
        // Get an instance of the calender class
        Calendar CAL = Calendar.getInstance();
        CAL.add(WhatToAdjust, AmountToAdjust);
        String CurDateTime = Integer.toString(CAL.get(Calendar.YEAR)) +
            Utils.PadStringBefore(Integer.toString(CAL.get(Calendar.MONTH) + 1), 2, "0") +
            Utils.PadStringBefore(Integer.toString(CAL.get(Calendar.DATE)), 2, "0") +
            Utils.PadStringBefore(Integer.toString(CAL.get(Calendar.HOUR_OF_DAY)), 2, "0") +
            Utils.PadStringBefore(Integer.toString(CAL.get(Calendar.MINUTE)), 2, "0") +
            Utils.PadStringBefore(Integer.toString(CAL.get(Calendar.SECOND)), 2, "0");
        return (CurDateTime);
    }

    /**
     * Get the Current System Date and Time adjusted by a specified amount.
     * @param indate Input Date (YYYYMMDDHHMISS)
     * @param  WhatToAdjust     Which part of the date should be adjusted.
     * @param  AmountToAdjust   Adjust the date by how much.
     * @return    Current System Date and Time adjuste by specified amount.
     */
    public static String getAdjustedDateTime(String indate, int WhatToAdjust, int AmountToAdjust) {
    	// Get an instance of the calender class
    	Calendar CAL = Calendar.getInstance();
    	CAL.set(Calendar.YEAR,Integer.parseInt(indate.substring(0,4)));
    	CAL.set(Calendar.MONTH,(Integer.parseInt(indate.substring(4,6))-1));
    	CAL.set(Calendar.DAY_OF_MONTH,Integer.parseInt(indate.substring(6,8)));
    	CAL.set(Calendar.HOUR_OF_DAY,Integer.parseInt(indate.substring(8,10)));
    	CAL.set(Calendar.MINUTE,Integer.parseInt(indate.substring(10,12)));
    	CAL.set(Calendar.SECOND,Integer.parseInt(indate.substring(12,14)));
    	CAL.add(WhatToAdjust, AmountToAdjust);
    	StringBuffer CurDateTime = new StringBuffer();
    	CurDateTime.append(Integer.toString(CAL.get(Calendar.YEAR)));
    	CurDateTime.append(Utils.PadStringBefore(Integer.toString(CAL.get(Calendar.MONTH) + 1), 2, "0"));
    	CurDateTime.append(Utils.PadStringBefore(Integer.toString(CAL.get(Calendar.DAY_OF_MONTH)), 2, "0"));
    	CurDateTime.append(Utils.PadStringBefore(Integer.toString(CAL.get(Calendar.HOUR_OF_DAY)), 2, "0"));
    	CurDateTime.append(Utils.PadStringBefore(Integer.toString(CAL.get(Calendar.MINUTE)), 2, "0"));
    	CurDateTime.append(Utils.PadStringBefore(Integer.toString(CAL.get(Calendar.SECOND)), 2, "0"));
    	return (CurDateTime.toString());
    }

    /**
     * Compare two date strings.  The return code is based on the first date being
     * equal to the second date.
     * @return    DATE_OLDER if the first date is older than the second date
     *            DATE_NEWER if the first date is more recent than the second date
     *            DATE_EQUAL if the first date is equal the second date
     */
    public static int CompareDates(String date1, String dt1f, String date2, String dt2f) throws ParseException {
        DateFormat DateFormat1 = new SimpleDateFormat(dt1f);
        DateFormat DateFormat2 = new SimpleDateFormat(dt2f);

        Date dt1 = DateFormat1.parse(date1);
        Date dt2 = DateFormat2.parse(date2);

        if (dt1.before(dt2)) {
           return DATE_OLDER;
        }
        if (dt1.after(dt2)) {
           return DATE_NEWER;
        }
        return DATE_EQUAL;
    }

    /** Convert a String from Format A to Format B (include timezone conversion) and check Validity
     * @param  dt     Date To Convert
     * @param  in     Input Date Format
     * @param  inTz   Input TimeZone
     * @param  out    Output Date Format
     * @param  outTz  Output TimeZone
     * @exception java.text.ParseException
     *            if a invalid date, invalid format or invalid timezone is passed
     * @return        Converted String
     */
    public static String ConvertDateFormatCheckValidity(String dt,
        String in,
        String inTz,
        String out,
        String outTz) throws ParseException {
        DateFormat inDateFormat = new SimpleDateFormat(in);
        DateFormat outDateFormat = new SimpleDateFormat(out);

        inDateFormat.setLenient(false);
        outDateFormat.setLenient(false);
        inDateFormat.setTimeZone(TimeZone.getTimeZone(inTz));
        outDateFormat.setTimeZone(TimeZone.getTimeZone(outTz));
        return (outDateFormat.format(inDateFormat.parse(dt)));
    }

    /** Convert a String from Format A to Format B (include timezone conversion)
     * @param  dt     Date To Convert
     * @param  in     Input Date Format
     * @param  inTz   Input TimeZone
     * @param  out    Output Date Format
     * @param  outTz  Output TimeZone
     * @exception java.text.ParseException
     *            if a invalid format or timezone is passed
     * @return        Converted String
     */
    public static String ConvertDateFormat(String dt,
        String in,
        String inTz,
        String out,
        String outTz) throws ParseException {
        DateFormat inDateFormat = new SimpleDateFormat(in);
        DateFormat outDateFormat = new SimpleDateFormat(out);

        inDateFormat.setTimeZone(TimeZone.getTimeZone(inTz));
        outDateFormat.setTimeZone(TimeZone.getTimeZone(outTz));
        return (outDateFormat.format(inDateFormat.parse(dt)));
    }


    /** Convert the time zone of a String date format.
     * @param  dt     Date To Convert
     * @param  in     Input Date Format
     * @param  inTz   Input TimeZone
     * @param  out    Output Date Format
     * @param  outTz  Output TimeZone
     * @exception java.text.ParseException
     *            if a invalid format or timezone is passed
     * @return        Converted String
     */
    public static String ConvertFormatTimeZone(String dt,
        String in,
        TimeZone inTz,
        String out,
        TimeZone outTz) throws ParseException {

        // Define the format of input and output dates.
        java.text.SimpleDateFormat inDateFormat = new SimpleDateFormat(in);
        java.text.SimpleDateFormat outDateFormat = new SimpleDateFormat(out);

        // Initiate the Calendar variables for input and output time-zones.
        java.util.Calendar cal0 = Calendar.getInstance(inTz);
        java.util.Calendar cal1 = Calendar.getInstance(outTz);
        inDateFormat.setCalendar(cal0);
        outDateFormat.setCalendar(cal1);

        // Recalculate the date for the output Time Zone.
        java.util.Date date = inDateFormat.parse(dt);
        java.lang.String formatted = outDateFormat.format(date);

        return (formatted);
    }


    public static long ConvertDatetoEpochTime(String dt, String format)
                                             throws ParseException {
        Date formatedDate = null;
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        formatedDate = sdf.parse(dt);
        return formatedDate.getTime() / 1000;
    }

    /** Convert a String from Format A to Format B
     * @param  dt     Date To Convert
     * @param  in     Input Date Format
     * @param  out    Output Date Format
     * @exception java.text.ParseException
     *            if a invalid format or timezone is passed
     * @return        Converted String
     */
    public static String ConvertDateFormat(String dt, String in, String out) throws ParseException {
        DateFormat inDateFormat = new SimpleDateFormat(in);
        DateFormat outDateFormat = new SimpleDateFormat(out);

        return (outDateFormat.format(inDateFormat.parse(dt)));
    }

    USCCDate() {}
}
