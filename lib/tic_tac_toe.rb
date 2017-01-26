def valid_move?(board, index)
  index_valid = index >= 0 && index < board.length
  !board.empty? && index_valid  && !position_taken?(board, index)
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6],
]

def won?(board)
  WIN_COMBINATIONS.detect do |combination|
    player = board[combination[0]]
    combination.all? do |cell|
        position_taken?(board, cell) && board[cell] == player
    end
  end
end

def full?(board)
  board.all? {|cell| cell == "X" || cell == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if winning_combination = won?(board)
    board[winning_combination[0]]
  end
end


def turn_count(board)
  board.find_all {|cell| (cell == "X" || cell == "O")}.count
end

def current_player(board)
  if turn_count(board) % 2 == 0 then "X" else "O" end
end

def display_board(board)
  for row in 0..2
    for col in 0..1
      print " #{board[row * 3 + col]} |"
    end
    puts " #{board[row * 3 + 2]} "
    if row < 2
      puts "-----------"
    end
  end
end

def move(board, pos, player)
  board[pos] = player
end

def input_to_index(input)
  input.to_i - 1
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  if valid_move?(board, index)
    board[index] = current_player(board)
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  display_board(board)
  while !over?(board) do
    turn(board)
  end
  if winning_player = winner(board)
    puts "Congratulations #{winning_player}!"
  else
    puts "Cats Game!"
  end
end
