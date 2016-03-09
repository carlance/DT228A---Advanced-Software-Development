<?php
require_once ("../SimpleTest/autorun.php");
class BankAccountTestSuite extends TestSuite {
	function __construct() {
		parent::__construct ();
		include ('../App/BankAccount.php');
		$this->addFile ( "BankAccountTests.php" );
		$this->addFile ( "BankAccountTestsOfStrings.php" );
		$this->addFile ( "BankAccountTestsWithArraysAndNullValue.php" );
		
	}
}

?>
