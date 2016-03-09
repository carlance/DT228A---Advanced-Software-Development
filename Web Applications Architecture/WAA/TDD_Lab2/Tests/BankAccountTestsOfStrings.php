<?php
/**
 * @author luca
 * example of a test case Class - Calculator example
 */
class BankAccountTestsOfStrings extends UnitTestCase {
	private $ba;
	public function setUp() {
		$this->ba = new BankAccount ();
	}
	public function testDepositMoney() {
		$this->assertFalse ( $this->ba->depositMoney ( "aa" ) );
	}
	public function testWithdrawMoney() {
		$this->assertFalse ( $this->ba->withdrawMoney ( "dsj" ) );
	}
	public function tearDown() {
		$this->ba = NULL;
	}
}
?>