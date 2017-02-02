WIN_COMBINATIONS = [
  [0, 1, 2],[3, 4, 5],[6, 7, 8],
  [0, 3, 6],[1, 4, 7],[2, 5, 8],
  [0, 4, 8],[2, 4, 6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = (input.to_i - 1)
end

def move(board, index, character)
  return board[index] = character
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0, 8) && !position_taken?(board, index)
    true
  end
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

def turn_count(board)
  counter = 0

  board.each do |token|
    if token == "X"
      counter += 1
    elsif token == "O"
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

def won?(board)
  WIN_COMBINATIONS.each do |comb|
    if (board[comb[0]] == "X" && board[comb[1]] == "X" && board[comb[2]] == "X") || (board[comb[0]] == "O" && board[comb[1]] == "O" && board[comb[2]] == "O")
      return comb
    end
  end
  false
end

def full?(board)
  board.all? { |token| token == "X" || token == "O"  }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  winner = won?(board)

  if winner
    if board[winner[0]] == "X" && board[winner[1]] == "X" && board[winner[2]] == "X"
      "X"
    else
      "O"
    end
  end
end

def play(board)

  until over?(board)
    turn(board)
  end

  if draw?(board)
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end

end
