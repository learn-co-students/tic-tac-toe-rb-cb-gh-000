def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS=[
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def position_taken_by(board, index)
  board[index]
end

def player_winner(board, combination, player)
  combination.all? do |el|
    position_taken?(board,el)
    position_taken_by(board,el)==player
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |c|
    player_winner(board,c,"X") || player_winner(board,c,"O")
  end
end

def full?(board)
  i=0
  board.all? do |el|
    el!=""&&el!=" "&&!el.nil?
  end
end

def draw?(board)
  !(won?(board))&&full?(board)
end

def over?(board)
  won?(board)||draw?(board) #full?(board) here I put draw? only to make the tests happy
end

def winner(board)
  c=won?(board)
  if c&&player_winner(board,c,"X")
    return "X"
  elsif c&&player_winner(board,c,"O")
    return "O"
  else
    return nil
  end
end

def input_to_index(index)
  (index.to_i)-1
end

def move(board, index, symbol)
  board[index]=symbol
end

def valid_move?(board, index)
  exists=index>=0 && index<9
  if exists
    !position_taken?(board, index)
  end
end

def turn(board)
  player=current_player(board)
  loop do
    puts "Please enter 1-9:"
    input=gets.strip
    index=input_to_index(input)
    if valid_move?(board, index)
      move(board, index, player)
      display_board(board)
      break
    end
  end
end

def line(board, lineNumber)
  puts " "+board[lineNumber*3+0]+" | "+board[lineNumber*3+1]+" | "+board[lineNumber*3+2]+" "
end

def separator
  puts "-----------"
end

def display_board(board)
  line(board,0)
  separator
  line(board,1)
  separator
  line(board,2)
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations " + winner(board) + "!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

def turn_count(board)
  counter=0
  board.each do |position|
    if position=="X" || position=="O"
      counter+=1
    end
  end
  counter
end

def current_player(board)
  turnN=turn_count(board)
  if turnN%2==0
    "X"
  else
    "O"
  end
end
