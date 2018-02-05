Rails.application.routes.draw do

  resources :analyses
  resources :projects do
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "projects#index"

end
