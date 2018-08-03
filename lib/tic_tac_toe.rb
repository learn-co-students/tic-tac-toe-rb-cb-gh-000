
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

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

def valid_move?(board, index)

  index.between?(0,8) && !position_taken?(board, index)

end

def turn(board)

  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end

end

def turn_count(board)

  turns = 0

  board.each do | value |

    if value == "X" || value == "O" then
      turns += 1
    end

  end

  turns

end

def current_player(board)

  # Assumes X alway goes first

  #if turn_count(board) % 2 == 1 then
  #  "O"
  #else
  #  "X"
  #end

  turn_count(board) % 2 == 1 ? "O" : "X"

end

def won?(board)

  WIN_COMBINATIONS.each do |combination|

    combo_value = []

    combination.each do |position|

      if position_taken?(board, position)
        combo_value << board[position]
      end

    end

    if combo_value.size == 3 && combo_value[0] == combo_value[1] && combo_value[1] == combo_value[2] then

      return combination

    end

  end

  false

end

def full?(board)

  result = board.all? do |position_value|
    position_value == "X" || position_value == "O"
  end

end

def draw?(board)

  !won?(board) && full?(board)

end

def over?(board)

  won?(board) || draw?(board)

end

def winner(board)

  if won?(board)

    #DBC, assumes won? array 3x same
    if board[won?(board)[0]] == "X"
      "X"
    elsif board[won?(board)[0]] == "O"
      "O"
    else
      nil
    end

  end

end

def play(board)

  until over?(board)

    turn(board)

  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end

end
