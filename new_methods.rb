# notify :admins, "Long process ended!"

module Kernel
	def notify(who, message = "")
		# get list of all admins. Send
		# 'message' using each others perfered method
	end
end


module Kernel
	def attr_accessible(*args)
		args.each do | name |
			define_method(name) {instance_variable_get('@#{name}')}
			define_method("#{name}=") {|new_value| instance_variable_set("@#{name}", new_value)}
		end
	end
	private :attr_accessible
end
