def display_board(board)
  line = []
  Array.new(3) {|x| x * 3}.each { |x|
    t = board[x..(x+2)]
    line.push(" " + t.join(" | ") + " ")
  }
  puts line.join("\n" + (["-"] * 11).join("") + "\n")
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def input_to_index(input)
  input.match(/^\d+$/) ? input.to_i - 1 : -1
end

def move(board, index, char)
  board[index] = char
end

def valid_move?(board, index)
  (index < 0 || index >= board.length) ? false : (board[index] == "" || board[index] == " " || board[index] == nil)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if !valid_move?(board, index)
    turn(board)
  else
    move(board, index, current_player(board))
    display_board(board)
  end
end

def turn_count(board)
  return board.select{|x| x != "" && x != " " && x != nil}.size
end

def current_player(board)
  return turn_count(board).even? ? "X" : "O"
end


# Define your WIN_COMBINATIONS constant
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
  WIN_COMBINATIONS.find do | pos |
    position_taken?(board, pos[0]) && board[pos[0]] == board[pos[1]] && board[pos[1]] == board[pos[2]]
  end
end

def full?(board)
  (0..8).all?{|x| position_taken?(board, x)}
end

def draw?(board)
  # full?(board) && ! won?(board)
  x = full?(board)
  y = won?(board)
  x && !y
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  win_pos = won?(board)
  win_pos ? board[win_pos[0]] : nil
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
