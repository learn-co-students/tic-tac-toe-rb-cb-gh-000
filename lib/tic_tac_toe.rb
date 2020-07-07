def display_board(board=[" "," "," "," "," "," "," "," "," "])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  return input.to_i-1
end

def position_taken?(board=[" "," "," "," "," "," "," "," "," "],index=0)
  return (board[index]=="X")||(board[index]=="O")
end

def valid_move?(board=[" "," "," "," "," "," "," "," "," "],index=0)
  if position_taken?(board,index)
    return false
  elsif (index>8) || (index<0)
    return false
  end
  return true
end

def move(board,index,input)
  if valid_move?(board,index)
    board[index]=input
    return true
  else
    return false
  end
end

def turn_count(board=[" "," "," "," "," "," "," "," "," "])
  counter=0
  board.each do |input|
    if (input=="X")||(input=="O")
      counter+=1
    end
  end
  return counter
end

def current_player(board)
  counter=turn_count(board)
  if counter%2==0
    return "X"
  end
  return "O"
end

def turn (board=[" "," "," "," "," "," "," "," "," "])
  puts "Please enter 1-9:"
  input=gets.strip
  index=input_to_index(input)
  input=current_player(board)
  test=move(board,index,input)
  until test
    puts "Please enter 1-9:"
    input=gets.strip
    index=input_to_index(input)
    input=current_player(board)
    test=move(board,index,input)
  end
  display_board(board)
end

WIN_COMBINATIONS=[[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6],[0,3,6],[1,4,7],[2,5,8]]

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    if (board[win_combination[0]]==board[win_combination[1]])&&(board[win_combination[1]]==board[win_combination[2]])&&((board[win_combination[1]]=="X")||(board[win_combination[1]]=="O"))
      return win_combination
    end
  end
  return false
end

def full?(board)
  return !(board.include?(" "))
end

def draw?(board)
  return (full?(board)&&!won?(board))
end

def over?(board)
  return (draw?(board)||won?(board))
end

def winner(board)
  arr=won?(board)
  if arr!=false
    return board[arr[0]]
  end
  return nil
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if draw?(board)
    puts"Cat's Game!"
  else
    input=winner(board)
    puts "Congratulations #{input}!"
  end
end
