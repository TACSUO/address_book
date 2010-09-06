ActionController::Routing::Routes.draw do |map|
  map.resources :contacts, :collection => { :search => :get } do |contact|
    contact.resources :phone_numbers
  end
  map.resources :contact_revisions, :only => [:show, :index], :member => { :restore => :post }
end
