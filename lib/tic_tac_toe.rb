

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
    [0,1,2], # Top row
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
    converted_input = input.to_i - 1
end

def move(board, input_to_index, current_player)
    board[input_to_index] = current_player
end

def position_taken?(board, index)
    if board[index] == " " || board[index] == "" || board[index] == nil
        return false
    elsif board[index] == "X" || board[index] == "O"
        return true
    end
end

def valid_move?(board, index)
    if position_taken?(board, index) == false && index.between?(0, 8)
        return true
    else
        return false
    end
end

def turn_count(board)
    counter = 0
    board.each do |turn|
        if turn.downcase == "x" || turn.downcase == "o"
            counter += 1
        end
	end
	counter
end

def current_player(board)
    turn_count(board)
    if turn_count.odd?  == true
    return "X"
    
    return "O"
    end
end

def won?(board)
    WIN_COMBINATIONS.detect do |combo|
        board[combo[0]] == board[combo[1]] &&
        board[combo[1]] == board[combo[2]] &&
        position_taken?(board, combo[0])
    end
end

def full?(board)
    
end

def draw?(board)
    if full?(board) == true && !won?(board)
        return true
    end
end

def over?(board)
    if full?(board) == false && !won?(board)
        return false
    elsif won?(board) == true || full?(board) == false
        return true
    elsif   draw?(board) == true || full?(board) == true || won?(board) == true
        return true
    end
end


def winner(board)
    won?(board)
        if WIN_COMBINATIONS.none? {|win_combination| win_combination == won?(board)}
            return nil
        else
        return board[won?(board)[0]]
    end
end

def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    input_to_index(input)
    if valid_move?(board, input_to_index)
        move(board, input_to_index, current_player)
    else
        turn(board)
    end
    display_board(board)
end

def play(board)
    until over?(board)
    turn(board)
    end

    if draw?(board) == true
        puts "Cat's Game!"
    elsif winner(board) == "X"
        puts "Congratulations X!"
    elsif winner(board) == "O"
        puts "Congratulations O!"
    end
end