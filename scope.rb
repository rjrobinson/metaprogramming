puts self                                   # main                          - Object instance

class MyClass
	puts self                               # MyClass                       - MyClass class scope

	def instance_method
		puts self                           # #<MyClass:0x00xxxxxxxxxxxx>   - Instance of MyClass
	end

	class << self
		puts self                           # #<Class:MyClass>              - MyClass's eigenclass

		def class_method
			puts self                       # MyClass                       - MyClass class scope
		end
	end

	def self.class_method_2
		puts self                           # MyClass                       - MyClass class scope
	end
end


obj1 = MyClass.new                          # #<MyClass:0x007fde2426caa0>
obj2 = MyClass.new                          # #<MyClass:0x007fde24294370>

obj1.instance_method                        # #<MyClass:0x007fde2426caa0>   - Instance 1 of MyClass
obj2.instance_method                        # #<MyClass:0x007fde24294370>   - Instance 2 of MyClass


class << MyClass
	puts self                               # #<Class:MyClass>              - MyClass's eigenclas
end

MyClass.class_method                        # MyClass                       - MyClass class scope
MyClass.class_method_2                      # MyClass                       - MyClass class scope


class MyClass

	@foo = "Instance variable created in 'MyClass' scope"

	def initialize
		@bar = "Created in the MyClass instance scope"
	end

	def instance_method
		# Can only access @bar and not @foo. Because 'self' here
		# refers to an 'instance of the class' and this self != MyClass.
		@foo            # Returns: nil
		@bar            # Returns: "Created in the MyClass instance scope"
	end

	def another_instance_method
		# Can call 'instance_method' without explicit object.
		instance_method
		self.instance_method    # Same thing as above

		# Have to use explicit message receiver to call 'class_method'.
		# Because 'self' here isn't equal to 'MyClass'.
		MyClass.class_method
	end

	def self.class_method
		# 'self' in class methods however is equal to the class (self = MyClass).
		# So, here we can access everything defined when 'self' was equal to 'MyClass'.
		@foo            # Returns: "Instance variable created in 'MyClass' scope"
		@bar            # Returns: nil
	end

	def self.another_class_method
		# Can't call 'instance_method' without getting a reference to an instance.
		instance_method         # Will look for class method with name 'instance_method'.

		# Don't need to use explicit message receiver to call class methods.
		# Because 'self' here is equal to 'MyClass'.
		class_method
		self.class_method       # Same thing as above
	end
end


class << MyClass
	# 'self' here is an eigenclass. So we can't access class instances vars or methods.

	def some_method
		# 'self' here is 'MyClass'. So, we can access all class instance
		# variables and methods that were defined while self was equal to MyClass.

		class_method            # Can access class methods.
		@foo                    # Can access @foo, but not @bar
	end
end


################################################################################
module MyModule
	@module_instance_var = "module inst var"

	def module_method
		@instance_var = "@instance_var set in module"
	end

	def self.module_class_method
		[@class_instance_var, @module_instance_var]
	end
end

class MyClass
	include MyModule

	@class_instance_var = "class inst var"

	def initialize
		@instance_var = "@instance_var set in MyClass initializer"
	end

	def self.class_method
		[@class_instance_var, @module_instance_var]
	end
end
