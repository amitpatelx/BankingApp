class TransferMoney < Base
  def call(to_account_id:, amount:)
    raise NegativeAmountError if amount <= 0

    raise InsufficientBalanceError if bank_account.current_balance < amount

    if bank_account.current_balance >= amount
      bank_account.transaction do
        to_account = BankAccount.find(to_account_id)
        bank_account.transactions.create(amount: -amount)
        to_account.transactions.create(amount: amount)
      end
      amount
    else
      raise InsufficientBalanceError
    end
  end
end