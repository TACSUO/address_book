module ContactClassMethods
  def existing_states
    select('DISTINCT state').map(&:state).reject { |st| st.blank? }.sort
  end

  def string_attributes
    [:first_name, :last_name, :title, :street, :city, :state, :zip]
  end

  def link_attributes
    [:email, :website]
  end

  def text_attributes
    [:comments, :descriptors]
  end

  def datetime_attributes
    [:created_at, :updated_at]
  end
end