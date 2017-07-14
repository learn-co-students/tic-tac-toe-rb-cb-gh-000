WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  return input.to_i - 1
end

def move(board, position, char)
  board[position] = char
end

def position_taken?(board, index)
   index == " " || index == "" || index == nil || board[index] == "X" || board[index] == "O"
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index= input_to_index(input)
  if !valid_move?(board, index)
    turn(board)
  end

  move(board, index, current_player(board))
  display_board(board)
end

def turn_count(board)
  board.count{|e| e == "X" || e == "O"}
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    values = [
      board[win_combination[0]],
      board[win_combination[1]],
      board[win_combination[2]]
    ]
    if values.all? { |e| e == "X" } || values.all? { |e| e == "O" }
      return win_combination
    end
  end

  false
end

def full?(board)
  board.all? { |e| e == "X" || e == "O" }
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  full?(board) || draw?(board) || (!full?(board) && won?(board))
end

def winner(board)
  game_won = won?(board)

  if game_won
    return board[game_won[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
