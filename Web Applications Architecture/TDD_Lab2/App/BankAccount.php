<?php
class BankAccount {
	private $balance = 0;
	public function getBalance() {
		return $this->balance;
	}
	private function setBalance($amount) {
		if (is_numeric ( $amount ) && ($amount > 0)) {
			$this->balance = $amount;
			return true;
		}
		return false;
	}
	public function depositMoney($amount) {
		if (is_Numeric ( $amount ) && ($amount > 0))
			return ($this->setBalance ( $this->getBalance () + $amount ));
		return false;
	}
	public function withdrawMoney($amount) {
		if (is_Numeric ( $amount ) && ($amount <= $this->getBalance ()) && ($amount > 0)) {
			$this->setBalance ( $this->getBalance () - $amount );
			return true;
		}
		return false;
	}
}
?>