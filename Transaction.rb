require_relative './RequestValidator.rb'
require_relative './UnitConverter.rb'
require_relative './TranslatorError.rb'
require_relative './Configuration.rb'

# Exposes a public interface "getCredits"

class Transaction

	def initialize()
		config = Configuration.new
		@cfg = config.getConfig
	end

	def getCredits(input, response)
		begin
			# Validates the request against library
			validateRequest input, @cfg.vocabulary			

			# Gets the roman value for the input
			converter = UnitConverter.new 
			romanStr = converter.unitToRoman input, @cfg.unitHash	

			# Checks if the given roman is valid
			validateRoman romanStr			

			# Gets the decimal equivalent for roman
			decVal = converter.romanToDec romanStr

			# If the input has metal, then get the single value 
			# then compute credits by multiplying with the given  
			# input else return just the dec equivalent for roman
			if hasMetal(input)
				metalValue = getMetalValue input.split(" ").last 
				output = decVal.to_f * metalValue.to_f
			else
				output = decVal
			end
		rescue TranslatorError => e
			response.status = Status::FAILURE
			response.err_msg = e.message
			response.object = e.object
			return response
		else
			response.status = Status::SUCCESS
			response.err_msg = "Transaction Successful..."
			response.credits = output
			return response
		end
	end

	def validateRequest input, vocabArray
		reqValidator = RequestValidator.new
		reqValidator.validateRequest input, vocabArray
	end

	def validateRoman input
		langChecker = LanguageChecker.new
		raise TranslatorError.new(Transaction, 
			ErrorMsg::INVALID_ROMAN) unless langChecker.roman? input
	end

	def hasMetal input
		["Silver","Gold","Iron"].include? input.split(" ").last
	end

	def getMetalValue metal
		case metal
			when "Silver"
				@cfg.metalObject.silver

			when "Gold"
				@cfg.metalObject.gold

			when "Iron"
				@cfg.metalObject.iron
		end
	end

	private :validateRequest, :validateRoman
	private :hasMetal, :getMetalValue

end

# Remove roman numeral gem
