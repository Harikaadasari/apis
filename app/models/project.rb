class Project < ApplicationRecord
	
	 belongs_to :user
	 has_many :collections
	 has_many :apis, through: :collections
	 
end

