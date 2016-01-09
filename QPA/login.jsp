<%@page import="java.io.*" %>
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

	String ID = request.getParameter("ID");
	String password = request.getParameter("password");
	String stdName="";
	String alreadyAdvised ="";
	String CGPA="";
	double cgpa = 0.0;
	boolean cgpaOK = true;
	
	/**************** FIRST CHECK FOR ADMIN ********************/
	session.setAttribute("ID",ID);

	query = "SELECT * FROM adminInfo";

	result = select.executeQuery(query);

	
	boolean	adminmatch = false;

	while(!adminmatch && result.next())
	{
		if(result.getString("adminID").equals(ID))
		{
			if(result.getString("password").equals(password))
			{
				adminmatch = true;
				%>
				<input type='hidden' name='isadmin' value='true' />
				<%
				response.sendRedirect("adminControl.jsp");
			}
		}
	}
	/************************************************************/
	
	
	
	
	
	
	
	query = "SELECT * FROM studentInfo";

	// out.println(query);
	result = select.executeQuery(query);
	
	boolean	match = false;

	while(!match && result.next())
	{
		if(result.getString("ID").equals(ID))
		{
			if(result.getString("password").equals(password))
			{
				match = true;
				stdName=result.getString("firstName") + "&nbsp;" + result.getString("lastName");
				alreadyAdvised = result.getString("alreadyAdvised");
				CGPA = result.getString("CGPA");
				break;
			}
		}
	}
	try
	{
		cgpa = Double.parseDouble(CGPA);
	}
	catch(Exception e)
	{
		cgpaOK=false;
		System.out.println("Exception occured during CGPA convertion ");
	}
	if(cgpa >= 2.00 && cgpa <=4.00)
	{
		cgpaOK = true;
		System.out.println("Inside condition : (cgpa >= 2.00 && cgpa <=4.00)" + (cgpa >= 2.00 && cgpa <=4.00));
	}
	else cgpaOK = false;

	System.out.println(CGPA + " < CGPA was OK  : " + cgpaOK);
	System.out.println("ID and password matched : " + match);
	if(match)
	{%>

<html>
<head>
<title>Login</title>
<link rel='stylesheet' type='text/css' href='css/style.css' />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>

<% 
	session.setAttribute("ID",ID);
%>


<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>
	<span id='title'> Welcome&nbsp;<%=stdName%>!! You have successfully logged in.</span> <br /> <br />
	<span id='caption'>User Information for #<%=ID%>
		<table id='studentInfoTable'>
		    <tr><td id='td1' colspan='2'> Basic Information </td></tr>
		    <tr><td> Name </td> <td><%=stdName%> </td></tr>
		    <tr><td> Address </td><td> <%=result.getString("address")%></td></tr>  	
		    <tr><td> Phone </td><td> <%=result.getString("phone")%> </td></tr>  
		    <tr><td> e-mail </td><td> <%=result.getString("email")%> </td></tr>  

		    <tr><td id='td1' colspan='2'> Academic Information </td></tr> 
		    <tr><td> Core Course Done </td><td> <%=result.getString("coreDone")%> </td> </tr>
		    <tr><td> Additional Course Done </td><td> <%=result.getString("othersDone")%> </td></tr>
		    <tr><td> CGPA  </td><td> <%=CGPA%> </td></tr> 
		</table>

<%
	if(cgpaOK)
	{
		if(alreadyAdvised.equals("True") )
		{
			//put error HTML CODE
		%>
			<br /><span id='error'>Sorry,&nbsp;<%=stdName%>&nbsp; our database record says that<br>
					<b>you are already advised</b> for this semster.<br>
					If you have any question or problem regarding this,<br>
					please contact Administrator or Advisor.<br /><br /></span>
					<br/> You can still Change your password.
		<%
		}
		else
		{
		%>
			<a href = changedocs.jsp>Edit google docs</a><br>
		<%
		}
	} //end of if(cgpa is OK)
	else
	{
	%>
		<br /><span id='error'>Sorry, &nbsp;<%=stdName%>&nbsp; our database record says that<br>
					<b>your CGPA doesn't meet the minimum requirement </b><br>
					If you have any question or problem regarding this,<br>
					please contact Administrator or Advisor for special advising.<br /><br /></span>
					<br/> You can still Change your password.<br />
					
	<%
	} // end of else (where cgpa was not ok)
	%>
		
		<a href = changepass.jsp>Change Password</a>



	<% } else { %>
<html>
<head>
<title>Login</title>
<link rel='stylesheet' type='text/css' href='css/style.css' />
</head>

<body>

<center><p><img border="0" src="images/ves.jpg" width="645" height="39"></p></center>

<p>&nbsp;</p>

<form action='login.jsp' method='post'>
	<br>
    <span id='error'>Wrong userID/password. </span><br /><BR>
    <p><b>ID : </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    <input type='text' name='ID' size="20" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;
    <font color="#0000FF">Enter your 9 digit <b>NSU </b>ID</font><br>
    <br />
	<b>Password : </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    <input type='password' name='password' size="20" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    &gt;&gt;&nbsp; <font color="#0000FF">Enter your Password</font><br />
	<br>
	<input type='submit' value='Login' />&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="reset" value="Reset"></p>
	
</form>

<p>&nbsp;</p>
<p>&nbsp;</p>
<center><hr size="2" color="#FFCC00">
<br><center>
<font face="Times New Roman" size="2">Copyright © Hossain & Ifti. All Rights Reserved
2004.</font></center>

    </span>

</body>
</html>
	<%}


///////////////////////////////////////////

	if(con!=null){
		con.close();
	}

%>