class Project < ApplicationRecord
	 
	 has_many :collections
	 has_many :apis, through: :collections
	 
end
