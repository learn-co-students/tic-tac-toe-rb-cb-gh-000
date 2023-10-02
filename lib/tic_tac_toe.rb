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

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],  # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Left row
  [1,4,7],  # Other Middle row
  [2,5,8],  # Right row
  [0,4,8],  # First diagonal
  [6,4,2]   # Second diagonal
]

def won?(board)
  WIN_COMBINATIONS.each do |win_comb|
    index1=win_comb[0]
    index2=win_comb[1]
    index3=win_comb[2]

    pos1=board[index1]
    pos2=board[index2]
    pos3=board[index3]

    if pos1 == pos2 && pos1 == pos3 && pos2 == pos3 && position_taken?(board,index1)==true
      return win_comb
    end
  end
  return(nil)
end

def full?(board)
  i=0
  while i<9
    if position_taken?(board,i)==false
      return false
    end
    i+=1
  end
  return true
end

def draw?(board)
  if full?(board)==true
    if !(won?(board)==nil)
      return false
    else
      return true
    end
  else
    return false
  end
end

def over?(board)
  if won?(board) || full?(board)==true
    return true
  end
  return false
end

def winner(board)
if over?(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    return nil
  end
else
  return nil
end
end


def turn_count(board)
  # board.count{|token| token == "X" || token == "O"}
  turns = 0
  board.each do |token|
    if token == "X" || token == "O"
      turns += 1
    end
  end
  turns

end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end



def move(board, index, current_player)
  board[index] = current_player
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

# Define your play method below
def play(board)
  while !(over?(board))
    turn(board)
  end
  if won?(board)
    puts("Congratulations #{winner(board)}!")
  elsif draw?(board)
    puts("Cat's Game!")
  end
end
