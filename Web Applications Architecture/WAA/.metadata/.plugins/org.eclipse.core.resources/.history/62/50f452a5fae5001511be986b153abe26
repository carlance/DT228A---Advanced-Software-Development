<?php
require_once 'DB/dbmanager.php';
require_once 'DB/DAO/UsersDAO.php';

$dbmanager = new DBManager();
$userDAO = new UsersDAO($dbmanager);

$dbmanager->openConnection();

$result=$userDAO->getUsers();
//echo $result;
echo "USER DETAILS";
foreach($result	as $key => $value){
	echo "<li>".$value['name']." ".$value['surname']." ".$value['email']."</li>";
}

$dbmanager->closeConnection();

?>