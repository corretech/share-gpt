class ApplicationRecord < ActiveRecord::Base
include CategorizeMethods
  self.abstract_class = true
end
