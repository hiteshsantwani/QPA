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

	String ID = (String)session.getAttribute("ID");
	System.out.println("ADMIN ID GOT from SESSION is : " + ID);

	/**************** Searching for admin Validity ********************/

	query = "SELECT * FROM adminInfo";

	// out.println(query);
	result = select.executeQuery(query);
	
	boolean	invalidAdmin = true;
	if(ID==null || ID.length() ==0)
	{ 
		invalidAdmin = true;
		System.out.println("Invalid admin, came without login : " + invalidAdmin);
	}

	while(result.next())
	{
		if(result.getString("adminID").equals(ID))
		{
				invalidAdmin = false;
				System.out.println("Invalid admin ??? : " + invalidAdmin);
		}
	}
	/************************************************************/
	
	
	if(!invalidAdmin)
	{
	
%>





	<html>
	<head>
	<title>Admin Control</title>
	<link rel='stylesheet' type='text/css' href='css/style.css' />
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	</head>
	
	<body>
	
<center><p><img border="0" src="images/ves.jpg" width="645" height="109"></p></center>
	
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	<p><span id='supertitle'>.:: Welcome Administrator ::. </span></p>
	<CENTER><img src="images/admin_cp.gif" width="228" height="40"></CENTER><br/>
	 <br/>
	<span id='title'>
	   Please chose any option <span/><br>
	
	</p>
	<table id='adminPower'>
		<tr><td>1. <a href ='addCourse.jsp'>Add Course Information</a></td></tr>
		<tr><td>2. <a href ='viewCourseInfo.html'>View Course Information</a></td></tr>
		<tr><td>3. <a href ='changePreReq.jsp'>Change Course Pre-Requisite</a></td></tr>
		<tr><td>4. <a href ='changeCourseDescription.jsp'>Change Course Contents</a></td></tr>
		<tr><td>5. <a href ='ad_changepass.jsp'>Change Password</a></td></tr>
		<tr><td>6. <a href ='changeSectionTime.jsp'>Change Course Schedule</a></td></tr>
		<tr><td>7. <a href ='changeSectionLimit.jsp'>Change Course Section Limit</a></td></tr>
		<tr><td>8. <a href ='addStudent.jsp'>Add Student Information</a></td></tr>
		<tr><td>9. <a href ='viewStudentInfo.jsp'>View Student Information</a></td></tr>
		<tr><td>10. <a href ='viewSectionInfo.jsp'>View Section Information</a></td></tr>
		<tr><td>11. <a href ='changevisitorlink.jsp'>Change visitor link</a></td></tr>
		<tr><td>12. <a href ='changeeditorlink.jsp'>Change editor link</a></td></tr>
		
	</table><br/>
	
	<center><hr size="2" color="#FFCC00"><br><center>
	<font face="Times New Roman" size="2">Copyright © Santwani & friends inc. All Rights Reserved
	2014.</font></center>
	
	
	</body>
	</html>
<%
	} // end of if (logged admin was valid)
	else
	{
%>	
	

	<html>
	<head>
	<title>Admin Control</title>
	<link rel='stylesheet' type='text/css' href='css/style.css' />
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	</head>
	
	<body>
	
	<center><p><img border="0" src="images/ves.jpg" width="645" height="39"></p></center>
	
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	<h2><i><font color="#FF0000" face="Verdana, Arial, Helvetica, sans-serif">Sorry !! You don't have access to this page.</font></h2></i>
	
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	<center><hr size="2" color="#FFCC00"><br><center>
	<font face="Times New Roman" size="2">Copyright © Hossain & Ifti. All Rights Reserved
	2004.</font></center>
	
	
	</body>
	</html>

	
<%
	} // end of else (the user was not a valid admin)
	
	// closing the connection
	if(con!=null)
	{
		con.close();
	}

%>