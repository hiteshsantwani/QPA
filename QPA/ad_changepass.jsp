<%@page import="java.sql.*" %>
<%@page import="java.sql.Statement" %>


<html>
<title>Change password for admin.</title>
<head>
<link rel='stylesheet' type='text/css' href='css/style.css' />
</head>
<body>
<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>
	<span id='supertitle'> .:: Password Change Form ::. </span><br><br>
<form action='ad_changepass.jsp' method='post'>
    <p>
	<table border='0'>
		<tr><td id='tdtitle'>Previous Password : </td><td><input type='password' name='oldPass' size="20" /> </td><td id='tdguide'> >>> Enter your old password.</td></tr>
		<tr><td id='tdtitle'>New Password : </td><td><input type='password' name='newPass1' size="20" /> </td><td id='tdguide'>>>> Enter your new prefered password.</td></tr>
		<tr><td id='tdtitle'>Confirm Password : </td><td><input type='password' name='newPass2' size="20" /> </td><td id='tdguide'>>>> Confirm your new password by re-entering it.</td></tr>		
		<tr><td><input type='submit' value='.:: Submit ::.' /></td><td><input type='submit' value='.:: Reset ::.' /></td></tr>
	</table>
    </p>
</form>
<%
if(request.getParameter("oldPass")!=null)
{

////////////////////////////////////////////////////////////////////////////

	Connection con = null;
	try
	{
		//Class.forName("org.gjt.mm.mysql.Driver").newInstance();
		Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
		//String protocol = "jdbc:mysql://localhost:3306/NSURS?user=reza&password=reza";
		//con = DriverManager.getConnection(protocol);
		con = DriverManager.getConnection("jdbc:odbc:" + "nsursDatabase", "","");
	} 
	catch (Exception e)
	{
		System.out.println(e);
		out.println("error getting connection");
	}				

	ResultSet result = null;
	Statement select = con.createStatement();
	String query ="";

	String oldPass = request.getParameter("oldPass");
	String newPass1 = request.getParameter("newPass1");
	String newPass2 = request.getParameter("newPass2");
	String dbPass = "";
	String ID = (String)session.getAttribute("ID");

///////////////////////////////////////////////////////////////////////////////
	query = "SELECT * FROM adminInfo";

	result = select.executeQuery(query);
	boolean sameNewPass = newPass1.equals(newPass2);
	
	while(result.next())
	{
		if(result.getString("adminID").equals(ID))
		{
				dbPass = result.getString("password");
				System.out.println("ADMIN ID FOUND > SAVING PASS ");
		}
	}

	boolean sameOldPass = dbPass.equals(oldPass);
	// Tracing in console
	System.out.println("New Pass were same : " + sameNewPass);
	
	if(sameNewPass && sameOldPass)
	{
		query = "UPDATE adminInfo SET password = '"+newPass1+"' WHERE adminID = '"+ID+"'" ;
		//query = "UPDATE adminInfo SET password = '"+newPass1+"'";
		try
		{
			System.out.println(query);
			select.executeUpdate(query);
%>
			<br><span id='title'> Your password has been changed successfully.<br></span>
<%
		}
		catch (Exception e)
		{
			System.out.println(e);
			out.println("Error updating");
		}
	}
	else
	{
%>
<br><span id='error'> Sorry! the password you given is not correct <br> or the new password mis-matched.<br></span>
<%
	}
}
%>
<br><span id='error'>
	<a href="adminControl.jsp">Back to Control Panel</a>
<br></span>
</body>
</html>