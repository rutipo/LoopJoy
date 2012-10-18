Lj::Application.routes.draw do

  resources :items

  devise_for :users, :controllers => { :registrations => "registrations" }

  #static routing for the terms of service page
  match ':action' => 'static#:action'
  match 'dashboard/:action' => 'dashboard#:action'

  match 'developer/items' => 'initialization#ios_init', :as => :developer_init, :via => :post
  match 'paypal/checkout' => 'paypal_express#checkout'
  match 'paypal/review' => 'paypal_express#review'
  match 'paypal/purchase' => 'paypal_express#purchase'

  match 'Legal/EULA' => 'home#eula', :as => :legal_eula

  #Lets route home to the home controller
  root :to => "home#index"

end
