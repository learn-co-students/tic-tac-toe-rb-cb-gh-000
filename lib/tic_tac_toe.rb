WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  # Vertical
  [0,3,6],
  [1,4,7],
  [2,5,8],
  # Diagonal
  [0,4,8],
  [6,4,2]
]

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

def update_array_at_with(array, index, value)
  array[index] = value
end

def input_to_index(input)
  return input.to_i - 1
end

def move(board, index, character)
  update_array_at_with(board, index, character)
end

def valid_move?(board, index)
    if (index < 0 || index - 1 > board.length)
        return false
    end

    return (position_taken?(board, index) == false)
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    if (combinationMatch?(board, combination, 'X') || combinationMatch?(board, combination, 'O'))
      return true
    end
  end
  return false
end

def combinationMatch?(board, combination, character)
  return combination.all? do |index|
      board[index] == character
  end
end

def draw?(board)
  if (full?(board) && !won?(board))
    return true
  end
  return false
end

def full?(board)
  return !(board.include?(' ') || board.include?(''))
end

def over?(board)
  return won?(board) || full?(board) || draw?(board)
end

def winner(board)
  winner = won?(board)
  if (winner == false)
    return nil
  else
    WIN_COMBINATIONS.each do |combination|
      if (combinationMatch?(board, combination, 'X'))
        return 'X'
      elsif (combinationMatch?(board, combination, 'O'))
        return 'O'
      end
    end
  end
end

def turn_count(board)
  turnsTaken = 0
  board.each  do |tile|
    if tile == "X" || tile == "O"
      turnsTaken +=1
    end
  end
  return turnsTaken
end

def current_player(board)
  return turn_count(board) % 2 == 0 ? 'X': 'O'
end

def play(board)
  until over?(board) || won?(board) do
    puts 'Turn starting'
      turn(board)
  end
  gameWinner = winner(board)
  if (gameWinner != nil)
    puts "Congratulations #{gameWinner}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end
