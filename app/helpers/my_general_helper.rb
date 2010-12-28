require "rexml/document"
module MyGeneralHelper
	def testdef
		puts "test"
	end
	
	def generateErrorXML(message)
		doc = REXML::Document.new
     	root = doc.add_element( "Response" )
     	
     	element = root.add_element( "Message" )
     	element.add_text(message)
     	
     	root.attributes["c"]="error"
     	
     	return doc
	end
end

def generateErrorXML(message)
	doc = REXML::Document.new
 	root = doc.add_element( "Response" )
 	
 	element = root.add_element( "code" )
 	element.add_text(message)
 	
 	root.attributes["c"]="error"
 	
 	return doc
end

def createObjNode(obj, rootNode)
	obj_element = rootNode.add_element("obj")
	schema = ["id", "x", "y", "type_id", "process_end", "grow_period"]
	
	schema.each do |s|
		puts s
		element = obj_element.add_element(s)
    	element.add_text(obj[s].to_s)
	end
    return 		
end