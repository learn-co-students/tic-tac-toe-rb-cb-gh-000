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
  for j in 0...3
    puts "-----------" if j > 0
    for i in 0...3
       if i > 0 then print "| #{board[(j*3)+i]} " else print " #{board[(j*3)+i]} " end
    end
    puts
  end
end

def input_to_index(input)
  if input.empty? then -1 else input.to_i - 1 end
end

def move(board, player_choice, player_char)
  board[player_choice] = player_char
end

def position_taken?(board, index)
  return !(board[index].nil? || board[index].empty? || board[index]==" ")
end

def valid_move?(board, index)
  if index > 8 || index < 0 || position_taken?(board,index) then false else true end
end

def turn(board)
  puts "Please enter 1-9:"
  player_choice = input_to_index(gets)
  if valid_move?(board, player_choice)
    move(board, player_choice, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  board.select { |c| c != ' '}.count
end

def current_player(board)
  if turn_count(board) % 2 != 0 then 'O' else 'X' end
end

def won?(board)
  WIN_COMBINATIONS.each do |cur_combination|
    if board[cur_combination[0]] == board[cur_combination[1]] && board[cur_combination[1]] == board[cur_combination[2]]
        return cur_combination unless board[cur_combination[0]] == ' '
    end
  end
  return nil
end

def full?(board)
  !board.include?(' ')
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  return true if won?(board) || draw?(board)
end

def winner(board)
  WIN_COMBINATIONS.each do |cur_combination|
    if board[cur_combination[0]] == board[cur_combination[1]] && board[cur_combination[1]] == board[cur_combination[2]]
        return board[cur_combination[0]] unless board[cur_combination[0]] == ' '
    end
  end
  return nil
end

def play(board)
  until over?(board) do
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
