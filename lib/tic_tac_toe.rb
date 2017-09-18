def display_board (board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move? (board,index)
  if (index >= 0 && index < 8) && !position_taken?(board,index)
    true
  else
    false
  end
end

def position_taken? (board,index)
  if (board[index] == "" || board[index] == " " || board[index] == nil)
    false
  else
    true
  end

end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board,move,char)
  board[move] = char
  board
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant

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
def won? (board)
  WIN_COMBINATIONS.each do |combination|
    if ((board[combination[0]] == "X") && (board[combination[1]] == "X") && (board[combination[2]] == "X"))
      puts "Congratulations X!"

      return combination
    elsif ((board[combination[0]] == "O") && (board[combination[1]] == "O") && (board[combination[2]] == "O"))
      puts "Congratulations O!"

      return combination
    end
  end
  false
end

def turn_count(board)
  turns = 0
  board.each do |square|
    if square == "X" || square == "O"
      turns+=1
    end
  end
  turns
end

def current_player(board)
  if turn_count(board).even?
    answer = "X"
  else
    answer = "O"
  end
  return answer
end


def full? (board)
  counter = 0
  board.each do |square|
    if ((square == "X") || (square == "O"))
      counter+=1
    end
  end
  if counter > 8
    return true
  else
    return false
  end
end

def draw? (board)
  if full?(board) && !won?(board)
    puts "Cats Game!"
    return true
  end
end


def over? (board)
  if draw?(board) || won?(board)
    true
  end
end

def winner(board)

  win = won?(board)
  if win == false
    return nil

  elsif board[win[0]] == "X"
    return "X"

  elsif board[win[0]] == "O"
    return "O"
  end
end




def turn(board)
  invalid = true
  while invalid
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
      board = move(board, index, current_player(board))
      display_board(board)
      invalid = false
    end
  end
end

# Define your play method below
def play(board)
  until over?(board)
    turn(board)
    if draw?(board)
      break
    elsif won?(board)
      break
    end
  end
end
