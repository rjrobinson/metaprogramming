#################
#Classes

class MyClass
end

obj = MyClass.new
obj.class                       # MyClass

MyClass.class                   # Class

Array.class                     # Class
Symbol.class                    # Class
Class.class                     # Class
Class.class.class.class.class.class.class.class # ... infinitely

class MyClass; end

MyClass.name                                    # "MyClass"

OtherClass = Class.new
OtherClass.name                                 # "OtherClass"

foo = Class.new
foo.name                                        # nil

Foo = foo
foo.name                                        # "Foo"
Foo.name                                        # "Foo"


Object.const_defined? :MyClass                  # true
Object.const_defined? :OtherClass               # true

MyClass = String
=>  warning: already initialized constant Foo
=>  warning: previous definition of Foo was here


obj = Class.new

Foo = obj
Foo.name                            # Foo

Bar = Foo
Bar.name                            # Foo

# Only instance with no name was converted into class.
# "Bar = Foo" is just simple assignment. Ruby interpreter did not
# create new class with name "Bar". It simply assigned
# constant "Bar" to refer to "Foo" class.

Bar.new.class                       # Foo
Also, look into this code:

	foo = Class.new                     # #<Class:0x007fcbc5f86b08>
obj = foo.new                       # #<#<Class:0x007fcbc5f86b08>:0x007fcbc5fa6e80>

foo.name                            # nil
obj.class                           # #<Class:0x007fcbc5f86b08>

SomeConst = foo

foo.name                            # "SomeConst"
obj.class                           #  SomeConst

YourClass = Class.new

class << YourClass
	puts self                       # #<Class:YourClass>
end

# This is the same as:
class YourClass
	class << self                   # Because self here equals to YourClass
		puts self                   # #<Class:YourClass>
	end
end

YourClass.singleton_class           # #<Class:YourClass>

class MyClass
	def initialize
		@instance_variable = "ohoi"
	end

	def instance_method
		"#{@instance_variable}  - from instance method"
	end
end

obj = MyClass.new
obj.instance_method                     # "ohoi - from instance method"


class << MyClass
	attr_accessor :class_instance_var
	def class_method
		@class_instance_var = "ohohohoi"
	end
end

MyClass.class_instance_var              # nil
MyClass.class_method                    # "ohohohoi"
MyClass.class_instance_var              # "ohohohoi"

# Just remember: `MyClass = Class.new` is just like `obj = MyClass.new`.


class MyClass
	def initialize
		@instance_var = "instance var"
	end

	def instance_method
		another_instance_method
	end

	def another_instance_method
		@instance_var
	end

	def self.class_method
		@instance_var = "class instance var"
	end

	class << self
		def another_class_method
			class_method
		end
	end
end

obj = MyClass.new

obj.instance_method                     # "instance var"

MyClass.class_method                    # Can call ALL class methods, but not instance methods (instance_method, another_instance_method)
MyClass.another_class_method            # "class instance var"
MyClass.class_method                    # "class instance var"

class Foo
	def bar
		"Foo#bar"
	end
end

obj = Foo.new

Foo = Class.new do        # We're doing `Class.new` instead of `class Name`
	def bar
		"Foo#bar"
	end
end

obj = Foo.new
##############
# Objects

obj = Array.new
obj.class                               # Array
Array.class                             # Class (NOT Array!)


class MyClass; end

my_class = MyClass.new
my_class.class                          # MyClass
MyClass.class                           # Class (You will learn why in the next video)


true.class                              # TrueClass (~ `true = TrueClass.new`)
self.class                              # Object    (~ `self = Object.new`   )
