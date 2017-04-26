# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS  = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

def won?(board)
    WIN_COMBINATIONS.each do |win_combination|
        win_index_1 = win_combination[0]
        win_index_2 = win_combination[1]
        win_index_3 = win_combination[2]

        position_1 = board[win_index_1]
        position_2 = board[win_index_2]
        position_3 = board[win_index_3]

        if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
            (position_1 == "O" && position_2 == "O" && position_3 == "O")
            return win_combination
        end
    end
    return false
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# full? method
def full?(board)
  board.none?{ |postion|  postion == " " || postion == nil }
end

# draw? method
def draw?(board)
  !won?(board) && full?(board)
end

# over? method
def over?(board)
  draw?(board) || won?(board)
end

# winner method
def winner(board)
    return won?(board) ? board[won?(board)[0]] : nil
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

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board, current_player = "X")
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  while !valid_move?(board, index)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  end
    move(board, index, current_player)
    display_board(board)
end

# Define your play method below
def play(board)
  count = 0
  while !over?(board)
    turn(board, current_player(board))
    if won?(board)
        puts "Congratulations #{winner(board)}!"
        return
    elsif draw?(board)
        puts "Cats Game!"
        return
    end
  end
  if won?(board)
        puts "Congratulations #{winner(board)}!"
        return
    elsif draw?(board)
        puts "Cats Game!"
        return
    end
end

def turn_count(board)
  count = 0
  board.each do |position|
    if position != " "
      count = count + 1
    end
  end
  return count
end

def current_player(board)
  return turn_count(board).even? ? "X" : "O"
end
