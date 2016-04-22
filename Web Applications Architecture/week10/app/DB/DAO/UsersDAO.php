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
	public function get($id = null) {
		$sql = "SELECT * ";
		$sql .= "FROM users ";
		if ($id != null)
			$sql .= "WHERE users.id=? ";
		$sql .= "ORDER BY users.name ";
		
		$stmt = $this->dbManager->prepareQuery ( $sql );
		$this->dbManager->bindValue ( $stmt, 1, $id, $this->dbManager->INT_TYPE );
		$this->dbManager->executeQuery ( $stmt );
		$rows = $this->dbManager->fetchResults ( $stmt );
		
		return ($rows);
	}
	public function insert($parametersArray) {
		// insertion assumes that all the required parameters are defined and set
		$sql = "INSERT INTO users (name, surname, email, password) ";
		$sql .= "VALUES (?,?,?,?) ";
		
		$stmt = $this->dbManager->prepareQuery ( $sql );
		$this->dbManager->bindValue ( $stmt, 1, $parametersArray ["name"], $this->dbManager->STRING_TYPE );
		$this->dbManager->bindValue ( $stmt, 2, $parametersArray ["surname"], $this->dbManager->STRING_TYPE );
		$this->dbManager->bindValue ( $stmt, 3, $parametersArray ["email"], $this->dbManager->STRING_TYPE );
		$this->dbManager->bindValue ( $stmt, 4, $parametersArray ["password"], $this->dbManager->INT_TYPE );
		$this->dbManager->executeQuery ( $stmt );
		
		return ($this->dbManager->getLastInsertedID ());
	}
	public function update($userID, $parametersArray) {
		
		//update user
		$name = $parametersArray ["name"];
		$surname = $parametersArray ["surname"];
		$email = $parametersArray ["email"];
		$password = $parametersArray ["password"];
		
		$sql = "UPDATE users SET name=?,surname=?,email=?,password=? WHERE id=$userID";
		
		$stmt = $this->dbManager->prepareQuery ( $sql );
		$this->dbManager->bindValue ( $stmt, 1, $name, PDO::PARAM_STR );
		$this->dbManager->bindValue ( $stmt, 2, $surname,PDO::PARAM_STR );
		$this->dbManager->bindValue ( $stmt, 3, $email, PDO::PARAM_STR );
		$this->dbManager->bindValue ( $stmt, 4, $password, PDO::PARAM_INT );
		
		$this->dbManager->executeQuery ( $stmt );
		
		
		//returns 1 if query executes successfully
		$arrayOfResults = $this->dbManager->getNumberOfAffectedRows ( $stmt ); 
			
		return ($arrayOfResults);
		
	}
	public function delete($userID) {
		//delete user
		$sql = "DELETE ";
		$sql .= "FROM users ";
		$sql .= "WHERE users.id=? ";		
		
		$stmt = $this->dbManager->prepareQuery ( $sql );
		$this->dbManager->bindValue ( $stmt, 1, $userID, $this->dbManager->INT_TYPE );
		$this->dbManager->executeQuery ( $stmt );
		$rowsAffected= $this->dbManager->getNumberOfAffectedRows ($stmt);
		//returns the number of affected rows on success, and -1 if the last query failed
		return ($rowsAffected);
	}
	public function search($str) {
		
		$sql = "SELECT * ";
		$sql .= "FROM users ";
 	    $sql .= "WHERE users.name LIKE CONCAT('%',?,'%') OR users.surname LIKE CONCAT('%',?,'%')"; //searches string that have $str in any position
 	    $sql .= "ORDER BY users.name ";
 	    
 	    
 	    $stmt = $this->dbManager->prepareQuery ( $sql );
 	    $this->dbManager->bindValue ( $stmt, 1, $str, PDO::PARAM_STR );
 	    $this->dbManager->bindValue ( $stmt, 2, $str, PDO::PARAM_STR );
 	    
 	    $this->dbManager->executeQuery ( $stmt );
 	    $rows = $this->dbManager->fetchResults ( $stmt );
 	    
 	    return ($rows);
		
	}
}
?>
