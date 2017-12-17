

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 4, 8],
  [2, 4, 6],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8]
]

def won?(board)
  if board == []
    return false
  elsif board == [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    return false
  end
  for win_combination in WIN_COMBINATIONS
    x_matchcount = 0
    o_matchcount = 0
    win_combination.each do |winposition|
      if board[winposition].include?("X")
        x_matchcount += 1
      end
      if board[winposition].include?("O")
        o_matchcount += 1
      end
    end
    if x_matchcount == 3
      return win_combination
    end
    if o_matchcount == 3
      return win_combination
    end
  end

  return false
end

def full?(board)
  full = false
  full = board.none?{|position| position == " "}
end

def draw?(board)
  draw = false
  if won?(board) == false
    if board.none?{|pos| pos == " " || pos == ""}
      draw = true
    end
  end
  if full?(board) == true
    draw = true
  end
  if won?(board) == true
    draw = false
  return draw
end

def over?(board)
  if won?(board) != false
    return true
  elsif draw?(board) == true
    return true
  elsif full?(board) == true
    return true
  else return false
  end
end

def winner(board)
  winner = nil
  if won?(board) != false
    if board[won?(board)[0]] == "X"
      winner = "X"
    elsif board[won?(board)[0]] == "O"
      winner = "O"
    end
  end
  return winner
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
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
def play(board)
  turn_count = 0
  until turn_count == 9
    turn(board)
    turn_count += 1
  end
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space != " "
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end
