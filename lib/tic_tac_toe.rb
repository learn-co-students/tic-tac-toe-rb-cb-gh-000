WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row

  [0,3,6], # Left row
  [1,4,7], # Middle row
  [2,5,8], # Right row

  [0,4,8], # Cross Left
  [2,4,6] # Cross Right
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(i)
  return i.to_i-1
end

def move(board,index,player)
  board[index] = player
end

def position_taken?(board,index)
 return board[index]=="O" || board[index]=="X" ? true:false
end

def valid_move?(board,index)
 if index >= 0 && index <=8
   return !position_taken?(board,index)
 else
   return false
 end
end

def turn(board)
  chk=0
  while chk==0
    puts "Position Input: "
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board,index)
      player = current_player(board)
      move(board,index,player)
      display_board(board)
      chk = 1
    end
  end
end

def turn_count(board)
 return board.select{|i| i!=" "}.size
end

def current_player(board)
  return turn_count(board) % 2 == 0 ? "X":"O"
end

def won?(board)
    chkwon = 0
    WIN_COMBINATIONS.each do |win_combination|

    # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
    # grab each index from the win_combination that composes a win.
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

     if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
        chkwon = 1
        return win_combination # return the win_combination indexes that won.
     end
   end
   if chkwon == 0
     return false
   end
end

def full?(board)
 return board.none?{|i| i ==" "}
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
 if won?(board)
   return true
 elsif draw?(board)
   return true
 else
   return false
 end
end

def winner(board)
 win_combination = won?(board)
 if win_combination != false
  return board[win_combination[0]]
 else
   return nil
 end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations " + winner(board) +"!"
  else
    puts "Cat's Game!"
  end
end
