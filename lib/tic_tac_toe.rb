def display_board(board)
  board.each_with_index do |cell,i|
    if i%3==0 and i>0
      puts "\n-----------"
    elsif i>0
      print "|"
    end
    print " #{cell} "
  end
  print "\n"
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  b=false
  if index>=0 && index<board.length && !position_taken?(board, index)
    b=true
  end
  return b
end

def input_to_index(index)
  return index.strip.to_i-1
end

def move(array, index, value)
  array[index] = value
end

def turn(board)
  m=["X", "O"]
  puts "Please enter 1-9:"
  index=input_to_index(gets)
  valid=valid_move?(board, index)
  until valid do
    puts "Please enter 1-9:"
    index=input_to_index(gets)
    valid=valid_move?(board, index)
  end
  move(board, index, m[turn_count(board)%2])
  display_board(board)
end

def turn_count(board)
  n=0
  board.each do |cell|
    if cell=="X" || cell=="O"
      n+=1
    end
  end
  return n
end

def current_player(board)
  m=["X", "O"]
  return m[turn_count(board)%2]
end

def get_win_combinations()
  i=0
  n=0
  m=[]
  while i<3 do
    temp_m=[]
    j=0
    while j<3 do
      temp_m[j]=3*i+j
      j+=1
    end
    m[n]=temp_m
    n+=1
    i+=1
  end
  i=0
  while i<3 do
    temp_m=[]
    j=0
    while j<3 do
      temp_m[j]=3*j+i
      j+=1
    end
    m[n]=temp_m
    n+=1
    i+=1
  end
  i=0
  temp_m=[]
  while i<3 do
    temp_m[i]=3*i+i
    i+=1
  end
  m[n]=temp_m
  n+=1
  i=0
  temp_m=[]
  while i<3 do
    temp_m[i]=3*i+(2-i)
    i+=1
  end
  m[n]=temp_m
  return m
end

WIN_COMBINATIONS=get_win_combinations()

def won?(board)
  combination=nil
  WIN_COMBINATIONS.each do |win_combination|
    if win_combination.all?{|index| position_taken?(board, index)}
      if win_combination.all?{|index| board[index] == "X"} ||
        win_combination.all?{|index| board[index] == "O"}
        combination=win_combination
        break
      end
    end
  end
  return combination
end

def full?(board)
  indexes=[]
  0.upto(board.length-1){|i| indexes[i]=i}
  return indexes.all?{|index| position_taken?(board, index)}
end

def draw?(board)
  return full?(board) && !won?(board)
end

def over?(board)
  return won?(board) || full?(board) || draw?(board)
end

def winner(board)
  b=nil
  combination=won?(board)
  if !combination.nil?
    b=board[combination[0]]
  end
  return b
end

def play(board)
  while !over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
  puts "Cat's Game!"
  end
end
