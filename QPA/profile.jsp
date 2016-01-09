

<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.sql.Statement" %>




<%

	Connection con = null;
	try{
		Class.forName("org.gjt.mm.mysql.Driver").newInstance();
		String protocol = "jdbc:mysql://localhost:3306/NSURS?user=reza&password=reza";
		con = DriverManager.getConnection(protocol);
	} catch (Exception e){
		System.out.println(e);
		out.println("error getting connection");
	}		

	ResultSet result = null;
	Statement select = con.createStatement();
	String query ="";
         
       
	//query = "INSERT INTO studentInfo values("+ID+",'"+password+"','"+firstName+"','"+lastName+"','"+address+"','"+phone+"','"+email+"')";

	try
	{
		select.executeQuery(query);
		out.println("<br>Infos are successfully added !!<br><a href = 'course.jsp'> Insert another course </a>");
	}
	catch (Exception e)
	{
		System.out.println(e);
		out.println("Error inserting");
	}


	con.close();


%>
