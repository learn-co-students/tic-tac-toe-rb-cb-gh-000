board=[" "," "," "," "," "," "," "," "," "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn_count(board)
  counter=0
  board.each do |position|
    if (position !=" ")
      counter+=1
    end
  end
  return counter
end

def current_player(board)
  if(turn_count(board)%2 == 0)
    return "X"
  else
    return "O"
  end
end

def move(board,index,current_player)
  board[index]=current_player
  board=[ "#{board[index]}" , "#{board[index]}" , "#{board[index]}" , "#{board[index]}" , "#{board[index]}" , "#{board[index]}" , "#{board[index]}" , "#{board[index]}" , "#{board[index]}" ]
end

def valid_move?(board,index)
  if board[index] == " " && index.between?(0,8)
    true
  else
    false
  end
end

def position_taken?(board, index)
  board[index] != " " && board[index] != ""
end

def input_to_index(user_input)
  index=user_input.to_i
  index=index-1
end

def turn(board)
  puts "Please enter 1-9:"
  user_input=gets.strip
  index=input_to_index(user_input)
  if valid_move?(board,index)
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts"Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts"Cat's Game!"
  end
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]

def won?(board)
  empty = board.all? do |space|
    space == " "
  end
  if empty
    return false
  end

  WIN_COMBINATIONS.each do |combo|
    if (board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]])
      if (board[combo[0]] != " ")
        return combo
      end
    end
  end

  if (full?(board) == true)
    return false
  end

end

def full?(board)
  isitempty = board.detect do |space|
    space == " "
  end

  if (isitempty == nil)
    return true
  else
    return false
  end
end

def draw?(board)
  if won?(board)
    return false
  elsif full?(board)
    return true
  end
end

def over?(board)
  if draw?(board)
    return true
  end

  if won?(board)
    return true
  else
    return false
  end
end

def winner(board)

  if draw?(board)
    return nil
  end

  if won?(board)
    WIN_COMBINATIONS.each do |combo|
    if (board[combo[0]]==board[combo[1]] && board[combo[1]]==board[combo[2]])
        if (board[combo[0]] == "X")
          return "X"
        end
        if (board[combo[0]] == "O")
          return "O"
        end
      end
    end
  end
end
