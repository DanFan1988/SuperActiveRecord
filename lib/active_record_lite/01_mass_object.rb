require_relative '00_attr_accessor_object.rb'

class MassObject < AttrAccessorObject
  def self.my_attr_accessible(*new_attributes)
    new_attributes = new_attributes.map { |attr| attr.to_sym }
    	self.attributes.concat(new_attributes)
  end

  def self.attributes
    if self == MassObject
    	raise "don't call attributes on MassObject"
    else
    	@attributes ||= []
    end
  end

  def initialize(params = {})
    params.each do |attr_name, value|
    	attr_name = attr_name.to_sym
    	if self.class.attributes.include?(attr_name)
    		self.send("#{attr_name}", value)
    	else
    		raise "can't mass assign"
    	end
    end
  end
end
