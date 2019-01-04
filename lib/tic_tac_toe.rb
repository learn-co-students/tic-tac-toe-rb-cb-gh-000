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
    if board[index] == " " || board[index] == ""
        false
    else
        true
    end
end

def valid_move?(board, index)
    if index.between?(0, 8) && position_taken?(board, index) == false
        true
    elsif index.between?(0, 8) && position_taken?(board, index) == true
        false
    else
        false
    end
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
    stripped_board = board.select{|i| i != " "}
    stripped_board.length
end

def current_player(board)
    if turn_count(board).even?
        return "X"
    elsif turn_count(board).odd?
        return "O"
    end
end

def won?(board)
    won = false
    winning_combination = []
    WIN_COMBINATIONS.each do |condi|
        winning_combi = []
        condi.each{|i| winning_combi << board[i]}

        if winning_combi.all?{|i| i == "X"}
            won = true
            winning_combination = winning_combi
        elsif winning_combi.all?{|i| i == "O"}
            won = true
            winning_combination = winning_combi

        end
    end
    if won == false
        return false
    else
        return winning_combination
    end
end

def full?(board)
    if board.all?{|i| i != " "}
        true
    elsif board.any?{|i| i == " "}
        false
    end
end

def draw?(board)
    won = won?(board)
    full = full?(board)
    stripped_board = board.select{|i| i != " "}
    if won
        false
    elsif stripped_board.length < 9
        false
    elsif won == false && full
        true
    end
end

# def over?(board)
#     won = won?(board)
#     draw = draw?(board)
#     if won?(board) == false && full?(board) == false
#         return false
#     elsif won?(board)
#         return true
#     elsif draw?(board)
#         return true
#     end
# end

def over?(board)
    won?(board) || draw?(board)
end

def winner(board)
    won = won?(board)
    if won
       if won[1] == "X"
           return "X"
       elsif won[1] == "O"
           return "O"
       end
    else
        nil
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
