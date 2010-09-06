require 'spec_helper'

describe RescueFromNotFound do
  class FakeController < ApplicationController
    include RescueFromNotFound
    def show
      raise ActiveRecord::RecordNotFound, "Could not find Object with ID=3"
    end
  end
  controller_name 'fake'
  before(:each) do
    ActionController::Routing::Routes.draw do |map|
      map.resources :fake
    end
  end
  it "sets a flash[:notice]" do
    get :show, :id => 3
    flash[:notice].should_not be_nil
  end
  it "redirects to the root path" do
    get :show, :id => 3
    response.should redirect_to root_path
  end
end
