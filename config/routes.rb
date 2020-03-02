Rails.application.routes.draw do
  #get 'home/index'
  #get 'home/codigopostal'
  root 'home#index'

  post "codigopostal" => 'home#codigopostal'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
