
<style>
<?php include 'css/table.css'; ?>
</style>


<?php
require_once 'DB/dbmanager.php';
require_once 'DB/DAO/UsersDAO.php';


$dbmanager = new DBManager();
$userDAO = new UsersDAO($dbmanager);

$dbmanager->openConnection();

$result=$userDAO->getUsers();
//echo $result;

	//echo "<li>".$value['name']." ".$value['surname']." ".$value['email']."</li>";
	
	echo '
				<!DOCTYPE html>
				<html>
				<head>
				</head>
					<div id="page">
					<table>
						<tr class="head">
						<th>ID</th>
						<th>Name</th>
						<th>Surname</th>
						<th>Email</th>
						</tr>';
	
		
	foreach ( $result as $key => $value ) {
	
		echo '<html>
							<head>
								<title>List of Users</title>
							</head>
						  </html>';
	
		//echo "<li>" . $value ['name'] . " " . $value ['surname'] . " " . $value ['email'] . "</li>";
	
		echo '<tr class ="even">
				      <td>'. $value ['id'] . '</td>
					  <td>'. $value ['name'] . '</td>
					  <td>'. $value ['surname'] . '</td>
					  <td>'. $value ['email'] . '</td>
					  </tr>';
	
	}
		
	echo '</table>
					</div>
				 </html>';

$dbmanager->closeConnection();

?>