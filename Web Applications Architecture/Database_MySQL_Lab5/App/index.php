
<html>
<head>
<title>DB week 5</title>
 <link rel="stylesheet" href="css/style.css" />
</head>
<body>
<!-- 	<form method="get"	action="insertNewUser.php" > -->

<!-- 		<h3>First name :</h3> -->
<!-- 		<input type="text" name="name" placeholder="Insert your first name"><br> -->
<!-- 		<h3>Surname :</h3> -->
<!-- 		<input type="text" name="surname" placeholder="Insert your last name"><br> -->
<!-- 		<h3>EmailID:</h3> -->
<!-- 		<input type="email" name="email" placeholder="Insert your email Id"><br> -->
<!-- 		<h3>Password:</h3> -->
<!-- 		<input type="password" name="password" -->
<!-- 			placeholder="Insert your password"><br> <input type="submit" -->
<!-- 			value="Submit"> -->
			
		<!-- Can reset form this way	-->
		<!--   <input type="button" onclick="this.form.reset();" value="Reset">-->
		
		<!-- Or this way	-->
		<!--  <input type="button" name="clear" value="Clear" onclick="clearForm(this.form);">-->
		
<!-- 	</form> -->
<!-- 	<script src="js/reset_form.js"></script> -->
	
	<div id="page">
      <h1>List King</h1>
      <h2>Add User</h2>
      <form method="get" action="listUsers.php">
       <input type="submit" id="listusers" value="List Users" />
      	</form>
      	
      <form method="get" action="insertNewUser.php"  id="newuser">

        <label for="name">Add Firstname: </label>
        <input type="text" id="firstname" name="name" required />
        <div id="feedback1" class="warning"></div>
		
		<label for="surname">Add Lastname: </label>
        <input type="text" id="lastname"  name="surname" required />
        <div id="feedback2" class="warning"></div>
		
		<label for="email">Add Email: </label>
        <input type="email" id="email" name="email" required />
   		<div id="feedback3" class="warning"></div>	
   			
        <label for="password">Create a password: </label>
        <input type="password" id="password" name="password" required  />
        <div id="feedback4" class="warning"></div>
  
        
		<input type="reset" value="Reset" />		
        <input type="submit" value="Add User" /><br/>
        <div id="termsHint" class="tip"></div>      
         
      </form>
      
    </div>
    <script src="js/event-handler.js"></script>
	
</body>
</html>


<?php

?>