require 'test_helper'

describe TransferMoney do
  before do
    @amit_account = bank_accounts(:amit)
    @shardul_account = bank_accounts(:shardul)
  end

  describe 'existing accounts' do
    it 'adds amount to the balance of target account' do
      existing_balance_of_amit = @amit_account.current_balance
      existing_balance_of_shardul = @shardul_account.current_balance

      transferred_amount = TransferMoney.new(@amit_account.id).call(to_account_id: @shardul_account.id, amount: 10)

      transferred_amount.must_equal 10
      @amit_account.current_balance.must_equal existing_balance_of_amit - transferred_amount
      @shardul_account.current_balance.must_equal existing_balance_of_shardul + transferred_amount
    end

    it 'should not transfer amount there is not sufficient balance' do
      lambda do
        TransferMoney.new(@shardul_account.id).call(to_account_id: @amit_account.id, amount: 10)
      end.must_raise(InsufficientBalanceError)
    end

    it 'should not transfer amount if the amount is negative' do
      lambda { TransferMoney.new(@amit_account.id).call(to_account_id: @shardul_account.id, amount: -10) }.must_raise(NegativeAmountError)
    end
  end

  describe 'non existing accounts' do
    it 'should not transfer amount if payer account does not exits' do
      lambda { TransferMoney.new(-1).call(to_account_id: @amit_account.id, amount: 10) }.must_raise(ActiveRecord::RecordNotFound)
    end

    it 'should not transfer amount if payer account does not exits' do
      lambda { TransferMoney.new(@amit_account.id).call(to_account_id: -1, amount: 10) }.must_raise(ActiveRecord::RecordNotFound)
    end

  end
end