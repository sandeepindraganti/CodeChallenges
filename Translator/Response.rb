# Response class will be filled with below data 
# and sent back to the client. 

# status   -  Indicates whether the operation is success or failure
# err-msg  -  If the operation is a failure, err_msg will contain 
#             the reason for the failure
# object   -  If the operation is a failure, object will contain 
#             the details of the object which caused the failure.
# credits  -  If the operation is a success, credits will hold
#             the details of the computed credits. 

class Response
	attr_accessor :status
	attr_accessor :err_msg
	attr_accessor :object
	attr_accessor :credits
	
end