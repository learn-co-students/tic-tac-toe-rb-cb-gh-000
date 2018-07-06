WIN_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8],
  [0,3,6], [1,4,7], [2,5,8],
  [0,4,8], [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i ? input.to_i - 1 : -1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  board[index] == " " ? false : true
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index) ? true : false
end


def turn_count(board)
  (board.select { |element| element == 'X' or element == "O" }).size
end

def current_player(board)
  turn_count(board) % 2 == 0 ? 'X' : 'O'
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  until valid_move?(board, index)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  end

  move(board, index, current_player(board))
  display_board(board)
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    if board[combination[0]] == board[combination[1]] and board[combination[0]] == board[combination[2]]
      if board[combination[0]] != ' '
        return combination
      end
    end
  end
  false if board.any? { |e| e != ' ' }
end

def full?(board)
  !board.any? { |e| e == " " }
end

def draw?(board)
  !won?(board) and full?(board)
end

def over?(board)
  draw?(board) or won?(board)
end

def winner(board)
  won = won?(board)
  won.is_a?(Array) ? board[won[0]] : nil
end

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
  display_board(board)
end
