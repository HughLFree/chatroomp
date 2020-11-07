package chatroomplus;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Date;
import java.util.Properties;
/**
 * Servlet implementation class SendEmailServlet
 */
@WebServlet("/SendEmailServlet")
public class SendEmailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendEmailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try{
			
			request.setCharacterEncoding("UTF-8");
			String from="";//！！！！
			String to=request.getParameter("to");
			String frompassword="";//！！！！
			
			//获得系统的时间，单位为毫秒,转换为妙
			long totalMilliSeconds = System.currentTimeMillis();
			long totalSeconds = totalMilliSeconds / 1000;
			
			HttpSession session = request.getSession(); 
			session.setAttribute("mytime1",totalSeconds);
			
			String she=to+"&"+totalSeconds;		
			String he=MD5.getMD5(she,she.length());
			
			session.setAttribute("myhe",he);
			
			String subject="请您尽快修改你的密码";
			String url="http://localhost:8080/chatroomplus/changepass.jsp?email2="+to+"&he="+he;
			String messageText="请点击链接，8分钟内修改密码。"+url;
			
			int n=from.indexOf('@');
			int m=from.length();
			String mailserver="smtp."+from.substring(n+1,m);
			Properties pro=new Properties();
			pro.put("mail.smtp.host", mailserver);
			pro.put("mail,smtp.auth", "True");
			pro.put( "mail.smtp.port", "587" );
			Session sess=Session.getInstance(pro);
			
			sess.setDebug(true); //show debug
			MimeMessage message=new MimeMessage(sess);
			InternetAddress from_mail= new InternetAddress(from);
			message.setFrom(from_mail);
			InternetAddress to_mail= new InternetAddress(to);
			message.setRecipient(Message.RecipientType.TO, to_mail);
			message.setSubject(subject);
		    message.setSentDate(new Date());
		    message.setText(messageText);
		    Transport transport=sess.getTransport("smtp");
		    transport.connect(mailserver,from,frompassword);
		    transport.sendMessage(message, message.getAllRecipients());
		    transport.close();
		    request.setAttribute("over","发送成功");
		    RequestDispatcher rd= request.getRequestDispatcher("index.jsp");
		    rd.forward(request,response);
		    
			
		}catch(Exception e){
			request.setAttribute("over","发送失败");
		    RequestDispatcher rd= request.getRequestDispatcher("index.jsp");
		    rd.forward(request,response);
		    e.printStackTrace();
		}
	}

}
