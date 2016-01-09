<jsp:usebean id='Testing' scope='page' class='Test' />

			scope='request'
			scope='application'



<%


out.println(Testing.printName());
Testing.printPhone();
Testing.printAdd();
String name = Testing.printName();

%>


<%=name%>