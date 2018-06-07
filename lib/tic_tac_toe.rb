# Helper Method
def display_board(board, divider="-----------")
  display_row(board, 0)
  puts divider
  display_row(board, 1)
  puts divider
  display_row(board, 2)
end

def display_row(board, row_index)
  puts " #{board[3 * row_index]} | #{board[3 * row_index + 1]} | #{board[3 * row_index + 2]} "
end

def input_to_index(number_input)
  return number_input.to_i - 1
end

def move(board, index, char)
  board[index] = char
end

def valid_move?(board, position)
  return position.between?(0, board.length - 1) && !position_taken?(board, position)
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def turn(board)
  position = input_to_index(gets.strip)
  until valid_move?(board, position)
    position = input_to_index(gets.strip)
  end
  move(board, position, current_player(board))
end

def turn_count(board)
  return board.count{|square| square == "X" || square == "O"}
end

def current_player(board)
  return turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    if winning_combination?(board, win_combination)
      return win_combination
    end
  end
  return nil
end

def winning_combination?(board, win_combination)
  square = board[win_combination[0]]
  win_combination.each do |index|
    if !position_taken?(board, index) || square != board[index]
      return false
    end
  end
  return true
end

def full?(board)
  return !(board.include?(" ") || board.include?("") || board.include?(nil))
end

def draw?(board)
  return !won?(board) && full?(board)
end

def over?(board)
  return draw?(board) || won?(board)
end

def winner(board)
  result = won?(board)
  return result.nil? ? nil : board[won?(board)[0]]
end

def play(board)
  until over?(board)
    turn(board)
  end
  winner = winner(board)
  puts winner.nil? ? "Cat's Game!" : "Congratulations #{winner}!"
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6]
]
