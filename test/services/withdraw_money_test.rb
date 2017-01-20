require 'test_helper'

describe WithdrawMoney do
  before { @amit_account = bank_accounts(:amit) }

  it 'adds amount to the balance' do
    existing_balance = @amit_account.current_balance

    withdrawn_amount = WithdrawMoney.new(@amit_account.id).call(amount: 10)
    balance_after_deposit = existing_balance - withdrawn_amount

    withdrawn_amount.must_equal 10
    @amit_account.current_balance.must_equal balance_after_deposit
  end

  it 'should not withdraw amount there is not sufficient balance' do
    shardul_account = bank_accounts(:shardul)

    lambda { WithdrawMoney.new(shardul_account.id).call(amount: 10) }.must_raise(InsufficientBalanceError)
  end

  it 'should not withdraw amount if the amount is negative' do
    lambda { WithdrawMoney.new(@amit_account.id).call(amount: -100) }.must_raise(NegativeAmountError)
  end

end