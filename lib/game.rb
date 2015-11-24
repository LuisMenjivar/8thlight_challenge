class Game
  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @com = nil
    @hum = nil
  end

  def start_game
    puts "Welcome to my Tic Tac Toe game"
    puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
    if @hum == nil 
      get_symbol 
    end
    puts "You selected #{@hum}!\nPlease select your spot by typing one of these positions: #{get_available_spaces.join(",")} then press enter"
    until game_is_over(@board) || tie(@board)
      get_human_spot
      if !game_is_over(@board) && !tie(@board)
        eval_board
      end
      puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
    end
    puts "Game over"
  end

  def get_human_spot
    spot = nil
    while true
      spot = $stdin.gets.chomp               #point gets to $stdin explicitly.
      if get_available_spaces.include? spot  #check if user input is available.
        @board[spot.to_i] = @hum
        break
      else
        puts "#{spot} is not available. Please enter one of these positions available: #{get_available_spaces.join(",")}" 
        next
      end
    end
  end

  def get_available_spaces
    available_spaces = []
    @board.each do |number_string|
      if number_string != "X" && number_string != "O" 
        available_spaces << number_string
      end
    end
    available_spaces
  end

  def get_symbol
      print "What would you like to be: X's or O's. Please enter\n"
      while true
      @hum = $stdin.gets.chomp
      if @hum == "x" || @hum == "X"
        @com = "O"
        @hum = "X"
        break
      elsif @hum == "o" || @hum == "O" || @hum == "0"
        @com = "X"
        @hum = "O"
        break
      else
        puts "That is not a valid entry. Type X or O and press enter"
        next
      end
    end
  end

  def eval_board
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @com
      else
        spot = get_best_move(@board, @com)
        if @board[spot] != "X" && @board[spot] != "O"
          @board[spot] = @com
        else
          spot = nil
        end
      end
    end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != "X" && s != "O"
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      board[as.to_i] = @com
      if game_is_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @hum
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end
    if best_move
      return best_move
    else
      n = rand(0..available_spaces.count)
      return available_spaces[n].to_i
    end
  end

  def game_is_over(b)

    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie(b)
    b.all? { |s| s == "X" || s == "O" }
  end

end


# game = Game.new
# game.start_game
