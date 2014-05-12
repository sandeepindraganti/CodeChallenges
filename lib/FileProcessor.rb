require "singleton"
require_relative "./ConfigObject.rb"

# This class will serve as a adapter to read the file contents
# Currently we are reading the input from a file, we might read 
# the input from db as well. So the client who wants the config 
# should not worry where the input is read from. Output is given
# in the form of a filled config object 

# We only need a single instance of FileProcessor and we don't 
# want any other object in the system instantiate FileProcessor.
# Hence we will define this as a singleton class. 

class FileProcessor
	include Singleton
	
	def initialize
		@cfgObject = Configobject.new
	end

	def fileContents
		File.open('TextFiles/Input.txt') do |file|
			# get the range, blocked channels and channel sequence
			# and fills the configuration object
			file.each_with_index { |line, count|
				first, *rest = line.split(" ")
				range = {}
				if count == 0
					range[:low] = line.split(" ").first
					range[:high] = line.split(" ").last
					@cfgObject.rangeHash = range
				end

				if count == 1
					@cfgObject.blockedChannelCount = first.to_i
					@cfgObject.blockedChannel = rest
				end

				if count == 2
					@cfgObject.viewableChannelCount = first.to_i
					@cfgObject.navigationSequence = rest
				end
			}
		end
		@cfgObject
	end	
end

# contents = FileProcessor.instance.fileContents

# puts contents.rangeHash
# puts contents.blockedChannelCount
# puts contents.viewableChannelCount

