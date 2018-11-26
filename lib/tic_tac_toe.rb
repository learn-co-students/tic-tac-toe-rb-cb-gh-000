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

def display_board(places)
  board_row_templates = [
    [' ', ' ', ' ', '|', ' ', ' ', ' ', '|', ' ', ' ', ' '],
    '-----------',
  ]

  places_counter = 0

  (0..4).each_with_index do |r|
    row = board_row_templates[r % 2]

    # Row dividers
    puts row if row.class == String

    # Content row - inject X/Os before this
    if row.class == Array
      cur_row = row
      cur_row[1] = places[places_counter + 0].gsub(/^$/, ' ')
      cur_row[5] = places[places_counter + 1].gsub(/^$/, ' ')
      cur_row[9] = places[places_counter + 2].gsub(/^$/, ' ')

      places_counter += 3

      puts cur_row.join ''
    end
  end
end

# code your input_to_index and move method here!
def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def valid_move?(board, index)
  if index >= 0 && index < board.length
    if board[index] == ' '
      return true
    end
  end

  false
end

def turn(board)
  puts 'Please enter 1-9:'
  input = gets.chomp

  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    puts 'Invalid move.  Try again.'
    turn(board)
  end
end

# Define your play method below
def play(board)
  until over?(board)
    turn(board)
    break if draw?(board)
  end
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
  return false unless board.detect { |i| i != ' ' }

  WIN_COMBINATIONS.each do |win|
    places = [board[win[0]], board[win[1]], board[win[2]]]

    unless places.detect { |i| i == ' ' }
      return win if places.all? { |i| i == places[0] }
    end
  end

  false
end

def full?(board)
  board.none? { |i| i == ' ' }
end

def draw?(board)
  if full?(board)
    if won?(board)
      false
    else
      true
    end
  else
    false
  end
end

def over?(board)
  if full?(board) || won?(board)
    true
  else
    false
  end
end

def winner(board)
  win_type = won?(board)

  if win_type
    return board[win_type[0]]
  end

  nil
end

def turn_count(board)
  count = 0

  board.each do |i|
      count += 1 if i != ' '
  end

  count
end

def current_player(board)
  return 'X' unless turn_count(board) % 2 == 1
  return 'O'
end
