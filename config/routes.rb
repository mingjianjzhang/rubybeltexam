Rails.application.routes.draw do
  get 'lender/:id' => 'lenders#show'

  get 'borrower/:id' => 'borrowers#show'
  
  root "sessions#index" 
  get 'register' => 'sessions#index'
  get 'login' => 'sessions#login'

  post "lenders" => 'lenders#create'
  post "borrowers" => "borrowers#create"
  post "lend_money" => "lenders#new_transaction"
  post "login_user" => "sessions#login_user"

  delete "logout" => "sessions#logout"
end
