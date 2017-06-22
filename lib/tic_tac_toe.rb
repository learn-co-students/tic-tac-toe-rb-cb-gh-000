
def display_board board
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index user_input
  user_input.to_i - 1
end

def move board, index, current_player
  board[index] = current_player
end

def position_taken? board, location
  board[location] != " " && board[location] != ""
end

def valid_move? board, index
  index.between?(0,8) && !position_taken?(board, index)
end

def turn board
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def play board
  until over? board
    turn board
  end
  if won? board
    puts "Congratulations #{winner board}!"
  else
    puts "Cats Game!"
  end
end

def turn_count board
  board.reject {|i| i == ' ' || i == "" }.size
end

def current_player board
  %w[X O][turn_count(board) % 2]
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def wininfo board
  combination = WIN_COMBINATIONS.find do |combination|
    combination.map do |position|
      board[position]
    end.uniq.size == 1 && board[combination[0]].strip != ''
  end
  {
    combination: combination ? combination : false,
    winner: combination ? board[combination[0]] : nil
  }
end

def won? board
  wi = wininfo board
  wi[:combination]
end

def full? board
  board.size.times.all? do |position|
    position_taken? board, position
  end
end

def draw? board
  !won?(board) && full?(board)
end

def over? board
  won?(board) || draw?(board)
end

def winner board
  wi = wininfo board
  wi[:winner]
end
