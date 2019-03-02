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

def move(board, index, player_token)
  board[index] = player_token
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
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

#count how many turns have been played
def turn_count(board)
  count = 0
    board.each do |space|
      if (space == 'X' || space == 'O')
        count += 1
      end
    end
    return count
end

#find whether it's X's turn or O's turn, where X goes first
def current_player(board)
  turn_count(board)%2 == 0 ? "X" : "O"
end

#check if the board has a winning combination from either player "X" or "O"
def won?(board)
  fin = false
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination  #returns the winning index combinations
    else
      fin = false
    end
  end
  return fin
end

#check if board is full, and no more legal moves can be played
def full?(board)
  return (board.none? { |i| i.nil?}) && (board.none? { |i| i == " "});
end

def draw?(board)
  if(full?(board) && !won?(board))
    true
  else
    false
  end
end

#check if the game has been drawn or won
def over?(board)
  if(draw?(board) || won?(board))
    true
  else
    false
  end
end

#determine whether 'X' or 'O' won the game if a winning combination is present
def winner(board)
  won_board = won?(board)
  if(won_board.kind_of?(Array))
    board[won_board[0]]
  else
    nil
  end
end

#store all winning tic tac toe combinations
WIN_COMBINATIONS = [
  [0,1,2],  #Top row
  [3,4,5],  #Middle row
  [6,7,8],  #Bottom row
  [0,3,6],  #Left column
  [1,4,7],  #Middle column
  [2,5,8],  #Right column
  [0,4,8],  #Top-left to bottom-right diagonal
  [2,4,6]  #Top-right to bottom-left diagonal
]

#play through an entire game of Tic Tac Toe
def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
