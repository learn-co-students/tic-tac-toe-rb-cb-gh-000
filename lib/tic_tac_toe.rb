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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} \n"
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} \n"
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} \n"
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

def valid_move?(board,index)
  !position_taken?(board,index) && board[index] && index >= 0
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    win = winner(board)
    puts "Congratulations #{win}!"
  else
    puts "Cats Game!"
  end
end

def turn(board)
  player = current_player(board)
  puts "Player '#{player}', please enter input [1-9]: "
  input = gets.strip
  index = input_to_index(input)
  if (valid_move?(board,index))
    move(board,index,player)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |index|
    if index == "X" || index == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  count = turn_count(board)
  if count.even?
    return "X"
  end
  return "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    combX = combination.select do |index|
      board[index] == "X"
    end
    if combX.size == 3
      return combX
    end
    combO = combination.select do |index|
      board[index] == "O"
    end
    if combO.size == 3
      return combO
    end
  end
  return false
end

def full?(board)
  board.all? do |index|
    index == "O" || index == "X"
  end
end

def draw?(board)
  (!won?(board)) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  win = won?(board)
  if win
    board[win[0]]
  end
end
