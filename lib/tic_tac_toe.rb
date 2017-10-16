
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],[3,4,5],[6,7,8],
  [0,3,6],[1,4,7],
  [2,5,8],[0,4,8],[6,4,2]
]
@winner = nil

def won? board
  WIN_COMBINATIONS.each do |win_combination|
    x_wins = win_combination.all? do |index|
      board[index] == "X"
    end
    if x_wins
      @winner = "X"
      return win_combination
    end
    o_wins = win_combination.all? do |index|
      board[index] == "O"
    end
    if o_wins
      @winner = "O"
      return win_combination
    end
  end
  return false
end

def full? board
  board.all?{|position| position == "X" || position == "O"}
end

def draw? board
  !(won?(board)) && full?(board)
end

def over? board
  draw?(board) || won?(board)
end

def winner board
  won? board
  @winner
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index,current_player(board) )
    display_board(board)
  else
    turn(board)
  end
end

def turn_count board
    board.count{|position| position == "X" || position == "O"}
end

def current_player board
    turns_made = turn_count board
    turns_made % 2 == 0 ? "X" : "O"
end

# Define your play method below
def play board
  until over? board
    turn(board)
  end
  if @winner
    puts "Congratulations #{@winner}!"
  else
    puts "Cats Game!"
  end
end
