def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " " || board[index] == "")
end


def valid_move?(board,index)
  if index.between?(0, 8)
    answer = !position_taken?(board,index)
  else
    answer = false
  end
  return answer
end

def move(board, index, player)
    if valid_move?(board,index)
      board[index] = player
      display_board(board)
    end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player = current_player(board)
  if valid_move?(board, index)
    move(board, index, player)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 9
  board.each do|value|
     if value == " " || value == "" || value == nil
       counter = counter - 1
     end
  end
  return counter
end

def current_player(board)
  count = turn_count(board)
  if count % 2 == 0
    return "X"
  else
    return "O"
  end
end
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

def won?(board)
  victory = false
  WIN_COMBINATIONS.each do |combination|
    if board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X"
      victory = combination
      break
    elsif board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"
      victory = combination
      break
    end
  end
  return victory
end

def full?(board)
  is_full = board.all? do |block|
    block == "X" || block == "O"
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if full?(board) || won?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  winner = won?(board)
    if winner == false
      return nil
    else
      board[winner[0]]
    end
end

def play(board)
  until over?(board) == true do
    turn(board)
  end
  if won?(board)
    victor = winner(board)
    puts "Congratulations #{victor}!"
  else
    puts "Cats Game!"
  end
end
