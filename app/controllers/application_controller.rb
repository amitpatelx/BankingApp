class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ::InsufficientBalanceError, with: :insufficient_balance
  rescue_from ::NegativeAmountError, with: :invalid_amount

  private

    def not_found
      redirect_to root_path, alert: 'The resource you are looking for does not exists'
    end

    def insufficient_balance
      redirect_to root_path, alert: 'There is not enough balance in your account'
    end

    def invalid_amount
      redirect_to root_path, alert: 'Please enter valid amount'
    end
end
