

import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class otpcontroller
 */
@WebServlet("/otpcontroller")
public class otpcontroller extends HttpServlet {
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	String mobile=	 request.getParameter("mobile");
		 PrintWriter out= response.getWriter();
	   if(checkmobile(mobile)) {
		   
		String generatedOtp=   GenerateOtp(6);
		System.out.println(generatedOtp);
		
		   if(storeOtp(mobile, generatedOtp)) {
			   
		   }
		   else {
			   out.println("<script type=\"text/javascript\">"); 
		        out.println("alert('OTP SENDED  Successful');"); 
		        out.println("location='validate.html';"); 
		        out.println("</script>");
		   	
		   }
	   }
	   else {
		   out.println("<script type=\"text/javascript\">"); 
	        out.println("alert('mobile number not register');"); 
	        out.println("location='home.html';"); 
	        out.println("</script>");
	   	
	   }
	
	
	
	
		
		}
		
		//mobilevalidation
		
		private boolean checkmobile(String mobile) {
			 boolean existingmobile=false;
			 
			 try {
				 Class.forName("com.mysql.cj.jdbc.Driver");
		          Connection conn= 	DriverManager.getConnection("jdbc:mysql://localhost:3306/fsak", "root","root");
		  PreparedStatement pst=   conn.prepareStatement("select *from owner where mobile=?");
		         pst.setString(1, mobile) ;
		       ResultSet rs=  pst.executeQuery();
		         while(rs.next()) {
		        	existingmobile=true; 
		         }
		       
		       
			 }catch (Exception e) {
				// TODO: handle exception
				 e.printStackTrace();
			}
			return existingmobile;
			
			
		}
		
		
		private boolean storeOtp(String mobile,String otp) {
			
			boolean existingotp=false;
			
			try {
				
				 Class.forName("com.mysql.cj.jdbc.Driver");
		          Connection conn= 	DriverManager.getConnection("jdbc:mysql://localhost:3306/fsak", "root","root");
		  PreparedStatement pst=   conn.prepareStatement("update owner set otp='"+otp+"' where mobile='"+mobile+"'  ");
		        
		  int i=  pst.executeUpdate();
					
		  
		  
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			return existingotp;
			
		}
		
		
		

		private static String GenerateOtp(int j) {
			SecureRandom random=new SecureRandom();
			
			StringBuilder otp=new StringBuilder();
			
			for(int i=0;i<j;i++) {
				otp.append(random.nextInt(10));
			}
			
		 return	otp.toString();
			
		}
		
		
}
