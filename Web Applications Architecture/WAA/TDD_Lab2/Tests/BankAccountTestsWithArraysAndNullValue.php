<?php
/**
 * @author luca
 * example of a test case Class - Calculator example
 */
class BankAccountTestsWithArraysAndNullValue extends UnitTestCase {
	private $ba;
	public function setUp() {
		$this->ba = new BankAccount ();
	}
	public function testDepositArray() {
		$amount = array (
				"" 
		);
		$this->ba->depositMoney ( $amount );
		$this->assertFalse ( $this->ba->getBalance () );
	}
	public function testWithdrawMoneyWithNullValue() {
		$this->assertFalse ( $this->ba->withdrawMoney ( null ) );
	}
	public function testWithdrawMoneyWithObject() {
		$o = new BankAccount ();
		$this->assertFalse ( $this->ba->depositMoney ( $o ) );
	}
	public function tearDown() {
		$this->ba = NULL;
	}
}
?>