
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
  [2,4,6],
  [0,4,8]
]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn_count(board)
  c = 0
  board.each do |i|
    if i.strip != ""
      c+=1
    end
  end
  return c
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def valid_move?(board, index)
  if index.between?(0, 8) && board[index].strip == ""
    return true
  else
    return false
  end
end
def is_number?(string)
  true if Float(string) rescue false
end

def input_to_index(index)
  if  is_number?(index)
    return index.to_i-1
  else
    return -1
  end
end

def move(board, index, char)
  board[index] = "#{char}"
end

def won?(board)
  WIN_COMBINATIONS.each do |i|
    if board[i[0]] =="X" && board[i[1]] == "X" && board[i[2]] == "X"
      return i
    elsif board[i[0]] =="O" && board[i[1]] == "O" && board[i[2]] == "O"
      return i
    end
  end
  return false
end

def full?(board)
  return !board.include?(" ")
end

def draw?(board)
  return !won?(board) && full?(board)
end

def over?(board)
  return won?(board) || draw?(board) || full?(board)
end

def winner(board)
  winner_array = won?(board)
  if winner_array
    return board[winner_array[0]]
  else
    return nil
  end
end

def turn(board)
  char = current_player(board)
  puts "Please enter 1-9:"
  index = gets.strip
  index = input_to_index(index)
  if valid_move?(board, index)
    move(board, index, char)
    display_board(board)
  else
    while !valid_move?(board, index)
      index = gets.chomp.to_i
      index = input_to_index(index)
    end
  end
end


def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end

end
