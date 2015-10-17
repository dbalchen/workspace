package com.uscc.dao;

public class DAOException extends Exception {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
     *  Constructs an exception with null as the error message.
     */
    public DAOException() {
    }

    /**
     *  Constructs an exception with the specified detail message.
     */
    public DAOException(String message) {
        super(message);
    }

    /**
     * Constructs a new throwable with the specified detail message and cause.
     */
    public DAOException(String message, Throwable cause) {
        super(message, cause);
    }

    /**
     * Constructs a new throwable with the specified cause and a detail message. <br>
     * The detailed message is: (cause==null ? null : cause.toString()). <br>
     * Which typically contains the class and detail message of cause.
     */
    public DAOException(Throwable cause) {
        super(cause);
    }
}
