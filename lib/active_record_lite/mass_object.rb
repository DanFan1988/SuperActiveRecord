class MassObject
  # takes a list of attributes.
  def self.new_attr_accessor(*variable)
    variable.each do |var|
      self.send(:define_method, "#{var}=") do |value|
        self.instance_variable_set("@#{var.to_s}",value)
      end
      self.send(:define_method, "#{var}") do
        self.instance_variable_get("@#{var.to_s}")
      end
    end
  end

  # creates getters and setters.
  # adds attributes to whitelist.
  def self.my_attr_accessible(*variable)
    @attributes = variable
  end

  # returns list of attributes that have been whitelisted.
  def self.attributes
    @attributes
  end

  # takes an array of hashes.
  # returns array of objects.
  def self.parse_all(results)

  end

  # takes a hash of { attr_name => attr_val }.
  # checks the whitelist.
  # if the key (attr_name) is in the whitelist, the value (attr_val)
  # is assigned to the instance variable.
  def initialize(params = {})
    params.each_key do |param|
      if @attributes.include?(param)
        self.send(:my_attr_accessible, param.value)
      else
        raise "mass assignment to unregistered attribute #{param}"
      end
    end 
  end
end
