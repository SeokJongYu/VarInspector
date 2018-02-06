Rails.application.routes.draw do


  get 'result/show'

  get 'result/plot'

  resources :projects do
    resources :analyses
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "projects#index"

end
