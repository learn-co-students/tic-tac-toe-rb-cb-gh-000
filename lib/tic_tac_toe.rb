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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(user_input)
  return user_input.to_i - 1
end

def move(board,position,char)
  board[position] = char
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
  if index.between?(0,8) == true
    if position_taken?(board,index) == false
      return true
    else
      return false
    end
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"

  index = gets.chomp
  index = input_to_index(index)

  if valid_move?(board,index) == true
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
  end

  def turn_count(board)
  counter = 0

  board.each do | element |

    if element ==  "X" || element == "O"
      counter += 1
    end
  end
    return counter
end

def current_player(board)

  if turn_count(board).even? == true
    return "X"
  elsif turn_count(board).odd? == true
    return "O"
  end
end


def won?(board)

counter = 0
loop do
    win_combination = WIN_COMBINATIONS[counter]

    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3



    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif  position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
      else
         false
      end

      counter += 1

      if counter == 8
        break
      end

  end
end

def full?(board)

  board.none? {|i| i.include?(" ")}

end

def draw?(board)

!won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)

if won?(board)

  winner_array = won?(board)
  index = winner_array[0]

  winner = board[index]

  if winner == "X"
    return "X"
  elsif winner == "O"
    return "O"
  end
else
  return nil

end

end

def play(board)
  display_board(board)

  until over?(board)
    turn(board)
  end

  if(won?(board))
    puts "Congratulations #{winner(board)}!"
  elsif(draw?(board))
    puts "Cats Game!"
  end

end
