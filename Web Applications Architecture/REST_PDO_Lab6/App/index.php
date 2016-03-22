<!DOCTYPE html>
<html>
<head>
</head>

<style>
<?php include 'css/layout.css'; ?>
</style>


<?php
require_once 'DB/pdoDbmanager.php';
require_once 'DB/DAO/UsersDAO.php';

require_once "../Slim/Slim.php";
Slim\Slim::registerAutoloader ();
$app = new \Slim\Slim (); // slim run-time object
require_once "conf/config.inc.php"; // include configuration file


$app->map ( "/users(/:id)", function ($elementID = null) use($app) {
	$body = $app->request->getBody (); // get the body of the HTTP request (from client)
	$decBody = json_decode ( $body, true ); // this transform the string into an associative array
	//var_dump ( $decBody );
	
	$pdoDbmanager = new pdoDbManager ();
	$usersDAO = new UsersDAO ( $pdoDbmanager );
	
	$httpMethod = $app->request->getMethod ();
	//var_dump ( $httpMethod );
	
	// initialisations
	$responseBody = null;
	$responseCode = null;
	
	
	switch ($httpMethod) {
		case "GET" :
			
			$pdoDbmanager->openConnection ();
			$result = $usersDAO->getUsers ();
			$responseCode = HTTPSTATUS_OK;
			
			echo '<table>
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
			
			echo '</table>';
			
			$pdoDbmanager->closeConnection ();
			break;
		
		case "POST" :
			$pdoDbmanager->openConnection ();
			
			// $decBody is json string from Rest Client
			$usersDAO->insertUser ( $decBody );
			$responseCode = HTTPSTATUS_CREATED;
			$pdoDbmanager->closeConnection ();
			
			break;
		case "PUT" :
			$pdoDbmanager->openConnection ();
			
			$usersDAO->updateUser ($decBody);
			$responseCode = HTTPSTATUS_OK;
			$pdoDbmanager->closeConnection ();
			
			break;
		case "DELETE" :
			$pdoDbmanager->openConnection ();
							
			$usersDAO->deleteUser($decBody);
			$responseCode = HTTPSTATUS_OK;
			$pdoDbmanager->closeConnection ();
			
			
			break;
	}
	
	// return response to client
	
	if ($responseBody != null)
		$app->response->write ( json_encode ( $responseBody ) ); // this is the body of the response
			                                                         
	// TODO:we need to write also the response codes in the headers to send back to the client
	
	$app->response->status ( $responseCode );
} )->via ( "GET", "POST", "PUT", "DELETE" );

$app->run ();
?>



</html>