Blogmenow::Application.routes.draw do
  resources :posts do 
    resources :comments
  end
  
  root to: "pages#show", id: 'home'
end
