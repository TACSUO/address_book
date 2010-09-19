AddressBook::Application.routes.draw do
  root :to => 'contacts#index'
  resources :contacts do
    collection do
      get :search
    end
    resources :phone_numbers
  end
  resources :phone_numbers
  resources :contact_revisions do
    member do
      post :restore
    end
  end
  resources :phone_number_revisions do
    member do
      post :restore
    end
  end
end

# Rails 2.3 routes
# ActionController::Routing::Routes.draw do |map|
#   map.root :controller => "contacts", :action => "index"
#   map.resources :contacts, :collection => { :search => :get } do |contact|
#     contact.resources :phone_numbers, :only => [:new, :create, :index]
#   end
#   map.resources :phone_numbers
#   map.resources :contact_revisions, {
#     :only => [:show, :index],
#     :member => { :restore => :post }
#   }
#   map.resources :phone_number_revisions, {
#     :only => [:show, :index],
#     :member => { :restore => :post }
#   }
# end
