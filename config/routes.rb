Lj::Application.routes.draw do

  resources :items

  devise_for :users, :controllers => { :registrations => "registrations" }

  
  
  match 'dashboard/:action' => 'dashboard#:action'
  match 'dashboard' => 'dashboard#current_offerings'

  match 'developer/items' => 'initialization#ios_init', :as => :developer_init, :via => :post
  match 'paypal/checkout' => 'paypal_express#checkout'
  match 'paypal/review' => 'paypal_express#review'
  match 'paypal/purchase' => 'paypal_express#purchase'

  match 'checkout/:id' => "paypal_web_express#checkout"
  match 'paypal/success' => "paypal_web_express#review"
  match 'paypal/confirm' => "paypal_web_express#confirm", :as => :paypal_web_express_confirm

  match 'Legal/EULA' => 'home#eula', :as => :legal_eula

  #Lets route home to the home controller
  root :to => "home#index"
  
  #static routing for the terms of service page
  match ':action' => 'static#:action'

end
