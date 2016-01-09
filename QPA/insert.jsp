<%@page import="java.sql.*" %>
<%@page import="java.sql.Statement" %>




<%


	Connection con = null;
	try{
		//Class.forName("org.gjt.mm.mysql.Driver").newInstance();
		Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
		//String protocol = "jdbc:mysql://localhost:3306/NSURS?user=reza&password=reza";
		//con = DriverManager.getConnection(protocol);
		con = DriverManager.getConnection("jdbc:odbc:" + "nsursDatabase", "","");
	} catch (Exception e){
		System.out.println(e);
		out.println("error getting connection");
	}		

	ResultSet result = null;
	Statement select = con.createStatement();
	String query ="";


//////////////////////////////////////////

	// String ID = request.getParameter("ID");
	String ID = "993239040";
	String password = "reza";
	String firstName = "Hassan";
	String lastName = "Khan";
	String address = "Mouchaq,Dhaka 1217";
	String phone = "9348463";
	String email = "reza@dhakabd.com";

	query = "INSERT INTO studentInfo values("+ID+",'"+password+"','"+firstName+"','"+lastName+"','"+address+"','"+phone+"','"+email+"')";

	try{
		select.executeQuery(query);
	}catch (Exception e){
		System.out.println(e);
		out.println("Error inserting");
	}


	
		



///////////////////////////////////////////

	if(con!=null){
		con.close();
	}

%>

	
