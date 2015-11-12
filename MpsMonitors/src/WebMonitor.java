import java.util.Calendar;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Vector;
import java.util.Hashtable;
import com.uscc.monitor.GetReports;
import com.uscc.monitor.XMLReader;
import com.uscc.monitor.LogWriter;

/**
 *
 * <p>
 * <b>Title: </b>WebMonitor
 * </p>
 * <p>
 * <b>Description: </b>This java servlet is the main Web Interface for the Mps
 * Monitors. When called with a browser it will read the parameters and return
 * the proper screen. If called with no parameters it will return the Main
 * selection Screen.
 * </p>
 * <p>
 * <b>Copyright: </b>Copyright (c) 2005
 * </p>
 * <p>
 * <b>Company: </b> US Cellular
 * </p>
 *
 * @author David Balchen
 * @version 2.0
 */

public class WebMonitor
    extends HttpServlet {

  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

private Vector<Hashtable<String, String>> WebTemplates = null;

  private XMLReader xml = null;

  private GetReports reports = null;

  private LogWriter log = null;

  public void init(ServletConfig config) throws ServletException {
    super.init(config);

    ServletContext context = getServletContext();
    xml = new XMLReader(context.getRealPath("/monitor.xml"));
        //xml = new XMLReader("unit/monitor.xml");
    try {
      log = new LogWriter(context.getRealPath("/"), "WebMonitor.log");
           //log = new LogWriter("/", "WebMonitor.log");

      reports = new GetReports(xml, log);
      reports.start();

      WebTemplates = xml.getSubTree("SERVLET");
      for (int a = 0; a < WebTemplates.size(); a++) {
        if ( ( ( (Hashtable<String, String>) WebTemplates.get(a)).get("TAG_NAME"))
            .trim().equalsIgnoreCase("TEMPLATE")) {

          String file = ( ( (Hashtable<String, String>) WebTemplates.get(a))
                         .get("file")).trim();

          file = LoadTemplate(context.getRealPath("/" + file));
                   //file = LoadTemplate(file);
          ( (Hashtable<String, String>) WebTemplates.get(a)).put("template", file);
        }
      }
    }
    catch (Exception e) {
      System.out.println("Could not open template files");
      e.printStackTrace();
    }
  }

  private String LoadTemplate(String Filename) throws Exception {
    String buffOut = new String();
    String buff = new String();

    BufferedReader in = new BufferedReader(new FileReader(Filename));

    while ( (buff = in.readLine()) != null) {
      buffOut = buffOut + buff;
    }
    in.close();
    return buffOut;
  }

  /**
   * The main entry point for the servlet.
   *
   * @param request
   * @param response
   * @throws IOException
   * @throws ServletException
   */

  public void doGet(HttpServletRequest request, HttpServletResponse response) throws
      IOException, ServletException {

    // Sets output as HTML.
    response.setContentType("text/html");

    PrintWriter out = response.getWriter();

    // Gets the MonName parameter from the browser.
    String MonSelect = request.getParameter("MonName");

    // If the MonSelect variable is not NULL then perform this.
    if (MonSelect != null) {

      String tmpl = getTemplate(MonSelect);

      if (tmpl == null) {
        tmpl = getMonitor(request);
        if (tmpl == null) {
          tmpl = "Nothing to see here";
        }
      }
      out.println(addDateTime(tmpl));
    }
    else {
      out.println(addDateTime(getTemplate("default")));
    }
    out.close();
  }

  private String addDateTime(String b4date) {
    int Index = 0;
    Calendar CAL = Calendar.getInstance();

    if ( (Index = b4date.indexOf("!HH:MM:SS")) >= 0) {

      String TIME = PadZero(Integer.toString(CAL.get(Calendar.HOUR)));
      if (TIME.equals("00")) {
        TIME = "12";
      }
      TIME = TIME + ":"
          + PadZero(Integer.toString(CAL.get(Calendar.MINUTE))) + ":"
          + PadZero(Integer.toString(CAL.get(Calendar.SECOND)));

      b4date = b4date.substring(0, Index) + TIME
          + b4date.substring(Index + 9);
    }

    if ( (Index = b4date.indexOf("!MM:DD:YYYY")) >= 0) {

      String DATE = PadZero(Integer.toString(CAL.get(Calendar.MONTH) + 1))
          + "/"
          + PadZero(Integer.toString(CAL.get(Calendar.DATE)))
          + "/" + PadZero(Integer.toString(CAL.get(Calendar.YEAR)));

      b4date = b4date.substring(0, Index) + DATE
          + b4date.substring(Index + 11);
    }
    return b4date;
  }

  private String getTemplate(String key) {

    for (int a = 0; a < WebTemplates.size(); a++) {
      try {
        String tempkey = ( ( ( (Hashtable<String, String>) WebTemplates.get(a))
                            .get("key")).trim());

        if (tempkey.equalsIgnoreCase(key)) {
          return ( ( ( (Hashtable<String, String>) WebTemplates.get(a))
                    .get("template")).trim());
        }
      }
      catch (Exception e) {
        //Ignore exception
      }
    }
    return null;
  }

  // This method adds zeros to the front of any string that it is passed.
  private String PadZero(String ToPad) {
    if (ToPad.length() == 1) {
      ToPad = "0" + ToPad;
    }
    return ToPad;
  }

  /**
   * This method calls the MpsMonitor server which is running on each
   * production machine.
   *
   * @param CallWith
   *            Which machine information.
   * @return
   */
  //
  public String getMonitor(HttpServletRequest req) {

    return reports.getWebReport(req.getParameter("MonName"), req
                                .getParameter("MARKET"));
  }

}
