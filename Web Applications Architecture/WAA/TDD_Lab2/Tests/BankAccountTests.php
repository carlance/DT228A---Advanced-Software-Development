<?php
/**
 * @author luca
 * example of a test case Class - Calculator example
 */
class BankAccountTests extends UnitTestCase {
	private $ba;
	public function setUp() {
		$this->ba = new BankAccount ();
	}
	public function testBalanceIsInitiallyZero() {
		$this->assertEqual ( 0, $this->ba->getBalance () );
	}
	public function testBalanceCannotBecomeNegative() {
		$this->assertFalse ( $this->ba->withdrawMoney ( 1 ) );
		$this->assertEqual ( 0, $this->ba->getBalance () );
	}
	public function testBalanceCannotBecomeNegative2() {
		$this->ba->depositMoney ( 100 );
		$this->assertFalse ( $this->ba->withdrawMoney ( 102 ) );
		$this->assertEqual ( 100, $this->ba->getBalance () );
	}
	public function testMultipleDeposits() {
		$this->ba->depositMoney ( 5 );
		$this->ba->depositMoney ( 10 );
		$this->ba->depositMoney ( 15 );
		$this->assertEqual ( 30, $this->ba->getBalance () );
	}
	public function testMultipleWithdrawns() {
		$this->ba->depositMoney ( 10 );
		$this->ba->withdrawMoney ( 5 );
		$this->ba->withdrawMoney ( 1 );
		$this->ba->withdrawMoney ( 2 );
		
		$this->assertEqual ( 2, $this->ba->getBalance () );
	}
	public function testDepositLargeAmount() {
		$amount = 9999999999;
		$this->ba->depositMoney ( $amount );
		$this->assertEqual ( $amount, $this->ba->getBalance () );
	}
	public function testDepositHugeAmount() {
		$amount = 999999999999999999999999999999999999999999999;
		$this->ba->depositMoney ( $amount );
		$this->assertEqual ( $amount, $this->ba->getBalance () );
	}
	public function testDepositAndWithdrawnWithNegativeAmount() {
		$this->assertFalse ( $this->ba->depositMoney ( -10 ) );
		$this->assertFalse ( $this->ba->withdrawMoney ( -20 ) );
		$this->assertEqual ( 0, $this->ba->getBalance () );
	}
	public function tearDown() {
		$this->ba = NULL;
	}
}
?>