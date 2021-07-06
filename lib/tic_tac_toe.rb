def display_board(board)
    puts "--------------"
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
    converted_input = user_input.to_i - 1
end

def move(board, position, token)
    board[position] = token
end

def position_taken?(board, index)
    board[index] == "X" || board[index] == "O"
end

def valid_move?(board, index)
    index.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
    token = current_player(board)
    puts "#{token}, enter a number 1-9:"
    user_input = gets
    converted_index = input_to_index(user_input)
    if valid_move?(board, converted_index)
        move(board, converted_index, token)
        display_board(board)
        return true
    else
        turn(board)
    end
end

def turn_count(board)
    board.count { |token| token == "X" || token == "O" }
end

def current_player(board)
    turn_count(board).even? ? "X" : "O"
end

def won?(board)
    WIN_COMBINATIONS.detect do |combo|
        board[combo[0]] == board[combo[1]] &&
        board[combo[1]] == board[combo[2]] &&
        position_taken?(board, combo[0])
    end
end

def full?(board)
    board.all?{ |token| token == "X" || token == "O"}
end

def draw?(board)
    !won?(board) && full?(board)
end

def over?(board)
    won?(board) || draw?(board)
end

def winner(board)
    if winning_combo = won?(board)
        board[winning_combo.first]
    end
end
#WIN_COMBINATIONS
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

def play(board)
    turn(board) until over?(board)
    if won?(board)
        winna = winner(board)
        puts "Congratulations #{winna}!"
    elsif draw?(board)
        puts "Cat's Game!"
    end
end
