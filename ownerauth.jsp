<title>Authentication Page</title>
<%@ include file="connect.jsp" %>
<%@ page import="java.util.Date" %>
<%
   	String name=request.getParameter("userid");      
   	String pass=request.getParameter("pass");
	
    try{
			application.setAttribute("owner",name);
			String sql="SELECT * FROM owner where name='"+name+"' and pass='"+pass+"'";
			Statement stmt = connection.createStatement();
			ResultSet rs =stmt.executeQuery(sql);
			String utype="";
			if(rs.next()){
			 String username=	  rs.getString("name");
				  HttpSession httpSession=  request.getSession();
                   httpSession.setAttribute("username", name);
				
				//response.sendRedirect("DataProviderMain.jsp");
				response.sendRedirect("generateotp.html");

			}
			else
			{
				response.sendRedirect("WrongLogin.html");
			}
		
	}
	catch(Exception e)
	{
		out.print(e);
	}
%>