require 'test_helper'

describe DepositMoney do
  before { @amit_account =  bank_accounts(:amit) }

  it 'adds amount to the balance of target account' do
    existing_balance = @amit_account.current_balance

    deposited_amount = DepositMoney.new(@amit_account.id).call(amount: 100)
    balance_after_deposit = existing_balance + deposited_amount

    deposited_amount.must_equal 100
    @amit_account.current_balance.must_equal balance_after_deposit
  end

  it 'should not deposit amount if the amount is negative' do
    lambda { DepositMoney.new(@amit_account.id).call(amount: -100) }.must_raise(NegativeAmountError)
  end

end