WIN_COMBINATIONS = [
  # horizontal win combinations
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],

  # vertical win combinations
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],

  # diagonal win combinations
  [0, 4, 8],
  [2, 4, 6]
]

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
  board[location] != " "
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  loop do
    puts "Please enter 1-9:"
    position = input_to_index(gets.strip)
    if valid_move?(board, position)
      move(board, position, current_player(board))
      display_board(board)
      break
    end
  end
end

def turn_count(board)
  turns = 0
  board.each do |position|
    if position != " "
      turns += 1
    end
  end
  turns
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  end
  "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    position_1 = board[combination[0]]
    position_2 = board[combination[1]]
    position_3 = board[combination[2]]
    if (position_1 == position_2 && position_2 == position_3) && (position_1 == "X" || position_1 == "O")
       return combination
    end
  end
  false
end

def full?(board)
  !board.detect{|position| position == " "}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end


def winner(board)
  winner = won?(board)
  if !winner
    return nil
  end
  board[winner[0]]
end

def play(board)
  while(!over?(board))
    turn(board)
  end
  winner = winner(board)
  if winner.nil?
    puts "Cats Game!"
  else
    puts "Congratulations #{winner}!"
  end
end
