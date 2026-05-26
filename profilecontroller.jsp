<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
 String otp=   request.getParameter("otp");

  HttpSession httpSession=  request.getSession();
    String username=(String)   httpSession.getAttribute("username");
    
      try{
    	  
    	  Class.forName("com.mysql.cj.jdbc.Driver");
          Connection conn= 	DriverManager.getConnection("jdbc:mysql://localhost:3306/fsak", "root","root");
  PreparedStatement pst=   conn.prepareStatement("select *from owner where name='"+username+"' AND otp='"+otp+"'");
       ResultSet rs=  pst.executeQuery();
     
       if(rs.next()){
		response.sendRedirect("DataProviderMain.jsp");

       }
       else{
			response.sendRedirect("WrongLogin.html");

       }
      
      }catch(Exception e){
    	  e.printStackTrace();
      }
    
    
%>

</table>
</center>
</body>
</html>