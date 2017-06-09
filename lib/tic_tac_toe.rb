def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def position_taken?(board, index)
  board[index] == "O" || board[index] == "X"
end

def valid_move?(board, index)
  index >= 0 && index <= 8 && !position_taken?(board, index)
end

def move(board, index, value)
  board[index] = value
end

def input_to_index(inp)
  if inp =~ /\A\d+\z/ ? true : false then
    inp.to_i - 1
  else
    -1
  end
end

def turn(board)
  index = -1
  puts "Please enter 1-9:"
  index = input_to_index(gets.split[0])
  while !valid_move?(board, index) do
    index = input_to_index(gets.split[0])
  end
  move(board, index, current_player(board))
  display_board(board)
end

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
PLAYER_WON = [
  ["X", "X", "X"],
  ["O", "O", "O"]
]

def won?(board)
  wc = []
  won = false
  WIN_COMBINATIONS.any? do |coomb|
    cc = [board[coomb[0]], board[coomb[1]], board[coomb[2]]]
    wc = coomb
    won = PLAYER_WON.include?(cc)
    won
  end
  if won then
    wc
  else
    false
  end
end

def full?(board)
  board.all?{|space| space != " "}
end

def draw?(board)
  full?(board) && won?(board) == false
end

def over?(board)
  draw?(board) || won?(board) != false
end

def winner(board)
  wc = won?(board)
  if wc == false then
    nil
  else
    coomb = [board[wc[0]], board[wc[1]], board[wc[2]]]
    coomb == PLAYER_WON[0] ? "X" : "O"
  end
end

def turn_count(board)
  k = 0
  board.each do |place|
    if ["X", "O"].include?(place) then
      k += 1
    end
  end
  k
end

def current_player(board)
  ["X", "O"][turn_count(board) % 2]
end

def play(board)
  until over?(board)
    turn(board)
  end

  win = winner(board)
  if win == nil then
    puts "Cats Game!"
  else
    puts "Congratulations #{win}!"
  end
end
