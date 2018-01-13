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

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  [0,1,2,3,4,5,6,7,8].include?(index) && !(position_taken?(board, index))
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player = current_player(board)
  valid_move?(board, index) ? (move(board, index, player); display_board(board)) : turn(board)
end

def turn_count(board)
  count = 0
  [0,1,2,3,4,5,6,7,8].each {|pos| (count += 1 if position_taken?(board, pos)) }
  return count
end

def current_player(board)
  count = turn_count(board)
  count % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    pos_1 = board[win_index_1]
    pos_2 = board[win_index_2]
    pos_3 = board[win_index_3]
    all_pos = [win_index_1, win_index_2, win_index_3].all? do |index|
      position_taken?(board, index)
    end

    ((return win_combination) if [pos_1, pos_2, pos_3].uniq.count == 1) if all_pos
  end
  return false
end

def full?(board)
  num = [0, 1, 2, 3, 4, 5, 6, 7, 8]
  all_pos = num.all? do |index|
    position_taken?(board, index)
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  winner = won?(board)
  won?(board) ? board[winner[0]] : nil
end

def play(board)
  until over?(board)
    turn(board)
  end
  puts "Congratulations #{winner(board)}!" if won?(board)
  puts "Cat's Game!" if draw?(board)
end
