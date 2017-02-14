WIN_COMBINATIONS = [
  [0,1,2],  # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Left column
  [1,4,7],  # Middle column
  [2,5,8],  # Right column
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

def position_taken?(board, index)
    if (board[index] == "" or board[index] == " " or board[index] == nil)
        return false
    end
    return true
end

def input_to_index(numstr)
    return numstr.to_i - 1
end

def move(board, index, char)
    board[index] = char
end

def valid_move?(board, index)
    if (index > 8 or
        index < 0 or
        index == nil or
        position_taken?(board, index))
        return false
    end
    return true
end

def turn(board)
    puts "Please enter 1-9:"
    raw_index = gets.strip
    index = input_to_index(raw_index)

    if valid_move?(board, index)
        move(board, index, current_player(board))
        display_board(board)
    else
        turn(board)
    end
end

def turn_count(board)
    count = 0
    board.each do |content|
        if content == "X" or content == "O"
            count += 1
        end
    end

    return count
end

def current_player(board)
    current_player = turn_count(board) % 2 == 0? "X" : "O"
    return current_player
end

def won?(board)
    WIN_COMBINATIONS.each do |combination|
        if board.all?{|box| box == " "}
            return false
        end
        position = []

        combination.each do |index|
            position << board[index]
        end

        if position.all?{|box| box == "X"} or position.all?{|box| box == "O"}
            return combination
        end
    end
    return false
end

def full?(board)
  if board.any?{|box| box == " "}
    return false
  else
    return true
  end
end

def draw?(board)
    !won?(board) && full?(board)
end

def over?(board)
    if full?(board) or won?(board) or draw?(board)
        return true
    end
    return false
end

def winner(board)
    if won?(board)
        return board[won?(board)[0]]
    end
end

def play(board)
    while !over?(board)
        turn(board)
    end
    if won?(board)
        puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
        puts "Cats Game!"
    end
end
