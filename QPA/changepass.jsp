<%@page import="java.sql.*" %>
<%@page import="java.sql.Statement" %>



<%

if(request.getParameter("oldPass")==null)
{	%>

<html>
<title>Change password for student.</title>
<head>
<link rel='stylesheet' type='text/css' href='css/style.css' />
</head>
<body>
<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>
	<span id='supertitle'> .:: Password Change Form ::. </span><br><br>
<form action='changepass.jsp' method='post'>
    <p>
	<table border='0'>
		<tr><td id='tdtitle'>Previous Password : </td><td><input type='password' name='oldPass' size="20" /> </td><td id='tdguide'> >>> Enter your old password.</td></tr>
		<tr><td id='tdtitle'>New Password : </td><td><input type='password' name='newPass1' size="20" /> </td><td id='tdguide'>>>> Enter your new prefered password.</td></tr>
		<tr><td id='tdtitle'>Confirm Password : </td><td><input type='password' name='newPass2' size="20" /> </td><td id='tdguide'>>>> Confirm your new password by re-entering it.</td></tr>		
		<tr><td><input type='submit' value='.:: Submit ::.' /></td><td><input type='submit' value='.:: Reset ::.' /></td></tr>
	</table>
    </p>
</form>
<br/><br /><a href="javascript:history.back(1)">Click</a> back if you don't want to change password.</b><br>

</body>
</html> 

<% }



else
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
	String ID = (String)session.getAttribute("ID");

///////////////////////////////////////////////////////////////////////////////
	query = "SELECT * FROM studentInfo";

	result = select.executeQuery(query);
	
	boolean	match = false;
	boolean sameNewPass = newPass1.equals(newPass2);

	while(!match && result.next())
	{
		if(result.getString("ID").equals(ID))
		{
			if(result.getString("password").equals(oldPass))
			{
				match = true;
				break;
			}
		}
	}

	// Tracing in console
	System.out.println("ID and password matched : " + match);
	System.out.println("New Pass were same : " + sameNewPass);

	if( match && sameNewPass)
	{
		query = "UPDATE studentInfo SET password = '"+newPass1+"' WHERE ID = '"+ID+"'";


		try{
			select.executeUpdate(query);
%>

<html>
<title>Change password for student.</title>
<head>
<link rel='stylesheet' type='text/css' href='css/style.css' />
</head>
<body>
<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>
<br><span id='title'> Your password has been changed successfully.<br></span>

<p>&nbsp;</p>
	<center>
	<a href="login.html">LOG IN BACK</a> to do advising. or,<br />
	<b> Please <a href="logout.html">LOG OUT</a> and Close this window before leaving.</b>
	</center>
</body>
</html>


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

<html>
<title>Change password for student.</title>
<head>
<link rel='stylesheet' type='text/css' href='css/style.css' />
</head>
<body>
<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>
<br><span id='error'> Sorry! the password you given is not correct <br> or the new passwors missmatched.<br>
<a href="javascript:history.back(1)"><b>Click Back</a></b> and re-try.<br /></span>
</body>
</html>	


<%
	}
}
%>