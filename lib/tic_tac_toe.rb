def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def turn_count(board)
  counter = 0;
  board.each do |elem|
    if elem == "X" || elem == "O"
      counter+=1
    end
  end
  counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6],[0,3,6],[1,4,7],[2,5,8]]
def won?(board)
  WIN_COMBINATIONS.each do |array|
    # if array.all? {|elem| board[elem]==board[elem] && position_taken?(board, elem)}
    array.each do |index|
    if position_taken?(board, index) && board[array[0]]==board[array[1]] && board[array[1]]==board[array[2]]
      # if position_taken?(board, index) && index==array[0]
      return array
      end
    end
  end
  return false
end

def full?(board)
  board.none? {|index| index == " "}
end

def draw?(board)
  !won?(board)&&full?(board)
end

def over?(board)
  won?(board)||draw?(board)||full?(board)
end

def winner(board)
  if input = won?(board)
    board[input[0]]
end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  token = current_player(board)
  if valid_move?(board, index)
    move(board, index, token)
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cat's Game!"
  end
end
