WIN_COMBINATIONS =[
            [0,1,2], #top row
            [3,4,5],  #middle row
            [6,7,8],  #bottom row
            [0,3,6],  #left column
            [1,4,7],  #middle column
            [2,5,8],  #right column
            [0,4,8],  #diagonal left
            [2,4,6]]  #diagonal right
def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
    puts "-----------"
end
def input_to_index(movement)
    movement.to_i-1
end

def move(boardAry, index, player)
    boardAry[index] = player
end

def position_taken?(board, index_number)
  if (board[index_number]==" ") || (board[index_number]=="")|| (board[index_number]==nil)
    false
  else
    true
  end
end

def valid_move?(board,index)
  if index >8 || index <0
    return false
  elsif !position_taken?(board,index)
    return true
  else
    return false
  end
end# re-define your #po

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    character = current_player(board)
    move(board, index, character)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
    counter = 0
    board.each do |player|
      if player == "X" || player =="O"
        counter +=1
      end
    end
    return counter
end

def current_player(board)
    if turn_count(board)%2==0
      return "X"
    else
      return "O"
    end
end

def won?(board)
    WIN_COMBINATIONS.each do |row|
            win1=row[0]
            win2=row[1]
            win3=row[2]
            if (board[win1] == "X" && board[win2] =="X" && board[win3]== "X") ||(board[win1] == "O" && board[win2] =="O" && board[win3]== "O")
            return row
            end
    end
    false
end

def full?(board)
  flag=true
    board.each do |elements|
        if elements== " "|| elements==""
            flag=false
        end
    end
    return flag
end

def draw?(board)
      a = full?(board)
      b = won?(board)
      a && !b
      #full?(board) && !won?(board)
end

def over?(board)
    if won?(board) || draw?(board) || full?(board)
      true
    else
      false
    end
end

def winner(board)
  ary = won?(board)
  if won?(board)
    return board[ary[0]]
  else
    return nil
  end
end

def play(board)
  until over?(board) || won?(board)
    turn(board)
  end
  if won?(board) != false
    player = winner(board)
    puts "Congratulations #{player}!"
  else
    puts "Cats Game!"
  end
end
