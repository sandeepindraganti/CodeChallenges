require_relative "../lib/FileProcessor.rb"
require_relative "../lib/SkycastSTB.rb"
require_relative "../lib/Remote.rb"

describe Remote do
	
	before :each do
		config = FileProcessor.instance.fileContents('TextFiles/RemoteInput.txt')
		@stb = SkycastSTB.new
		@stb.applyConfiguration config
		@remote = Remote.new 
		@remote.pairUp @stb
	end

	describe "#new" do
		it "creates a new Remote object" do
			@remote.should be_an_instance_of Remote
		end
	end

	describe "#pressButton" do
		it "allows user to press up button and plays the action on stb" do
			@stb.currentChannel = 15
			@remote.pressButton('u')
			@stb.currentChannel.should eql(16)
		end

		it "allows user to press down button and plays the action on stb" do
			@stb.currentChannel = 15
			@remote.pressButton('d')
			@stb.currentChannel.should eql(14)
		end

		it "allows user to press back button and plays the action on stb" do
			@stb.currentChannel = 15
			@stb.channelUp
			@remote.pressButton('b')
			@stb.currentChannel.should eql(15)
		end

		it "allows press of a number button and carries out the action on stb" do
			@stb.currentChannel = 15
			@remote.pressButton('1')
			@remote.pressButton('4')
			@stb.currentChannel.should eql(14)
		end

		it "allows press of a number button and carries out the action on stb" do
			@stb.currentChannel = 15
			@remote.pressButton('1')
			@remote.pressButton('4')

			@remote.pressButton('1')
			@remote.pressButton('7')
			@stb.currentChannel.should eql(17)
		end

	end
end