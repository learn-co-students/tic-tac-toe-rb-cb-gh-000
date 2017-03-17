WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[2,4,6],[0,4,8]]
def display_board(array)
     puts " #{array[0]} | #{array[1]} | #{array[2]} "
     puts "-----------"
     puts " #{array[3]} | #{array[4]} | #{array[5]} "
     puts"-----------"
     puts " #{array[6]} | #{array[7]} | #{array[8]} "
  end

  def input_to_index(input= -1)
   a = input.to_i
   b = a - 1
   return b
  end
  def move(array, index, value)
    array[index] = value
  end
  def position_taken?(board,index)
    if board[index] == " " || board[index] == "" or board[index]==nil
      false
    else
      true
    end
  end
  def valid_move?(board,index)
    if index.between?(0,9) && !position_taken?(board,index)
      true
    else
      false
    end
  end
  def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  while  !valid_move?(board,index)
  input = gets.strip
  index = input_to_index(input)
end
move(board,index,current_player(board))
display_board(board)

end
  def turn_count(board)
  count = 0
  board.each { |position|
  if position =="X" ||position =="O"
    count += 1
  end
  }
  return count
  end
  def current_player(board)
    if turn_count(board) % 2 ==0
      "X"
    else
      "O"
    end
  end
  def won?(board)
     won = false
     WIN_COMBINATIONS.each do |win_combination|
     win_index_1 = win_combination[0]
     win_index_2 = win_combination[1]
     win_index_3 = win_combination[2]
     po_1 = board[win_index_1]
     po_2 = board[win_index_2]
     po_3 = board[win_index_3]
       if po_1=="X" && po_2 == "X" && po_3 == "X"
        return  won = [win_index_1,win_index_2,win_index_3]
      elsif po_1=="O" && po_2 == "O" && po_3 == "O"
        return  won = [win_index_1,win_index_2,win_index_3]
       end
    end
    return won
  end

  def full?(board)
    return board.all? do |po|
      po == "X" || po =="O"
    end
  end
  def draw?(board)
    if  !won?(board) &&full?(board)
      return true
    else
      false
    end
  end


  def over?(board)
    if draw?(board) || full?(board) || won?(board)
      return true
    else return false
    end
  end
  def winner(board)
     if won?(board)
     won_combination = won?(board)
     won_position = won_combination[0]
      return  board[won_position]
    else
      return   nil
    end
  end
def play(board)
until over?(board)do
  turn(board)
end
if won?(board)
  puts "Congratulations #{winner(board)}!"
elsif draw?(board)
  puts "Cats Game!"
end
end
