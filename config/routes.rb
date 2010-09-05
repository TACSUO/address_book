ActionController::Routing::Routes.draw do |map|
  map.resources :contacts, :collection => { :search => :get }
  map.resources :contact_revisions
end
