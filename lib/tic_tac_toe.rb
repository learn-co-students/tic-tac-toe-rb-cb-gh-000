def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
      counter+=1  
    end
  end
  return counter
end
  
def current_player(board)
  if turn_count(board) % 2 == 0 
    return 'X'
  else 
    return 'O'
  end
end


# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  [0, 1, 2], #Top row
  [3, 4, 5], #Middle row
  [6, 7, 8], #Bottom row 
  [0, 3, 6], #First Column
  [1, 4, 7], #Second Column
  [2, 5, 8], #Third Column
  [0, 4, 8], #First Diagonal
  [2, 4, 6] #Second Diagonal
  ]

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    if (combination.all? {|pos| board[pos] == "X"})
      return combination
    elsif (combination.all? {|pos| board[pos] == "O"})
      return combination
    end
  end
  return false
end

def full?(board)
  return (board.all? {|mark| mark == "X" || mark == "O"})
end

def draw?(board)
  return (full?(board) && won?(board) == false)
end

def over?(board)
  return (won?(board) || draw?(board) || full?(board))
end

def winner(board)
  return won?(board) ? board[won?(board)[0]] : nil
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

def move(board, index, play1 = "X")
  board[index] = play1
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    mark = current_player(board)
    move(board, index, mark)
    #display_board(board)
  else
    turn(board)
  end
end

# Define your play method below

def play(board)
  iter = 0
  loop do
    if iter >= 9 || over?(board)
      if winner(board) == "X"
        puts "Congratulations X!"
      elsif winner(board) == "O" 
        puts "Congratulations O!"
      elsif draw?(board)
        puts "Cat's Game!"
      end
      break
    end
    iter+=1
    turn(board)
  end
end
