class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.load_by_param(param)
  	ApplicationRecord.find(param)
  end

end
