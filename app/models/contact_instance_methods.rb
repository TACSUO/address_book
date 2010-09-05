module ContactInstanceMethods
  def name
    "#{last_name}, #{first_name}"
  end

  def fullname
    name
  end
end