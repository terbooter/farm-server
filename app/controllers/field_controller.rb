require "rexml/document"
class FieldController < ApplicationController
		def restore
			@objects = FieldObject.where("user_id = #{params[:id]}");
			#@objects = FieldObject.find_by_user_id(params[:id])
			
			puts "LENGTH = "+@objects.length.to_s
			puts @objects
		doc = REXML::Document.new
     	root = doc.add_element( "Response" )
     	
     	field = root.add_element( "Field" )
     	
     	#arr = @objects.to_a
     	
     	#arr.each do |o|
     	#	puts o
 		#end
 		
 		#@objects.each do |o|
     	#	puts o
 		#end
     	
     	@objects.each do |obj|
     		obj_element = field.add_element("obj")
     		
     		element = obj_element.add_element("x")
     		element.add_text(obj.x.to_s)
     		
     		element = obj_element.add_element("y")
     		element.add_text(obj.y.to_s)
     		
     		element = obj_element.add_element("type_id")
     		element.add_text(obj.type_id.to_s)
     		
     		element = obj_element.add_element("process_end")
     		element.add_text(obj.process_end.to_s)
 		end
     	
     	#@user = User.find(params[:id])
     	
     	#element = root.add_element("id")
		#element.add_text(@user.id.to_s)
		
		#element = root.add_element("money")
		#element.add_text(@user.money.to_s)
		
		#element = root.add_element("size_x")
		#element.add_text(@user.size_x.to_s)
		
		#element = root.add_element("size_y")
		#element.add_text(@user.size_y.to_s)
     	
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