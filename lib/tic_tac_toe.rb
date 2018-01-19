
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
  input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0,8)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player = current_player(board)
  valid_move?(board, index) ? (move(board, index, player); display_board(board)) : turn(board)
end

def turn_count(board)
  count = 0
  board.each do |str|
     if str.strip!=""
       count+=1
     end
   end
   return count
end

def current_player(board)
  count = turn_count(board)
  count % 2 == 0 ? "X" : "O"
end

def won?(board)
  status= false
  WIN_COMBINATIONS.each do |win_array|
    if board[win_array[0]] == "X" && board[win_array[1]] == "X" && board[win_array[2]] == "X" || board[win_array[0]] == "O" && board[win_array[1]] == "O" && board[win_array[2]] == "O"
      return win_array
      break
    end
  end
status
end

def full?(board)
  if board.any? {|x| x== " " || x == "" || x.nil?}
    false
  else
    true
  end
end


def draw?(board)
  if !(won?(board)) && full?(board)
    true
  else
    false
  end
end

def over?(board)
  if draw?(board) || full?(board) || won?(board)
    true
  else
    false
  end
end

def winner(board)
  the_winner = won?(board)
  if !over?(board) || !won?(board)
    nil
  else
    board[the_winner[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  puts "Congratulations #{winner(board)}!" if won?(board)
  puts "Cat's Game!" if draw?(board)
end
