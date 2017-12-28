WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]
def line
  puts "-----------"
end
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  line
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  line
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
def input_to_index(input)
  input.to_i - 1
end

def move(board,index,character)
  board[index]=character
end
def position_taken?(board,index)
  if board[index]==nil
    return false
  elsif board[index].strip==""
    return false
  else
    return true
  end
end
def valid_move?(board,index)
  if index.between? 0,8 and !position_taken? board,index
    return true
  end
end
def turn(board)
  puts "Please enter 1-9:"
  turn = input_to_index gets.strip.to_i
  if valid_move? board,turn
    move board,turn,current_player(board)
    display_board board
  else
    turn board
  end
end
def turn_count(board)
  count = 0
  board.each do |str|
    if str.strip!=""
      count+=1
    end
  end
  return count
end

def current_player(board)
  count = turn_count board
  if count % 2 == 0
    return "X"
  else
    return "O"
  end
end
def won?(board)
  WIN_COMBINATIONS.each do |w|
    n=["X","O"]
    count = 0
    2.times do
      if board[w[0]]==n[count] and board[w[1]]==n[count] and board[w[2]]==n[count]
        return w
      else
        count+=1
      end
    end
  end
  return false
end

def full?(board)
 not board.any? { |e| e.strip=="" }
end

def draw?(board)
  not won? board and full? board
end

def over?(board)
  draw? board or won? board
end

def winner(board)
  arr = won? board
  if arr
    return board[arr[0]]
  else
    return nil
  end
end

def play(board)
  9.times do
  if not over? board
    turn board
  elsif won? board
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
  end
end
