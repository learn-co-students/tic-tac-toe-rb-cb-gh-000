# Helper Method
WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [2, 4, 6],
        [0, 4, 8]
]

def display_board(board)
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
        puts "-----------"
end

def input_to_index(user_input)
        return user_input.to_i - 1
end

def move(board, index, player)
        board[index] = player
end

def position_taken?(board, index)
        !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
        return !position_taken?(board, index) && index.between?(0, 8)
end

def turn(board)
        index = nil
        while index == nil
                puts "Please enter a number from 1-9:"
                input = input_to_index(gets.strip)
                if valid_move?(board, input)
                        index = input
                end
        end
        current_player = current_player(board)
        move(board, index, current_player)
end

def turn_count(board)
        counter = 0
        board.each do |position|
                if position != " "
                        counter += 1
                end
        end
        return counter
end

def current_player(board)
        turn_count(board).odd? ? "O" : "X"
end

def won?(board)
        WIN_COMBINATIONS.detect do |win_combination|
                board[win_combination[0]] == board[win_combination[1]] &&
                board[win_combination[1]] == board[win_combination[2]] &&
                position_taken?(board, win_combination.first)
        end
end

def full?(board)
        return board.all? {|index| index != " "}
end

def draw?(board)
        return !won?(board) && full?(board)
end

def over?(board)
        return won?(board) || full?(board)
end

def winner(board)
        if win_comb = won?(board)
                return board[win_comb[0]]
        end
end

def play(board)
        until over?(board)
                turn(board)
                display_board(board)
        end
        if won?(board)
                puts "Congratulations! Player #{winner(board)} won!"
        elsif draw?(board)
                puts "It's a draw!"
        else
                "The game is over."
        end
end
