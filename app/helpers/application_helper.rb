module ApplicationHelper

  
  def datum_value(datum, attr_hash) 
    if datum.nil? || attr_hash.nil? || datum[attr_hash.name].nil?
    	nil
    else
      if attr_hash.type == :string || 
      	attr_hash.type == :integer || 
      	attr_hash.type == :float ||
      	attr_hash.type == :date
        datum[attr_hash.name].to_s
      elsif attr_hash.type == :time
      	datum[attr_hash.name].to_s(:time)
      else
      	datum[attr_hash.name]
      end
    end
  end  

end