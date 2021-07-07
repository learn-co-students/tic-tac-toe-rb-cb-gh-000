def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn(board)
  puts "Please enter 1-9:"
  index = gets.strip
  input_to_index(index)
  until valid_move?(board,petrovich(index))
    puts "Please enter 1-9:"
    index = gets.strip
  end
  move(board,petrovich(index))
  display_board(board)

end

def valid_move?(board,index)
  if position_taken?(board,index) == true && index > 9 && index < 0
    return false
  elsif position_taken?(board,index) == false && index < 9 && index > -1
    return true
  end
end

def position_taken?(board,index)
  if board[index] == "" || board[index] == " " ||board[index] == "nil"
    return false
  elsif board[index] == "X" || board[index] == "O"
    return true
  else
    return false
  end
end

def input_to_index(index)
  index.to_i - 1
end
def petrovich(index)
  index.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end


def display_board(board = [" "," "," "," "," "," "," "," "," "])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "

  #puts row[0]="#{board[0]},"|",#{board[1]},"|", #{board[2]}"
  #puts row[1]="-----------"
  #puts row[2]="#{board[3]},"|",#{board[4]},"|",#{board[5]}"
  #puts row[3]="-----------"
  #puts row[4]="#{board[6]},"|",#{board[7]},"|",#{board[8]}"
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

def turn_count(board)
  counter = 0
  for index in 0..9
    if board[index] == "X" || board[index] == "O"
      counter += 1
      index += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  elsif turn_count(board) % 2 == 1
    return "O"
  end

end

def play(board)
  counter = 0
  until counter == 9
    turn(board)
    counter += 1
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

def won?(board)
  WIN_COMBINATIONS.each {|win_combo|
    index_0 = win_combo[0]
    index_1 = win_combo[1]
    index_2 = win_combo[2]

    position_1 = board[index_0]
    position_2 = board[index_1]
    position_3 = board[index_2]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combo
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combo
    end
  }
  return false
end

def full?(board)
  board.all? {|index| index == "X" || index == "O"}
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner (board)
  index = []
  index = won?(board)
  if index == false
    return nil
  else
    if board[index[0]] == "X"
      return "X"
    else
      return "O"
    end
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations " + winner(board) + "!"
  elsif draw?(board)
    puts "Cat's Game!"
  else
    #do nothing
  end
end
