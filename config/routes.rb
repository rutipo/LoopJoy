Lj::Application.routes.draw do

  resources :items

  devise_for :users

#static routing for the terms of service page
match ':action' => 'static#:action'
match 'dashboard/:action' => 'dashboard#:action'

match 'developer/items' => 'initialization#ios_init', :as => :developer_init

#Lets route home to the home controller
root :to => "home#index"
end
