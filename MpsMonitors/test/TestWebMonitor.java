import junit.framework.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class TestWebMonitor extends TestCase {
  private WebMonitor webMonitor = null;

  public TestWebMonitor(String name) {
    super(name);
  }

  protected void setUp() throws Exception {
    super.setUp();
    /**@todo verify the constructors*/
    webMonitor = new WebMonitor();
  }

  protected void tearDown() throws Exception {
    webMonitor = null;
    super.tearDown();
  }


  public void testWebMonitor() {
    webMonitor = new WebMonitor();
    /**@todo fill in the test code*/
  }
/*
  public void testDoGet() throws IOException, ServletException {
    HttpServletRequest request = null;
    HttpServletResponse response = null;
    ServletConfig config = null;
    webMonitor.init(config);
    webMonitor.CallMpsMonitor("m01usg1.uscc.com",8999,"WebAcpa2");
  }

  public void testInit() throws ServletException, InterruptedException {
    ServletConfig config = null;
    webMonitor.init(config);
    while (true)
    {
    	Thread.sleep(30000);
    }    
  }
*/
}
