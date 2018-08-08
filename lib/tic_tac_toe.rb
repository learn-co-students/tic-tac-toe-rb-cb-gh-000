# Helper Method
def position_taken?(board, index)
  !(board[index] == " ")
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
    [2, 4, 6]
]

def play(board)
    until over?(board)
        turn(board)
    end

    if won?(board)
        puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
        puts "Cat's Game!"
    end
end

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, index)
    index.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
    puts "Please a number in the range 1-9:"
    index = input_to_index(gets.strip)
    while !valid_move?(board, index)
        index = input_to_index(gets.strip)
    end
    move(board, index, current_player(board))
    display_board(board)
end

def input_to_index(input)
    input.to_i - 1
end

def turn_count(board)
    count = 0
    board.size.times { |i| if position_taken?(board, i) then count += 1 end }
    count
end

def current_player(board)
    turn_count(board).even? ? "X" : "O"
end

def move(board, positon, token)
    board[positon] = token
end

def won?(board)
    WIN_COMBINATIONS.each do |comb|
        if board[comb[0]] == board[comb[1]] && board[comb[1]] == board[comb[2]] && (board[comb[0]] == "X" || board[comb[0]] == "O")
            return comb
        end
    end
    nil
end

def full?(board)
    board.size.times {|index| if !position_taken?(board, index) then return false end}
    true
end

def draw?(board)
    full?(board) && !won?(board)
end

def over?(board)
    full?(board) || won?(board) || draw?(board)
end

def winner(board)
    game_result = won?(board)
    if game_result.nil?
        nil
    elsif board[game_result[0]] == "X"
        "X"
    else
        "O"
    end
end
