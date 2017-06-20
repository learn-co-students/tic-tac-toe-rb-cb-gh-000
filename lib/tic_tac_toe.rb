def display_board(board)
  row1 = " #{ board[0]} | #{board[1]} | #{board[2] } "
  row2 = " #{ board[3]} | #{board[4]} | #{board[5] } "
  row3 = " #{ board[6]} | #{board[7]} | #{board[8] } "
  divider = "-----------"
  puts row1
  puts divider
  puts row2
  puts divider
  puts row3
end

def input_to_index(input)
  index = input.to_i - 1
  return index
end

def valid_move?(board, index)
  if index >= 0 && index <= 8 && !position_taken?(board, index)
    return true
  else
    return false
  end
end

def move(board, index, value)
  if valid_move?(board, index)
    board[index] = value
    display_board(board)
  else
    turn(board)
  end
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def turn(board)
  puts "Where would you like to go?"
  input = gets.strip
  index = input_to_index(input)
  value = current_player(board)
  move(board, index, value)
end

def turn_count(board)
  (board.select{|i| i == "X" || i == "O"}).size
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #toprow
  [3,4,5], #midrow
  [6,7,8], #botrow
  [0,3,6], #leftcol
  [1,4,7], #midcol
  [2,5,8], #rightcol
  [0,4,8], #trbl
  [2,4,6] #tlbr
]

def full?(board)
  !(board.detect{|position| position == " " || position == "" || position == nil})
end

def draw?(board)
  !(won?(board)) && full?(board)
end

winning_player = String.new

def won?(board)
  xwin = Array.new
  owin = Array.new
  index = 0

  board.each do |position|
    if position_taken?(board, index) && position == "X"
      xwin << index
    elsif position_taken?(board, index) && position == "O"
      owin << index
    end
    index+=1
  end

  WIN_COMBINATIONS.each do |winner|
    if (winner & xwin) == winner||(winner & owin) == winner
      return winner
    end
  end

  return false
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  xwin = Array.new
  owin = Array.new
  index = 0

  board.each do |position|
    if position_taken?(board, index) && position == "X"
      xwin << index
    elsif position_taken?(board, index) && position == "O"
      owin << index
    end
    index+=1
  end

  WIN_COMBINATIONS.each do |winner|
    if (winner & xwin) == winner
      return "X"
    elsif (winner & owin) == winner
      return "O"
    end
  end

 return nil
end


def play(board)
  if over?(board)
    if won?(board)
      puts "Congratulations " + winner(board) + "!"
    elsif draw?(board)
      puts "Cats Game!"
    end
  else
    turn(board)
    play(board)
  end
end
