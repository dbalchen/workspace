package com.uscc.utils;

import java.text.ParseException;
import java.util.TimeZone;
import junit.framework.TestCase;

public class USCCDateTest extends TestCase {
	
	public void testGetSysDateTime() {
		System.out.println("testGetSysDateTime");
		System.out.print("System Date: ");
		System.out.println(USCCDate.getSysDateTime());
		System.out.println("\n");
	}

	public void testGetAdjustedSysDateTime() {
		System.out.println("testGetAdjustedSysDateTime");
		System.out.print("YEAR:        ");
		System.out.println(USCCDate.getAdjustedSysDateTime(1, 10));
		System.out.print("MONTH:       ");
		System.out.println(USCCDate.getAdjustedSysDateTime(2, 10));
		System.out.print("DATE:        ");
		System.out.println(USCCDate.getAdjustedSysDateTime(5, 10));
		System.out.print("HOUR_OF_DAY: ");
		System.out.println(USCCDate.getAdjustedSysDateTime(11, 10));
		System.out.print("MINUTE:      ");
		System.out.println(USCCDate.getAdjustedSysDateTime(12, 10));
		System.out.print("SECOND:      ");
		System.out.println(USCCDate.getAdjustedSysDateTime(13, 10));
		System.out.println("\n");
	}

	public void testGetAdjustedDateTime() {
		System.out.println("testGetAdjustedDateTime");
		System.out.print("YEAR:        ");
		System.out.println(USCCDate.getAdjustedDateTime("19000101010101", 1, 10));
		System.out.print("MONTH:       ");
		System.out.println(USCCDate.getAdjustedDateTime("19000101010101", 2, 10));
		System.out.print("DATE:        ");
		System.out.println(USCCDate.getAdjustedDateTime("19000101010101", 5, 10));
		System.out.print("HOUR_OF_DAY: ");
		System.out.println(USCCDate.getAdjustedDateTime("19000101010101", 11, 10));
		System.out.print("MINUTE:      ");
		System.out.println(USCCDate.getAdjustedDateTime("19000101010101", 12, 10));
		System.out.print("SECOND:      ");
		System.out.println(USCCDate.getAdjustedDateTime("19000101010101", 13, 10));
		System.out.println("\n");
	}

	public void testCompareDates() throws ParseException {
		
		int return_value = 0;
		String date1 = "19000101010101";
		String date2 = "20000101010101";
		String date3 = "20070101010101";
		String date4 = "20071201010101";
		
		System.out.println("testCompareDates");
		return_value = (USCCDate.CompareDates(date1, "yyyyMMddhhmmss", date1, "yyyyMMddhhmmss"));
		System.out.print(date1);
		System.out.print(", ");
		System.out.print(date1);
		System.out.print(", ");
		if ( return_value == USCCDate.DATE_EQUAL ) {
			System.out.println("DATE_EQUAL");
		}
		if ( return_value == USCCDate.DATE_NEWER ) {
			System.out.println("DATE_NEWER");
		}
		if ( return_value == USCCDate.DATE_OLDER ) {
			System.out.println("DATE_OLDER");
		}
		
		return_value = (USCCDate.CompareDates(date1, "yyyyMMddhhmmss", date2, "yyyyMMddhhmmss"));
		System.out.print(date1);
		System.out.print(", ");
		System.out.print(date2);
		System.out.print(", ");
		if ( return_value == USCCDate.DATE_EQUAL ) {
			System.out.println("DATE_EQUAL");
		}
		if ( return_value == USCCDate.DATE_NEWER ) {
			System.out.println("DATE_NEWER");
		}
		if ( return_value == USCCDate.DATE_OLDER ) {
			System.out.println("DATE_OLDER");
		}
		
		return_value = (USCCDate.CompareDates(date3, "yyyyMMddhhmmss", date2, "yyyyMMddhhmmss"));
		System.out.print(date3);
		System.out.print(", ");
		System.out.print(date2);
		System.out.print(", ");
		if ( return_value == USCCDate.DATE_EQUAL ) {
			System.out.println("DATE_EQUAL");
		}
		if ( return_value == USCCDate.DATE_NEWER ) {
			System.out.println("DATE_NEWER");
		}
		if ( return_value == USCCDate.DATE_OLDER ) {
			System.out.println("DATE_OLDER");
		}
		
		return_value = (USCCDate.CompareDates(date3, "yyyyMMddhhmmss", date4, "yyyyMMddhhmmss"));
		System.out.print(date3);
		System.out.print(", ");
		System.out.print(date4);
		System.out.print(", ");
		if ( return_value == USCCDate.DATE_EQUAL ) {
			System.out.println("DATE_EQUAL");
		}
		if ( return_value == USCCDate.DATE_NEWER ) {
			System.out.println("DATE_NEWER");
		}
		if ( return_value == USCCDate.DATE_OLDER ) {
			System.out.println("DATE_OLDER");
		}
		System.out.println("\n");		
	}

