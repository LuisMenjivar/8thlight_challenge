require 'game.rb'
require 'rspec'
require 'stringio'

describe "Game flow spec" do
    before do
        new_inputt = StringIO.new("1\nX\n2\na\n1\n3\n")  # Create a new IO Object that will feed input to STDIN
        allow($stdin).to receive(:gets) {new_inputt.gets}    # stub STDIN with lines from new_input  
        game = Game.new
        $stdout = File.open("./spec/test_logs/game_allows_user_to_pick_marker_log.rb", "w")    # Feed $stdout to a new log file
        game.start_game 
        $stdout.flush                                                   # Stop streaming $stdout to to log file
        $stdout = STDOUT                                                # point $stdout back to STDOUT
        output = File.open("./spec/test_logs/game_allows_user_to_pick_marker_log.rb", "rb")    # store the ouput in a variable to be read
        @output_from_picking_X = output.read                            # convert contents from file into string to be used in spec
    end

    it "allows user to pick X" do 
        expect(@output_from_picking_X).to eql(
            "Welcome to my Tic Tac Toe game\n
            |_0_|_1_|_2_|\n
            |_3_|_4_|_5_|\n
            |_6_|_7_|_8_|\n
            What would you like to be: X's or O's. Please enter\n
            That is not a valid entry. Type X or O and press enter\n
            You selected X!\n
            Please select your spot by typing one of these positions: 0,1,2,3,4,5,6,7,8 then press enter\n
            |_0_|_1_|_X_|\n
            |_3_|_O_|_5_|\n
            |_6_|_7_|_8_|\n
            a is not available. Please enter one of these positions available: 0,1,3,5,6,7,8\n
            |_O_|_X_|_X_|\n
            |_3_|_O_|_5_|\n
            |_6_|_7_|_8_|\n
            |_O_|_X_|_X_|\n
            |_X_|_O_|_5_|\n
            |_6_|_7_|_O_|\n
            Game over\n".gsub(/^\s+/,""))       # Using regex to remove space after \n
    end
    before do
        new_inputt = StringIO.new("1\nO\n2\na\n1\n3\n")  # Create a new IO Object that will feed input to STDIN
        allow($stdin).to receive(:gets) {new_inputt.gets}    # stub STDIN with lines from new_input  
        game = Game.new
        $stdout = File.open("./spec/test_logs/game_allows_user_to_pick_marker_log.rb", "a+")    # Feed $stdout to a new log file
        game.start_game 
        $stdout.flush                                                   # Stop streaming $stdout to to log file
        $stdout = STDOUT                                                # point $stdout back to STDOUT
        output = File.open("./spec/test_logs/game_allows_user_to_pick_marker_log.rb", "rb")    # store the ouput in a variable to be read
        @output_from_picking_O = output.readlines[19..37].join                        # select and convert contents from file into string to be used in spec
    end

    it "allows user to pick O" do 
        expect(@output_from_picking_O).to eql(
            "Welcome to my Tic Tac Toe game\n
            |_0_|_1_|_2_|\n
            |_3_|_4_|_5_|\n
            |_6_|_7_|_8_|\n
            What would you like to be: X's or O's. Please enter\n
            That is not a valid entry. Type X or O and press enter\n
            You selected O!\n
            Please select your spot by typing one of these positions: 0,1,2,3,4,5,6,7,8 then press enter\n
            |_0_|_1_|_O_|\n
            |_3_|_X_|_5_|\n
            |_6_|_7_|_8_|\n
            a is not available. Please enter one of these positions available: 0,1,3,5,6,7,8\n
            |_X_|_O_|_O_|\n
            |_3_|_X_|_5_|\n
            |_6_|_7_|_8_|\n
            |_X_|_O_|_O_|\n
            |_O_|_X_|_5_|\n
            |_6_|_7_|_X_|\n
            Game over\n".gsub(/^\s+/,""))       # Using regex to remove space after \n
  end
end
