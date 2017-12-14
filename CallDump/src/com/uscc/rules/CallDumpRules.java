package com.uscc.rules;

import java.text.ParseException;
import java.util.Calendar;

import com.uscc.beans.CallDumpRequest;
import com.uscc.utils.USCCDate;
import com.uscc.dao.CallDumpDAO;

public class CallDumpRules {
    public int isRequestValid(CallDumpRequest req) {
        if ((req.getSwitchesM01().equalsIgnoreCase(""))
                && (req.getSwitchesM02().equalsIgnoreCase(""))
                && (req.getSwitchesM03().equalsIgnoreCase(""))
                && (req.getSwitchesM04().equalsIgnoreCase(""))
                && (req.getSwitchesM05().equalsIgnoreCase(""))
                && (req.getSwitchesM06().equalsIgnoreCase(""))) {
            return CallDumpDAO.MISSING_SWITCH;
        }
        if ((req.getSearchString1().equalsIgnoreCase(""))
                && (req.getSearchString2().equalsIgnoreCase(""))
                && (req.getSearchString3().equalsIgnoreCase(""))
                && (req.getSearchString4().equalsIgnoreCase(""))
                && (req.getSearchString5().equalsIgnoreCase(""))
                && (req.getSearchString6().equalsIgnoreCase(""))) {
            return CallDumpDAO.MISSING_SEARCH_STRING;
        }

        try {

            String startd = req.getStartDate();
            String endd = req.getEndDate();
            // Is start and end date valid dates
            USCCDate.ConvertDateFormatCheckValidity(startd,
                    USCCDate.DEF_DATE_TIME_FORMAT, "CST6CDT",
                    USCCDate.DEF_DATE_TIME_FORMAT, "CST6CDT");
            USCCDate.ConvertDateFormatCheckValidity(endd,
                    USCCDate.DEF_DATE_TIME_FORMAT, "CST6CDT",
                    USCCDate.DEF_DATE_TIME_FORMAT, "CST6CDT");
            // is start date lt end date
            if (USCCDate.CompareDates(startd, USCCDate.DEF_DATE_TIME_FORMAT,
                    endd, USCCDate.DEF_DATE_TIME_FORMAT) != USCCDate.DATE_OLDER) {
                System.out.println("Date check 1:"
                        + startd
                        + ":"
                        + endd
                        + ":"
                        + USCCDate.CompareDates(startd,
                                USCCDate.DEF_DATE_TIME_FORMAT, endd,
                                USCCDate.DEF_DATE_TIME_FORMAT));
                return CallDumpDAO.INVALID_DATE;
            }

            String yearago = USCCDate.getAdjustedSysDateTime(Calendar.YEAR, -1);
            if (USCCDate.CompareDates(startd, USCCDate.DEF_DATE_TIME_FORMAT,
                    yearago, USCCDate.DEF_DATE_TIME_FORMAT) == USCCDate.DATE_OLDER) {
                System.out.println("Date check 2:"
                        + startd
                        + ":"
                        + yearago
                        + ":"
                        + USCCDate.CompareDates(startd,
                                USCCDate.DEF_DATE_TIME_FORMAT, yearago,
                                USCCDate.DEF_DATE_TIME_FORMAT));
                return CallDumpDAO.INVALID_DATE;
            }

        } catch (ParseException pe) {
            return CallDumpDAO.INVALID_DATE;
        }
        return CallDumpDAO.VALID_REQUEST;
    }
}
