Focusadmin::Engine.routes.draw do
	root 'dashboard#index'
  get 'rankings' => 'dashboard#rankings'
  get 'review' => 'articles#review'
  get 'scheduled' => 'articles#scheduled'
	resources :users
  get 'curator_applicants' => 'users#curator_applicants', as: "curator_applicants"
	resources :admins
  resources :comments
  resources :pickups
  resources :information
  resources :contents
  resources :settings
  get 'settings/:id/edit_pages' => 'settings#edit_pages', as: "edit_page_setting"

  get 'items/products' => 'items#products'
  get 'items/events' => 'items#events'
  get 'tags', :to => 'tag#index'

  resources :categories do
    post :update_row_order, on: :collection
  end

  resources :banners do
    post :update_row_order, on: :collection
  end

	resources :articles do
    get 'update_status', on: :collection
  end

  resources :areas do
    post :update_row_order, on: :collection
  end

  resources :features do
    post :update_row_order, on: :collection
  end

  resources :faqs do
    post :update_row_order, on: :collection
  end

end
