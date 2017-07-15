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

# Helper? methods

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

def display_board(_val)
  val = "   "
  for i in 0...3
    line = ""
    for j in 0..2
      val = " #{_val[3*i+j]} "
      if j!=2
          line += val+"|"
      else
          line += val
      end
    end
    puts line
    if i != 2
      puts "-----------"
    end
  end
end

def input_to_index(n)
  index = n.to_i - 1
end

def move(board,index,letter)
  board[index] = letter
end

def position_taken?(board, index)
  !(board[index] == " " || board[index] == "")
end

def valid_move?(board,index)
 !(index<0 || board[index]==nil || position_taken?(board,index))
end


def turn(board)
  puts "Please enter 1-9:"
  index = gets.strip
  index = input_to_index(index)
  until(valid_move?(board,index))
    puts "Please enter 1-9:"
    index = gets.strip
    index = input_to_index(index)
  end
    move(board,index, current_player(board))
    display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |letter|
    if (letter == "X" || letter == "O")
      count +=1
    end
  end
  return count
end


def current_player(board)
  ((turn_count(board)+2)%2 == 0) ? "X" : "O"
end


def won?(board)
  comb =  false

  WIN_COMBINATIONS.each do |w|
    arr = []
    filled = w.all? do |i|
      arr << board[i]
      position_taken?(board,i)
    end
    if filled
      if(arr[0] == arr[1])
        if(arr[1] == arr[2])
          comb = w
        end
      end
    end
  end
  return comb
end

def full?(board)
  isit = true
  for i in 0...9
    if(!position_taken?(board,i))
      isit = false
      break
    end
  end
  return isit
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  token = nil
  a = won?(board)
  if a
    token = board[a[0]]
  end
  return token
end
