Rails.application.routes.draw do
  devise_for :users
  #for belongs_to  -- has_many realationship
    #as an review belongs to an album and an album has many reviews
    #check 'rake routes' to see how the reviews are nestes
  resources :albums do
    resources :reviews
  end
  root 'albums#index'
end
