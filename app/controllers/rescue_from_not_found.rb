module RescueFromNotFound
  def self.included(base)
    base.instance_eval do
      rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
    end
  end
  
  def record_not_found(exception)
    flash[:notice] = exception.message
    redirect_to root_path
  end
end