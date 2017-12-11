Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "register#start"
  post "/" => "register#start"
  resources :register do
  	get :start, :on => :collection
  	get :file_input, :on => :collection
  	get :command, :on => :collection
  	post :file_input_action, :on => :collection
  	post :execute_command, :on => :collection
  end
end