	public void testConvertDateFormatCheckValidity() throws ParseException {
		String date1 = "20071201010101";
		String date2 = "2001-07-04 12:08:56";
		
		System.out.println("testConvertDateFormatCheckValidity");
		System.out.print("CST to EST: ");
		System.out.print(date1);
		System.out.print(", ");
		System.out.println((USCCDate.ConvertDateFormatCheckValidity
				(date1, "yyyyMMddhhmmss", "CST", "EEE, d MMM yyyy HH:mm:ss Z", "EST")));
		System.out.print("CST to PST: ");
		System.out.print(date1);
		System.out.print(", ");
		System.out.println((USCCDate.ConvertDateFormatCheckValidity
				(date1, "yyyyMMddhhmmss", "CST", "EEE, d MMM yyyy HH:mm:ss Z", "PST")));
		System.out.print("CST to EST: ");
		System.out.print(date2);
		System.out.print(", ");
		System.out.println((USCCDate.ConvertDateFormatCheckValidity
				(date2, "yyyy-MM-dd HH:mm:ss", "CST", "yyyy.MM.dd G 'at' HH:mm:ss z", "EST")));
		System.out.print("CST to PST: ");
		System.out.print(date2);
		System.out.print(", ");
		System.out.println((USCCDate.ConvertDateFormatCheckValidity
				(date2, "yyyy-MM-dd HH:mm:ss", "CST", "yyyy.MM.dd G 'at' HH:mm:ss z", "PST")));
		System.out.println("\n");		
	}

	public void testConvertDateFormatStringStringStringStringString() throws ParseException {
		String date1 = "20071111111111";
		String date2 = "2007.12.11 02:00:00";
		
		System.out.println("testConvertDateFormat");
		System.out.print("CST to EST: ");
		System.out.print(date1);
		System.out.print(", ");
		System.out.println((USCCDate.ConvertDateFormat
				(date1, "yyyyMMddhhmmss", "CST", "yyyyMMddhhmmss", "EST")));
		System.out.print("CST to PST: ");
		System.out.print(date1);
		System.out.print(", ");
		System.out.println((USCCDate.ConvertDateFormat
				(date1, "yyyyMMddhhmmss", "CST", "yyyyMMddhhmmss", "PST")));
		System.out.print("CST to EST: ");
		System.out.print(date2);
		System.out.print(", ");
		System.out.println((USCCDate.ConvertDateFormat
				(date2, "yyyy.MM.dd HH:mm:ss", "CST", "yyyy.MM.dd HH:mm:ss", "EST")));
		System.out.print("CST to PST: ");
		System.out.print(date2);
		System.out.print(", ");
		System.out.println((USCCDate.ConvertDateFormat
				(date2, "yyyy.MM.dd HH:mm:ss", "CST", "yyyy.MM.dd HH:mm:ss", "PST")));
		System.out.println("\n");	}

	public void testConvertFormatTimeZone() throws ParseException {
		String date1 = "20071111111111";
		TimeZone cst = TimeZone.getTimeZone("CST");
		TimeZone est = TimeZone.getTimeZone("EST");
		TimeZone pst = TimeZone.getTimeZone("PST");
		TimeZone gmt = TimeZone.getTimeZone("GMT+10");
	
		System.out.println("testConvertFormatTimeZone");
		System.out.print("CST to EST: ");
		System.out.print(date1);
		System.out.print(", ");
		System.out.println((USCCDate.ConvertFormatTimeZone
				(date1, "yyyyMMddhhmmss", cst, "yyyyMMddhhmmss", est)));
		System.out.print("CST to PST: ");
		System.out.print(date1);
		System.out.print(", ");
		System.out.println((USCCDate.ConvertFormatTimeZone
				(date1, "yyyyMMddhhmmss", cst, "yyyyMMddhhmmss", pst)));
		System.out.print("CST to GMT+10: ");
		System.out.print(date1);
		System.out.print(", ");
		System.out.println((USCCDate.ConvertFormatTimeZone
				(date1, "yyyyMMddhhmmss", cst, "yyyyMMddhhmmss", gmt)));
		System.out.print("PST to GMT+10: ");
		System.out.print(date1);
		System.out.print(", ");
		System.out.println((USCCDate.ConvertFormatTimeZone
				(date1, "yyyyMMddhhmmss", pst, "yyyyMMddhhmmss", gmt)));		
		System.out.println("\n");
	}

	public void testConvertDatetoEpochTime() throws ParseException {
		String date1 = "20071111111111";
		String format1 = "yyyyMMddhhmmss";
		String date2 = "2007.12.11 02:00:00";
		String format2 = "yyyy.MM.dd HH:mm:ss";
		String date3 = "01-01-1970 00:00:00";
		String format3 = "dd-MM-yyyy HH:mm:ss";

		System.out.println("testConvertDatetoEpochTime");
		System.out.print("Format1: ");
		System.out.print(date1);
		System.out.print(", ");
		System.out.println(USCCDate.ConvertDatetoEpochTime(date1, format1));
		System.out.print("Format2: ");
		System.out.print(date2);
		System.out.print(", ");
		System.out.println(USCCDate.ConvertDatetoEpochTime(date2, format2));
		System.out.print("Format3: ");
		System.out.print(date3);
		System.out.print(", ");
		System.out.println(USCCDate.ConvertDatetoEpochTime(date3, format3));
		System.out.println("\n");
	}
	
	public void testConvertDateFormatStringStringString() throws ParseException {
		String date1 = "20071111111111";
		String format1 = "yyyyMMddhhmmss";
		String date2 = "2007.12.11 02:00:00";
		String format2 = "yyyy.MM.dd HH:mm:ss";
		String date3 = "01-01-1970 00:00:00";
		String format3 = "dd-MM-yyyy HH:mm:ss";

		System.out.println("testConvertDateFormat");
		System.out.print("Format1 to Format2: ");
		System.out.print(date1);
		System.out.print(", ");
		System.out.println(USCCDate.ConvertDateFormat(date1, format1, format2));
		System.out.print("Format2 to Format3: ");
		System.out.print(date2);
		System.out.print(", ");
		System.out.println(USCCDate.ConvertDateFormat(date2, format2, format3));
		System.out.print("Format3 to Format1: ");
		System.out.print(date3);
		System.out.print(", ");
		System.out.println(USCCDate.ConvertDateFormat(date3, format3, format1));
		System.out.println("\n");
	}
}
