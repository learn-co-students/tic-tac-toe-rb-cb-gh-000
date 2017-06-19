WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

## Helper Methods
# ----------------------------------------------------------------
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
  win_combo = nil
  WIN_COMBINATIONS.each do |winning_combo|
    positions = [nil,nil,nil]
    winning_combo.each_with_index do |comboSpace, index|
        positions[index] = board[comboSpace]
    end
    ["X","O"].each do | player |
      if positions.all?{|pos| pos==player}
        win_combo = winning_combo
      end
    end
  end
  win_combo
end

def full?(board)
  board.all?{|pos| pos != " "}
end

def draw?(board)
  full?(board) and (not won?(board))
end

def over?(board)
  won?(board) or draw?(board)
end

def winner(board)
  winning_positions = won?(board)
  if !winning_positions.nil?
    winning_player = winning_positions[0]
    board[winning_player]
  else
    nil
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn_count(board)
  counter = 0
  board.each do |e|
    counter += 1 unless e == " "
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

def input_to_index(index)
  return index.to_i - 1
end

def move(board, index, value)
  if valid_move?(board,index)
    board[index] = value
  end
end

def valid_move?(board,index)
  index > -1 and index < 9 and !(position_taken?(board,index))
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip.to_i)
  until index.between?(0,8) and valid_move?(board, index)
    puts "Please enter 1-9:"
    index = input_to_index(gets.strip.to_i)
  end
  player = current_player(board)
  move(board, index, player)
  display_board(board)
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end

  #if the game was won
  #  congratulate the winner
  #else if the game was a draw
  #  tell the players it has been a draw
  #end
end
