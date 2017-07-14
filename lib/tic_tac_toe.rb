
#!/usr/bin/env ruby
def input_to_index(input)
  return input.to_i - 1
end

def valid_move?(board, index)
  if index.between?(0, 8)
    return !position_taken?(board, index)
  else
    return false
  end
end

def move(board, converted_input, character)
  board[converted_input] = character
  return board
end

def one_line(array_name, index_1, index_2, index_3)
  puts " #{array_name[index_1]} | #{array_name[index_2]} | #{array_name[index_3]} "
end

def dash_line
  puts "-----------"
end

def display_board(board)
  one_line(board, 0, 1, 2)
  dash_line
  one_line(board, 3, 4, 5)
  dash_line
  one_line(board, 6, 7, 8)
end


def turn(board, character = "X")
  puts "Please enter 1-9:"

  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index, character)
    display_board(board)
  else
    turn(board, character)
  end

end


# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
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
  [2, 4, 6]
]

def won?(board)
  counter = 0
  until counter == 8
    combo = WIN_COMBINATIONS[counter]

    if ( (board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X") || (board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O") )
      return combo
    else
      counter += 1
    end
  end

end

def full?(board)
  j = 0

  board.each do |square|
    if (square == "X" || square == "O")
      j += 1
    end
  end

  return (j == 9)
end


def draw?(board)
  if (full?(board) && (won?(board) == nil) )
    return true
  end
end


def over?(board)
  return (draw?(board) || (won?(board) != nil) )
end


def winner(board)
  if won?(board) != nil
    winning_combo = won?(board)
    return board[winning_combo[0]]

  else
    return nil
  end

end

def turn_count(board)
  counter = 0

  board.each do |space|
    if (space == "X" || space == "O")
      counter += 1
    end
  end

  return counter
end

def current_player(board)
  turns = turn_count(board)

  if turns % 2 == 0
    return "X"
  else
    return "O"
  end

end


# Define your play method below
def play(board)
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
  
  while !over?(board)
    character = current_player(board)
    puts "It's your turn, Player #{character} "
    turn(board, character)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
