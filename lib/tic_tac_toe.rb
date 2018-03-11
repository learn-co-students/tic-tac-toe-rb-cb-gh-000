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
  s = "-----------"

  puts " #{board[0]} | #{board[1]} | #{board[2]} ",s
  puts " #{board[3]} | #{board[4]} | #{board[5]} ",s
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

def turn_count(board)
  counter = 0

  board.each do | token |
    counter = token == "X" || token == "O" ? counter + 1 : counter
  end

  return counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def turn(board)
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

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    pos1 = board[win_index_1]
    pos2 = board[win_index_2]
    pos3 = board[win_index_3]

    if pos1 == "X" && pos2 == "X" && pos3 == "X"
      return win_combination
    elsif pos1 == "O" && pos2 == "O" && pos3 == "O"
      return win_combination
    end
  end
  return false
end


def full?(board)
  board.each do |token|
    if token != "X" && token != "O"
      return false
    end
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  win_indexes = won?(board)

  if win_indexes == false
    return nil
  else
    return board[win_indexes[0]]
  end
end

def play(board)
  9.times do
    if(over?(board))
      if(won?(board))
        puts "Congratulations #{winner(board)}!"
      elsif draw?(board)
        puts "Cat's Game!"
      end
      break
    end

    turn(board)
  end
end