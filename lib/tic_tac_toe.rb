WIN_COMBINATIONS=[
                  [0,1,2],
                  [3,4,5],
                  [6,7,8],
                  [0,3,6],
                  [1,4,7],
                  [2,5,8],
                  [0,4,8],
                  [6,4,2]
                    ]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  return user_input.to_i-1
end

def move(board,position,player)
  board[position]=player
end

def position_taken?(board,position)
  if board[position] == " " || board[position]  == ""
    return false
  else
    return true
  end
end

def valid_move?(board,position)
  while position.to_i.between?(0,9)
    if position_taken?(board,position)
      return false
    else
      return true
    end
  end
  return false
end

def turn_count(board)
  count=0
  board.each { |e|
    if e == "X" || e == "O"
      count+=1
    end
   }
   return count
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end


def turn(board)
puts "Please Enter 1-9"
user_input=gets.strip
index=input_to_index(user_input)
if valid_move?(board,index)
  player=current_player(board)
  move(board,index,player)
  return board
else
  turn(board)
end
end

def won?(board)
  WIN_COMBINATIONS.each { |e|
    if board[e[0]] == board[e[1]] && board[e[0]] == board[e[2]] && board[e[0]] != " "
      return e[0]
    end
   }
  return false
end

def full?(board)
board.all? { |e|
  e == "X" || e == "O"
 }
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    win_combo=won?(board)
    return board[win_combo]
  end
end

def play(board)
  while !over?(board)
    turn(board)
    display_board(board)
  end
  if over?(board)
    if winner(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cat\'s Game!"
    end
  end
end
