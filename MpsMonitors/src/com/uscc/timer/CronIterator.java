package com.uscc.timer;

import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.StringTokenizer;

/**
 * A cron like task scheduler
 */
public class CronIterator
    implements ScheduleIterator {

  private int[] minutes, hours, days, months, daysofweek;

  private Calendar calendar = Calendar.getInstance();
  private Calendar futureCal = Calendar.getInstance();

  public CronIterator(String mins, String hrs, String dys, String dow,
                      String mth) {

//	  System.err.println("System Timer variables mins = "+mins+ "hours = " + hrs + "days = "+dys+" Dow = " + dow + "Month" + mth);
//	  System.out.println("System Timer variables mins = "+mins+ "hours = " + hrs + "days = "+dys+" Dow = " + dow + "Month" + mth);
    
	minutes = fillTimeArray(60, mins, 0);

    hours = fillTimeArray(24, hrs, 0);

    days = fillTimeArray(31, dys, 1);

    daysofweek = fillTimeArray(7, dow, 1);

    months = fillTimeArray(12, mth, 0);
  }

  public Date next() {

    int startMonth = 0;
    FINDTIME:while (true) {
      futureCal.set(Calendar.SECOND, 0);
      futureCal.set(Calendar.MILLISECOND, 0);
      if ( (startMonth =
            Arrays.binarySearch(months, calendar.get(Calendar.MONTH))) < 0) {
        startMonth = 0;
      }
      for (int lastMon = startMonth; lastMon < months.length; lastMon++) {
        futureCal.set(Calendar.MINUTE, 0);
        futureCal.set(Calendar.HOUR_OF_DAY, 0);
        futureCal.set(Calendar.DAY_OF_MONTH, 1);
        futureCal.set(Calendar.MONTH, months[lastMon]);

        for (int lastDays = 0; lastDays < days.length; lastDays++) {
          futureCal.set(Calendar.DAY_OF_MONTH, days[lastDays]);

          for (int lastHour = 0; lastHour < hours.length; lastHour++) {
            futureCal.set(Calendar.HOUR_OF_DAY, hours[lastHour]);

            for (int lastMin = 0; lastMin < minutes.length; lastMin++) {
              futureCal.set(Calendar.MINUTE, minutes[lastMin]);

              if (futureCal.after(calendar) &&
                  Arrays.binarySearch(daysofweek,
                                      futureCal.get(Calendar.DAY_OF_WEEK)) >= 0) {
                calendar.setTime(futureCal.getTime());
                break FINDTIME;
              }
            }
          }
        }
      }
      futureCal.add(Calendar.YEAR, 1);
    }

    return calendar.getTime();
  }

  private int[] fillTimeArray(int total_size, String params, int offset) {
    int[] timearray = null;
    params.trim();

    if (params.equals("*")) {
      return fillArray(total_size, offset);
    }
    else {
      if (params.indexOf("-") > 0) {
        StringTokenizer st = new StringTokenizer(params, "-");
        int aStart = Integer.parseInt(st.nextToken());
        int aEnd = Integer.parseInt(st.nextToken());
        timearray = new int[ (aEnd - aStart) + 1];
        for (int a = 0; a < timearray.length; a++) {
          timearray[a] = a + aStart + offset;
        }
      }
      else {
        int a = 0;
        StringTokenizer st = new StringTokenizer(params, ",");
        timearray = new int[st.countTokens()];

        while (st.hasMoreTokens()) {
          timearray[a] = Integer.parseInt(st.nextToken()) + offset;
          a++;
        }
      }

      Arrays.sort(timearray);
      return timearray;
    }
  }

  private int[] fillArray(int size, int offset) {
    int[] time = new int[size];
    for (int a = 0; a < size; a++) {
      time[a] = a + offset;
    }
    return time;
  }

}
