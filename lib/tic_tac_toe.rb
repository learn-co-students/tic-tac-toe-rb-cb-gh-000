def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    winner_id = winner(board)
    puts "Congratulations #{winner_id}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end


# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
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

def won?(board)
  winning_combo = false

  WIN_COMBINATIONS.each do | combo |
    win_index_1 = combo[0]
    win_index_2 = combo[1]
    win_index_3 = combo[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]


    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return combo
    end
  end

  return false
end


def full?(board)
  return !board.include?(" ")
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  end

  return false
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  end

  return false
end

def winner(board)
  if over?(board) && !draw?(board)
    winning_combo = won?(board)
    index = winning_combo[0]
    return board[index]
  end

  return nil
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)
  curr_player = current_player(board)

  if valid_move?(board, index)
    move(board, index, curr_player)
  else
    while true
      puts "Please enter 1-9:"
      input = gets.strip
      index = input_to_index(input)

      if index >= 1 || index <= 9
        break
      end
    end
  end

  display_board(board)
end

# code your #valid_move? method here
def valid_move?(board, index)
  potential_move = board[index]

  if position_taken?(board, index) || index < 0 || index > 8
    return false
  end

  return true
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(move_cell)
  x = move_cell.to_i
  if x > 0
    return move_cell.to_i - 1
  elsif x == 0
    return -1
  else
    return 0
  end
end

def move(board, index, player)
  board[index] = "#{player}"
  return board
end

def turn_count(board)
  return 9 - board.count(" ")
end

def current_player(board)
  num_turn = turn_count(board)
  if num_turn == 0 || num_turn % 2 == 0
    return "X"
  end

  return "O"
end