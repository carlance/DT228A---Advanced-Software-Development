<?php
/**
 * @author Carl Lawrence Mariano
 * definition of the User DAO (database access object)
 */
class UsersDAO {
	private $dbManager;
	function UsersDAO($DBMngr) {
		$this->dbManager = $DBMngr;
	}
	function getUsers() {
		$sql = "SELECT * ";
		$sql .= "FROM users ";
		$sql .= "ORDER BY users.name; ";

		$result = $this->dbManager->executeQuery ( $sql );
		$arrayOfResults = $this->dbManager->fetchResults ( $result );
		return $arrayOfResults;
	}
	function insertUser($parameterArray) {
		//create an INSERT INTO sql statement (reads the parametersArray - this contains the fields submitted in the HTML5 form)

		$name= $parameterArray['name'];
		$surname=$parameterArray['surname'];
		$email=$parameterArray['email'];
		$password=$parameterArray['password'];

		//execute the query
		$query = "INSERT INTO users (name, surname, email, password)
							VALUES ('$name', '$surname', '$email', '$password')";
		$result = $this->dbManager->executeQuery ($query);
		//$arrayOfResults = $this->dbManager->fetchResults ( $result );
		//return $arrayOfResults;;

	}
}
?>
