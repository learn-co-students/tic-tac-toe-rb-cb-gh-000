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

$win = []

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
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  player = "X"

  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    player = current_player(board)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def turn_count(board)
  turns = 0
  counter = 0

  while counter <= board.length
    if position_taken?(board, counter)
      turns += 1
    end

    counter += 1
  end

  turns
end

def current_player(board)
  turns = turn_count(board)

  if turns % 2 == 0
    player = "X"
  else
    player = "O"
  end

  player
end

def won?(board)
  WIN_COMBINATIONS.each do |comb|
    if position_taken?(board, comb[0])
      if board[comb[0]] == board[comb[1]] && board[comb[0]] == board[comb[2]]
        $win[0] = comb
        return true
      end
    end
  end

  return false
end

def full?(board)
  indexTaken = board.select{ |index| index == "X" || index == "O"}

  if indexTaken.length != board.length
    return false
  end

  return true
end

def draw?(board)
  if full?(board)
    if won?(board)
      return false
    else
      return true
    end
  end
  return false
end

def over?(board)
  if full?(board) || won?(board) || draw?(board)
    return true
  end

  return false
end

def winner(board)
  if over?(board)
    if won?(board)
      player = board[$win[0][0]]
      return player
    end
  end
end

def play(board)
  while over?(board) == false
    turn(board)
  end

  if draw?(board)
    puts "Cat's Game!"
  else
    winner = winner(board)
    puts "Congratulations #{winner}!"
  end
end
