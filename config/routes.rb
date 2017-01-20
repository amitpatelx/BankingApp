Rails.application.routes.draw do
  get 'dashboard' => 'accounting#dashboard'

  post 'deposit' => 'accounting#deposit'
  post 'withdraw' => 'accounting#withdraw'
  post 'transfer' => 'accounting#transfer'

  root to: 'accounting#dashboard'
end
