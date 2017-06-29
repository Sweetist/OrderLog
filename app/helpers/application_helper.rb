module ApplicationHelper

  
  def datum_value(datum, key) 
    if datum.nil? || key.nil? || datum[key].nil?
      nil
    else
      datum[key].to_s
    end
  end  

end