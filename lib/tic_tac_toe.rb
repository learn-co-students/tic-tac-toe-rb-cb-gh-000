#Definicion de la constante
WIN_COMBINATIONS =[
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
def input_to_index(user_input)
  user_input.to_i-1
end
def move(board,position,char)
  board[position] = char
end
def position_taken?(board,position)
  if board[position] != " "
    true
  else
    false
  end
end
def valid_move?(board,index)
  if board[index] == " " && index >= 0
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
    input = gets.to_i
    llamado = input_to_index(input)
    validacion = valid_move?(board,llamado)
    if validacion == true
      move(board,llamado,current_player(board))
      display_board(board)
    else
      turn(board)
  end
end
def turn_count(board)
  veces = 0
  board.each do |dato|
    if dato != " "
      veces += 1
    end
  end
  veces
end
def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end
def won?(board)
  WIN_COMBINATIONS.any? do |grupo|
    if board[grupo[0]] != " " && board[grupo[0]] == board[grupo[1]] && board[grupo[1]] == board[grupo[2]]
      true
    else
      false
    end
  end
end
def full?(board)
  board.all? {|index| index == "X" || index == "O"}
end

def draw?(board)
  if !won?(board) && full?(board)
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
  WIN_COMBINATIONS.detect do |interno|
    if board[interno[0]] != " " && board[interno[0]] == board[interno[1]] &&  board[interno[1]] ==  board[interno[2]]
      return board[interno[0]]
    else
    end
    end
end



def play(board)
  until over?(board) == true
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
