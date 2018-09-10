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

def input_to_index(user_input)
  user_input.to_i - 1
end

def player_move(board, index, player_character)
  board[index] = player_character
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  counter = 0
  board.each do |players|
    players == 'X' || players == 'O' ? counter += 1 : nil
  end
counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? 'X' : 'O'
end

def won?(board)
  WIN_COMBINATIONS.each do |combinations|
    if (board[combinations[0]] == 'X' && board[combinations[1]] == 'X' && board[combinations[2]] == 'X') || (board[combinations[0]] == 'O' && board[combinations[1]] == 'O' && board[combinations[2]] == 'O')
      return combinations
    end
  end
  false
end

def full?(board)
  !board.include?(" " || "" || nil)
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  winner = won?(board)
  if !winner
    return nil
  elsif board[winner[0]] == 'X'
    return 'X'
  elsif board[winner[0]] == 'O'
    return 'O'
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player_character = current_player(board)
  if valid_move?(board, index)
    player_move(board, index, player_character)
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
