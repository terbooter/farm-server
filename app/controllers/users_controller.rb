require "rexml/document"
class UsersController < ApplicationController
	def list
		@users = User.all
	end
	
	def show
		@user = User.find(params[:id])
	end
	
	def restore
		doc = REXML::Document.new
     	root = doc.add_element( "Response" )
     	@user = User.find(params[:id])
     	
     	element = root.add_element("id")
		element.add_text(@user.id.to_s)
		
		element = root.add_element("money")
		element.add_text(@user.money.to_s)
		
		element = root.add_element("size_x")
		element.add_text(@user.size_x.to_s)
		
		element = root.add_element("size_y")
		element.add_text(@user.size_y.to_s)
     	
     	#keys = User.columns_hash
     	#puts "**********************"
     	#puts keys
     	#keys.each_key do |k|
		#	element = root.add_element(k)
		#	element.add_text(@user[k])
		#end
		
		#element = root.add_element("action")
		#element.add_text("user")
     	
		send_data( doc, :type => "text/xml", :filename => "sample.xml" )
	end
end
