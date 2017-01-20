Rails.application.routes.draw do
  get 'dashboard' => 'accounting#dashboard'

  post 'accounting/deposit'
  post 'accounting/withdraw'

  root to: 'accounting#dashboard'
end
