require 'spec_helper'

class FakeController < ApplicationController
end

describe FakeController do
  controller do
    include RescueFromNotFound
  
    def show
      raise ActiveRecord::RecordNotFound, "Could not find Object with ID=3"
    end
  end
  it "sets a flash[:notice]" do
    get :show, :id => 3
    flash[:notice].should_not be_nil
  end
  it "redirects to the root path" do
    get :show, :id => 3
    response.should redirect_to "/"
  end
end
