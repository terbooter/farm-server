require "rexml/document"
class TestController < ApplicationController
	def echo
		doc = REXML::Document.new
     	root = doc.add_element( "Response" )
     	
     	
     	params.each_key do |k|
			k+'  =  '+params[k]
			element = root.add_element(k)
			element.add_text(params[k])
		end
     	
     	out_data=doc
		send_data( out_data, :type => "text/xml", :filename => "sample.xml" )
		#respond_to do |format|
		#	@articles = [1,2,3,4]
		#	#format.xml { render :xml => @articles }
		#	render :layout => false
		#end
	end
	
	def test_params
		
	end
end
