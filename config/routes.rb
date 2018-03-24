Rails.application.routes.draw do
  resources :alunos do
    collection { post :import }
    collection { get :export }
  end
  devise_for :users
  resources :cursos do
    collection { post :import }
    collection { get :export }
  end
  resources :universidades do
    collection { post :import }
    collection { get :export }
  end
  root 'universidades#index'
end
