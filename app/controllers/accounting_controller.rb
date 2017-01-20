require 'exceptions'

class AccountingController < ApplicationController
  before_filter :set_current_account

  def deposit
    DepositMoney.new(transaction_params[:from_account_id]).call(amount: amount)
    flash[:notice] = "$#{amount} deposited successfully"
    redirect_to root_path
  end

  def withdraw
    WithdrawMoney.new(transaction_params[:from_account_id]).call(amount: amount)
    flash[:notice] = "$#{amount} withdrawn successfully"
    redirect_to root_path
  end

  def transfer
    TransferMoney.new(transaction_params[:from_account_id]).call(to_account_id: transaction_params[:to_account_id], amount: amount)
    flash[:notice] = "$#{amount} transferred successfully"
    redirect_to root_path
  end

  private

    def set_current_account
      from_account_id = params[:from_account_id].presence || session[:from_account_id].presence
      if from_account_id
        @current_account = BankAccount.find(from_account_id)
      else
        @current_account = BankAccount.first
      end
      session[:from_account_id] = @current_account.id
    end

    def transaction_params
      params.permit(:from_account_id, :to_account_id, :amount)
    end

    def amount
      @amount ||= transaction_params[:amount].to_i
    end
end
