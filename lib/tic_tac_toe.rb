def play(board)
  until over?(board) do
    turn(board)
  end
  if draw?(board)
    puts 'Cats Game!'
  else
    puts "Congratulations #{winner(board)}!"
  end
end

def turn_count(board)
  turns = 0
  board.each do |t|
    turns += 1 if t == 'X' || t == 'O'
  end
  turns
end

def current_player(board)
  turns = turn_count(board)
  turns % 2 == 0 ? 'X' : 'O'
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
  WIN_COMBINATIONS.each do |w|
    if position_taken?(board, w[0])
      c = board[w[0]]
      return w if board[w[1]] == c && board[w[2]] == c
    end
  end
  false
end

def full?(board)
  (0..8).all? do |i|
    position_taken?(board, i)
  end
end

def draw?(board)
  (!won?(board) && full?(board))
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  won = won?(board)
  won ? board[won[0]] : nil
end

def display_board(board)
  (0..2).each do |row|
    puts " #{board[(row*3)]} | #{board[(row*3)+1]} | #{board[(row*3)+2]} "
    puts '-----------' if row < 2
  end
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, pos, c)
  board[pos] = c
end

def valid_move?(board, pos)
  return false if pos > 8 || pos < 0
  return false if position_taken?(board, pos)
  true
end

def turn(board)
  moved = false
  while moved == false do
    puts 'Please enter 1-9:'
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
      move(board, index, current_player(board))
      moved = true
      display_board(board)
    end
  end
end
