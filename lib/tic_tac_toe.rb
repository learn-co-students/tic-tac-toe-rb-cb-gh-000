def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
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
  won = []
  combo = []
  WIN_COMBINATIONS.each do |combination|
    p_1 = board[combination[0]]
    p_2 = board[combination[1]]
    p_3 = board[combination[2]]
    if p_1 == "X" && p_2 == "X" && p_3 == "X"
      won << "X"
      combo << combination
    elsif p_1 == "O" && p_2 == "O" && p_3 == "O"
      won << "O"
      combo << combination
    end
  end
  if won.find{|i| i == "X"} && won.find{|i| i == "O"}
    return false
  elsif won.find{|i| i == "X"} || won.find{|i| i == "O"}
    return combo
  else
    return false
  end
end

def full?(board)
  if board.find{|i| i == " "} || board.find{|i| i == ""}
    return false
  else
    return true
  end
end

def draw?(board)
  i = full?(board)
  j = won?(board)
  if i && !j
    return true
  else
    return false
  end
end

def over?(board)
  draw = draw?(board)
  win = won?(board)
  if draw
    return true
  elsif win
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    combo = won?(board)
    winner = board[combo[0][0]]
    return winner
  else
    return nil
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(input)
  index = input.to_i
  index -= 1
end

def move(board, index, char)
  board[index] = char
end

def valid_move?(board, index)
  if position_taken?(board, index) || index > 8 || index < 0
    false
  else
    true
  end
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  index = gets.strip
  index = input_to_index(index)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    while !valid_move?(board, index)
      puts "Please enter 1-9:"
      index = gets.strip
      index = input_to_index(index)
    end
  end
end

def turn_count(board)
  count = 0
  board.each {|i|
    if i != " " && i != ""
      count += 1
    end
  }
  return count
end

def current_player(board)
  count = turn_count(board)
  count % 2 == 0 ? "X" : "O"
end


def play(board)

  while !over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  end
  winner = winner(board)
  puts "Congratulations #{winner}!"

end
