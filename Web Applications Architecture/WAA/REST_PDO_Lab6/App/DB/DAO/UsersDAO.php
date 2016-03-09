<?php
/**
 * @author Luca
 * definition of the User DAO (database access object)
 */
class UsersDAO {
	private $pdoDbManager;
	
	function UsersDAO($pdoDBMngr) {
		$this->pdoDbManager = $pdoDBMngr;
	}
	function getUsers() {
		$sql = "SELECT * ";
		$sql .= "FROM users ";
		$sql .= "ORDER BY users.name; ";

		$preparedSmt = $this->pdoDbManager->prepareQuery($sql);
		$this->pdoDbManager->executeQuery ( $preparedSmt );
		$arrayOfResults = $this->pdoDbManager->fetchResults ( $preparedSmt );
			
		return $arrayOfResults;
	}
	function insertUser($decBody) {
		//create an INSERT INTO sql statement (reads the parametersArray - this contains the fields submitted in the HTML5 form)

		/*$name= $parameterArray['name'];
		$surname=$parameterArray['surname'];
		$email=$parameterArray['email'];
		$password=$parameterArray['password'];*/
		
		$name = $decBody ["name"];
		$surname = $decBody ["surname"];
		$email = $decBody ["email"];
		$password = $decBody ["password"];
		
		//execute the query
		//$sql = "INSERT INTO `table` (`USER`, `DOMAIN`, `FLG`) VALUES (:username,:domain,:flag)";
		$query = "INSERT INTO users (name, surname, email, password) VALUES (?,?,?,?)";
							
		
		$preparedSmt = $this->pdoDbManager->prepareQuery($query);
		
		$this->pdoDbManager->bindValue($preparedSmt, 1, $name, PDO::PARAM_STR);
		$this->pdoDbManager->bindValue($preparedSmt, 2, $surname, PDO::PARAM_STR);
		$this->pdoDbManager->bindValue($preparedSmt, 3, $email, PDO::PARAM_STR);
		$this->pdoDbManager->bindValue($preparedSmt, 4, $password, PDO::PARAM_INT);
		
		
		$this->pdoDbManager->executeQuery ($preparedSmt);
		//$arrayOfResults = $this->dbManager->fetchResults ( $result );
		//return $arrayOfResults;;

	}
}
?>
