<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.Connection,
java.sql.DriverManager,
java.sql.PreparedStatement,
java.sql.ResultSet,
java.sql.SQLException,
java.util.*"%>
<!DOCTYPE html>
<html>
<head>
 <title>FitEasy : Biometrics</title>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    
  <link rel="stylesheet" type="text/css" href="css/biometrics.css">
</head>

<body background="">


<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
         <!-- <span class="icon-bar"></span>  -->   <!-- may be removed -->
         <!-- <span class="icon-bar"></span> -->     <!--  may be removed -->
         <!-- <span class="icon-bar"></span>  -->     <!-- may be removed -->                    
      </button>
      <a class="navbar-brand" href="#">FitEasy</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
     <!--  <ul class="nav navbar-nav"> -->
        <!-- <li class="active"><a href="#">Home</a></li>
        <li><a href="#">Workout Plans</a></li>
        <li><a href="#">Contact</a></li> -->
      <!-- </ul> -->
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
      </ul>
    </div>
  </div>
</nav>

  
<div id="img" class="container-fluid text-center">    
  <div id="img" class="jumbotron row content">
    <!-- <div class="col-sm-2 sidenav">
      <p><a href="#">Link</a></p>
      <p><a href="#">Link</a></p>
      <p><a href="#">Link</a></p>
    </div> -->
    <div class="card-group">
    <div class="card border-0" id="card1">
    <div class="col-sm-12 text-left card-body"> 
      <center><h2 class="card-title" id="id2">Welcome</h2></center>
      <p class="card-text"><center><h3 id="id3">Enter your biometric details
  to choose workout plan :-</h3></center></p>
      

      <form name="bioform" onsubmit="return workPlanFunc()">
  <div class="form-group">
    <label for="height">Your Height (in centimeters) :</label>
    <input type="text" class="form-control" id="height" placeholder="Enter your height" required>
  </div>

  <div class="form-group">
    <label for="weight">Your Weight (in kilograms) :</label>
    <input type="text" oninput="" class="form-control" id="weight" placeholder="Enter your Weight" required>
  </div>

  <div class="form-group">
    <label for="age">Your Age (in years) :</label>
    <input type="text" class="form-control" id="age" placeholder="Enter your Age" required>
  </div>

<p><label for="male female">Enter your Gender :</label></p>

  <div class="form-check">
	  <input class="form-check-input" type="radio" name="radgender" id="male" value="Male" required>
	  <label class="form-check-label" for="male">Male</label>
  </div>

<div class="form-check">
  <input class="form-check-input" type="radio" name="radgender" id="female" value="Female" required>
  <label class="form-check-label" for="female">Female</label>
</div>

  <p><label for="light heavy">Choose your workout plan :</label></p>

  <div class="form-check">
	  <input class="form-check-input" type="radio" name="radplan" id="light" value="Light" checked>
	  <label class="form-check-label" for="light">Light</label>
  </div>

<div class="form-check">
  <input class="form-check-input" type="radio" name="radplan" id="heavy" value="Heavy">
  <label class="form-check-label" for="heavy">Heavy</label>
</div>

  <center>
  <button type="submit" class="btn btn-primary">Submit</button>
</center>
<br><br><br><br>
</form>
      
    </div>
</div>

<%
double height = Double.parseDouble(request.getParameter("height"));
double weight = Double.parseDouble(request.getParameter("weight"));
int age = Integer.parseInt(request.getParameter("age"));
String email = "srghytr@gmail.com";//request.getParameter("email");
String gender = request.getParameter("gender");


if(height != 0 && weight != 0 && age != 0 && gender != null){

try{

	Class.forName("com.mysql.jdbc.Driver");

	Connection dbCon = DriverManager.getConnection("jdbc:mysql://localhost:3306/workout_tracker", "root", "");
	PreparedStatement theStatement;
	
	String insertQry = "INSERT INTO `user_biometrics`(`email`, `gender`, `height`, `weight`, `age`) VALUES (?,?,?,?,?)";
            	      
            theStatement = dbCon.prepareStatement(insertQry);
            theStatement.setString(1, email);
			theStatement.setString(2, gender);
			theStatement.setDouble(3, height);
			theStatement.setDouble(3, weight);
			theStatement.setDouble(3, age);
			//Execute the query
			if(theStatement.executeUpdate() > 0) {
				System.out.println("User details inserted...");
			}
			else
			{
				System.out.println("Some issues...");
			}
            } 
            catch (Exception ex) {
            out.println("Unable to connect to database.");
 			}
            /* finally {
            // close all the connections.
            theStatement.close();
            dbCon.close();
            } */
            }%>

<div class="card border-0" id="card2">
    <div class="col-sm-12 card-body"> 
    	<center><h2 class="card-title" id="id4">Result</h2></center>
    	<p class="card-text" id="resultantText"><center><h3 id="id5"><!-- Please fill the Gender and Height to know the result . --></h3></center></p>
    	<br><br><br><br>
    	<button type="button" onclick="idealWeight()" id="resultButton" class="btn btn-primary"><b>Check Ideal Body Weight</b></button>
    </div>
</div>
</div>
    <!-- <div class="col-sm-2 sidenav">
      <div class="well">
        <p>ADS</p>
      </div>
      <div class="well">
        <p>ADS</p>
      </div>
    </div> -->
  </div>
</div>

<div class="foot">
<footer class="container-fluid text-center">
  <p>Footer Text</p>
</footer>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="js/biometrics.js"></script>
</body>
</html>

