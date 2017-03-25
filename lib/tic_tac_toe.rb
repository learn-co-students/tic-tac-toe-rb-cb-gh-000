# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],

]

def won?(board)
  WIN_COMBINATIONS.each do |wincombo|
      if (board[wincombo[0]] == "X" && board[wincombo[1]] == "X" && board[wincombo[2]] == "X") || (board[wincombo[0]] == "O" && board[wincombo[1]] == "O" && board[wincombo[2]] == "O")
        return wincombo
      end
    end
    false
end

def full?(board)
  board.all? do |square|
    square.include?("X") || square.include?("O")
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  if draw?(board) || won?(board) || full?(board)
    true
  end
end

def winner(board)
  wincombo = won?(board)
  if wincombo != false
    return board[wincombo[0]]
  end
  nil
end

def turn_count(board)
  turns = 0
  board.each do |square|
    if square.include?("X")  || square.include?("O")
      turns += 1
    end
  end
  turns
end

def current_player(board)
  turns = turn_count(board)
  if turns % 2 == 0
    "X"
  else
    "O"
  end
end

def valid_move?(board, index)
  if index >= 0 && index <=8 && !position_taken?(board, index)
    true
  else
    false
  end
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index].nil?
    false
  else
    true
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, token)
  board[index] = token
  return board
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  token = current_player(board)
  if valid_move?(board, index)
    move(board, index, token)
    display_board(board)
  else
    turn(board)
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
