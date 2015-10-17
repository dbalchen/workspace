package com.uscc.timer;

import java.util.TimerTask;

/**
 * A task that can be scheduled for recurring execution by a {@link Scheduler}.
 */
public abstract class SchedulerTask
    implements Runnable {
  /** Date File was Last Modified */
  public static final String LASTMODIFIEDDATE =
      "$Date:   09 Jan 2006 14:05:14  $";
  /** Version of this file */
  public static final String LASTMODIFIEDVERSION = "$Revision:   1.0  $";
  /** Last person to modify this file */
  public static final String LASTMODIFIEDBY = "$Author:   md1dbal1  $";

  final Object lock = new Object();

  int state = VIRGIN;
  static final int VIRGIN = 0;
  static final int SCHEDULED = 1;
  static final int CANCELLED = 2;

  TimerTask timerTask;

  /**
   * Creates a new scheduler task.
   */

  protected SchedulerTask() {
  }

  /**
   * The action to be performed by this scheduler task.
   */

  public abstract void run();

  /**
   * Cancels this scheduler task.
   * <p>
   * This method may be called repeatedly; the second and subsequent calls have no effect.
   * @return true if this task was already scheduled to run
   */

  public boolean cancel() {
    synchronized (lock) {
      if (timerTask != null) {
        timerTask.cancel();
      }
      boolean result = (state == SCHEDULED);
      state = CANCELLED;
      return result;
    }
  }

  /**
   * Returns the <i>scheduled</i> execution time of the most recent actual execution of this task. (If this method is invoked while task execution is in progress, the return value is the scheduled execution time of the ongoing task execution.)
   * @return the time at which the most recent execution of this task was scheduled to occur, in the format returned by <code>Date.getTime()</code>. The return value is undefined if the task has yet to commence its first execution.
   */

  public long scheduledExecutionTime() {
    synchronized (lock) {
      return timerTask == null ? 0 : timerTask.scheduledExecutionTime();
    }
  }

}
