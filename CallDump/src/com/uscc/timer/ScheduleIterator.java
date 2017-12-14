package com.uscc.timer;

import java.util.Date;

/**
 * Implementations of <code>ScheduleIterator</code> specify a schedule as a series of <code>java.util.Date</code> objects.
 */

public interface ScheduleIterator {
  /** Date File was Last Modified */
  public static final String LASTMODIFIEDDATE =
      "$Date:   09 Jan 2006 14:05:14  $";
  /** Version of this file */
  public static final String LASTMODIFIEDVERSION = "$Revision:   1.0  $";
  /** Last person to modify this file */
  public static final String LASTMODIFIEDBY = "$Author:   md1dbal1  $";

  /**
       * Returns the next time that the related {@link SchedulerTask} should be run.
   * @return the next time of execution
   */
  public Date next();
}
