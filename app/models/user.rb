class User < ActiveRecord::Base
	has_many :field_objects
	#set_primary_key("uid")
end
