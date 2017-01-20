class Base
  attr_reader :bank_account

  def initialize(account_id)
    @bank_account = BankAccount.find(account_id)
  end
end