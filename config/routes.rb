ActionController::Routing::Routes.draw do |map|
  map.resources :contacts, :collection => { :search => :get }
end
