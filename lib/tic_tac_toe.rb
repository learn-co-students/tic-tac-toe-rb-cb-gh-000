WIN_COMBINATIONS = [
[0,1,2], # Top row
[3,4,5],  # Middle row
[6,7,8],
[0,3,6],
[1,4,7],
[2,5,8],
[0,4,8],
[6,4,2]
]
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def display_board(board)
  puts  " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts  " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts  " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)

  input = input.to_i
  input-=1
end

def move(board,index,token)
  board[index]=token
end

def valid_move?(board,index)
  if index >=0 && index<=8 && board[index]!= "X" && board[index]!= "O"
    answer = true;
  else answer = false
  end
  answer
end

def turn_count(board)
  skaicius = 0
  board.each do |elementas|
  if elementas == "X" || elementas == "O"
    skaicius+=1
  end
  end
  skaicius
end

def turn(board)
input = gets
  input = input_to_index(input)
  answer = valid_move?(board,input)
token = current_player(board)
  if answer

    move(board,input,token)
    display_board(board)
  else

     turn(board)
  end
end

def current_player(board)
  ska = turn_count(board)
  if ska % 2 == 0
    token = "X"
  else token ="O"
  end
end

def won?(board)
masyv= []
  WIN_COMBINATIONS.each do |masyvas|
    sk1 = masyvas[0]
    sk2 = masyvas[1]
    sk3 = masyvas[2]

    if board[sk1] =="X" && board[sk2] =="X" && board[sk3] =="X" || board[sk1] =="O" && board[sk2] =="O" && board[sk3] =="O"
      masyv = masyvas
      break
    else masyv = false
    end
  end
masyv
end

def full?(board)
ats = board.all? do |elementas|
    if elementas == "X" || elementas == "O"
      true
    else false
  end
end
  ats

end

def draw?(board)
  ans = won?(board)
  ans2 = full?(board)
  if ans == false && ans2 == true
    atsakymas = true
  else atsakymas = false
  end
end

def over?(board)
  ans1 = draw?(board)
  ans2 = won?(board)
  ans3 = full?(board)

  if ans1 == true || ans2 != false || ans3 == true
    atsakymas=true
  else atsakymas = false
  end
atsakymas
end

def winner(board)

  ans2 =won?(board)

  if ans2 == false
    atsakymas = nil
  elsif board[ans2[0]] =="X"
    atsakymas = "X"
  elsif board[ans2[0]] =="O"
    atsakymas = "O"

  end


atsakymas
end

def play(board)
  while over?(board)!= true do
  puts "Please enter 1-9:"

  turn(board)
  end
  atsa = draw?(board)
  ans2 =winner(board)
  if ans2 =="X"
  puts "Congratulations X!"
elsif atsa ==true
  puts "Cat's Game!"
else puts "Congratulations O!"
  end



end
