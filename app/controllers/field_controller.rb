require "rexml/document"
require "./app/helpers/my_general_helper.rb"
class FieldController < ApplicationController
		def restore
			@objects = FieldObject.where("user_id = #{params[:id]}");
			#@objects = FieldObject.find_by_user_id(params[:id])
			
			puts "LENGTH = "+@objects.length.to_s
			puts @objects
		doc = REXML::Document.new
     	root = doc.add_element( "Response" )
     	
     	field = root.add_element( "Field" )
     	root.attributes["c"]="field"
     	
     	#arr = @objects.to_a
     	
     	#arr.each do |o|
     	#	puts o
 		#end
 		
 		#@objects.each do |o|
     	#	puts o
 		#end
     	
     	@objects.each do |obj|
     		obj_element = field.add_element("obj")
     		
     		element = obj_element.add_element("id")
     		element.add_text(obj.id.to_s)
     		
     		element = obj_element.add_element("x")
     		element.add_text(obj.x.to_s)
     		
     		element = obj_element.add_element("y")
     		element.add_text(obj.y.to_s)
     		
     		element = obj_element.add_element("type_id")
     		element.add_text(obj.type_id.to_s)
     		
     		element = obj_element.add_element("process_end")
     		element.add_text(obj.process_end.to_s)
     		
     		element = obj_element.add_element("grow_period")
     		element.add_text(obj.grow_period.to_s)
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
	
	def grow
		@objects = FieldObject.where("user_id = #{params[:id]} AND grow_period<5");
		puts @objects
		
		puts "************************"
		@objects.each do |obj|
			puts obj.class
			puts obj
			obj.increment(:grow_period)
			#TODO это очень плохо. разобраться как оптимизировать
			obj.save 
		end
		
		doc = REXML::Document.new
     	root = doc.add_element( "Response" )
     	
     	field = root.add_element( "Field" )
     	root.attributes["c"]="field_change"
     	
     	@objects.each do |obj|
     		obj_element = field.add_element("obj")
     		
     		element = obj_element.add_element("id")
     		element.add_text(obj.id.to_s)
     		
     		element = obj_element.add_element("x")
     		element.add_text(obj.x.to_s)
     		
     		element = obj_element.add_element("y")
     		element.add_text(obj.y.to_s)
     		
     		element = obj_element.add_element("type_id")
     		element.add_text(obj.type_id.to_s)
     		
     		element = obj_element.add_element("process_end")
     		element.add_text(obj.process_end.to_s)
     		
     		element = obj_element.add_element("grow_period")
     		element.add_text(obj.grow_period.to_s)
 		end
		@objects=nil
		#send_data( doc, :type => "text/xml", :filename => "sample.xml" )
		send_data( doc, :type => "text/xml")
		
	end
	
	def seed

		#doc = MyGeneralHelper::generateErrorXML("errrr")
		@objects = FieldObject.where("user_id = #{params[:id]} AND x = #{params[:x]} AND y= #{params[:y]}");
		
     	if @objects.length==1
     		doc = generateErrorXML("cant_seed_here")
     		send_data( doc, :type => "text/xml")
     		return
 		end
 		
 		obj = FieldObject.new(:user_id=>params[:id], :type_id=>params[:type_id], :x=>params[:x], :y=>params[:y])
 		#obj.type_id = params[:type_id]
 		
 		obj.save
 		puts "==========="+obj.to_s
 		puts "==========="+obj.type_id.to_s
 		
 		doc = REXML::Document.new
     	root = doc.add_element( "Response" )
     	field = root.add_element( "Field" )
     	createObjNode(obj, field)
     	root.attributes["c"]="field_change"
     	send_data( doc, :type => "text/xml")
	end
	
	def crop
		obj = FieldObject.find_by_id(params[:obj_id]);
		if(obj==nil)
			doc = generateErrorXML("object_not_found")
     		send_data( doc, :type => "text/xml")
     		return
		end
		if(obj.grow_period!=5)
			doc = generateErrorXML("object_not_ready_for_crop")
     		send_data( doc, :type => "text/xml")
     		return
		end
		
		obj.type_id=0;
		obj.destroy
		
		puts "==============="+obj.id.to_s;
		doc = REXML::Document.new
     	root = doc.add_element( "Response" )
     	field = root.add_element( "Field" )
     	createObjNode(obj, field)
     	root.attributes["c"]="field_change"
     	
     	send_data( doc, :type => "text/xml")
	end
end
