require 'game.rb'
require 'rspec'
require 'stringio'

describe "Game flow spec" do
    before do
        new_inputt = StringIO.new("1\n1\n2\na\n1\n3\n")  # Create a new IO Object that will feed input to STDIN
        allow($stdin).to receive(:gets) {new_inputt.gets}    # stub STDIN with lines from new_input  
        game = Game.new
        $stdout = File.open("./spec/game_does_not_skip_log.rb", "w")    # Feed $stdout to a new log file
        game.start_game 
        $stdout.flush                                                   # Stop streaming $stdout to to log file
        $stdout = STDOUT                                                # point $stdout back to STDOUT
        output = File.open("./spec/game_does_not_skip_log.rb", "rb")    # store the ouput in a variable for spec
        @output = output.read
    end

    it "does not skip turn when typing a position already taken or a bad input" do 
        expect(@output).to eql("Welcome to my Tic Tac Toe game\n
                            |_0_|_1_|_2_|\n
                            |_3_|_4_|_5_|\n
                            |_6_|_7_|_8_|\n
                            Please select your spot.\n
                            |_0_|_O_|_2_|\n
                            |_3_|_X_|_5_|\n
                            |_6_|_7_|_8_|\n
                            1 is not available. Please enter one of these positions available: 0,2,3,5,6,7,8\n
                            |_X_|_O_|_O_|\n
                            |_3_|_X_|_5_|\n
                            |_6_|_7_|_8_|\n
                            a is not available. Please enter one of these positions available: 3,5,6,7,8\n
                            1 is not available. Please enter one of these positions available: 3,5,6,7,8\n
                            |_X_|_O_|_O_|\n
                            |_O_|_X_|_5_|\n
                            |_6_|_7_|_X_|\n
                            Game over\n".gsub(/^\s+/,""))       # Using regex to remove space after \n
  end
end

