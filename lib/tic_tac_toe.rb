
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end
def turn_count(board)
  count = 0
  board.each do |e|
    if(e == "X" || e == "O")
      count += 1
    end
  end
  count
end
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end
def current_player(board)
  if turn_count(board) % 2 == 1
    "O"
  else
    "X"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board) )
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
def play(board)
  while (over?(board) != true && !won?(board) != false && draw?(board) != true)
    turn(board)

  end

  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  else
    puts "Cats Game!"
  end

end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6],[0,3,6],[2,5,8],[1,4,7]
]


def won?(board)
  xIndex = []
  oIndex = []
  counter = 0
  board.each do |chr|
    if chr == "X"
      xIndex.push(counter)
    elsif chr == "O"
      oIndex.push(counter)
    end
    counter += 1
  end
  WIN_COMBINATIONS.any? do |e|
    if (e - xIndex).empty? || (e - oIndex).empty?
      return e
    else
      false

    end
  end

end
def full?(board)
  counter = 0
  board.each { |chr|
    if chr == "X" || chr == "O"
      counter += 1
    end }
  if counter == 9
    true
  else
    false
  end
end
def draw?(board)
  if won?(board)
    false
  else
    if full?(board)
      true
    else
      false
    end
  end
end

def over?(board)
  if full?(board)
    true
  else
    false
  end
end
def winner(board)
  xIndex = []
  oIndex = []
  counter = 0
  board.each do |chr|
    if chr == "X"
      xIndex.push(counter)
    elsif chr == "O"
      oIndex.push(counter)
    end
    counter += 1
  end
  WIN_COMBINATIONS.any? do |e|
    if (e - xIndex).empty?
      return "X"

    elsif (e - oIndex).empty?
      return "O"
    end


    end
    return nil
  end
