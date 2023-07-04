class Collection < ApplicationRecord
 
  belongs_to :project
  has_many :apis
  
end
