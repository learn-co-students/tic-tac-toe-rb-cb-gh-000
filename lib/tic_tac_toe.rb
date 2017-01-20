WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [2,4,6],
    [0,4,8],
]

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
    return input.to_i - 1
end

def position_taken?(board, index)
    !(board[index] == " " || board[index] == "" || board[index] == nil)
end

def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
end

def move(board, index, value)
    board[index] = value
end

def turn_count(board)

    counter = 0

    board.each do |position|
        position == "X" || position == "O" ? counter += 1 : nil
    end

    counter
end

def current_player(board)
    turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)

    until valid_move?(board, index)
        puts "Please enter 1-9:"
        input = gets.strip
        index = input_to_index(input)
    end

    move(board, index, current_player(board))
    display_board(board)
end

def won?(board)
    WIN_COMBINATIONS.each do |combination|
        if(combination.all? {|i| board[i] == "X"} || combination.all? {|i| board[i] == "O"})
            return combination
        end
    end

    false
end

def full?(board)
    board.none? {|position| position == " "}
end

def draw?(board)
    a = full?(board)
    b = won?(board)
    a && !b

    #full?(board) && !won?(board)
end

def over?(board)
    draw?(board) || won?(board)
end

def winner(board)
    result = won?(board)

    if result
        board[result[0]]
    else
        nil
    end
end

def play(board)
    until over?(board)
        turn(board)
    end

    if won?(board)
        puts "Congratulations #{winner(board)}!"
    else
        puts "Cats Game!"
    end
end
