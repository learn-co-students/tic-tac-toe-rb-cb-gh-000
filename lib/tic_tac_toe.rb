
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
    pipe = "|"
    row1 = " #{board[0]} " + pipe + " #{board[1]} " + pipe + " #{board[2]} "
    row2 = " #{board[3]} " + pipe + " #{board[4]} " + pipe + " #{board[5]} "
    row3 = " #{board[6]} " + pipe + " #{board[7]} " + pipe + " #{board[8]} "
    separator = "-----------"

    puts  row1 + "\n" + separator + "\n" + row2 + "\n" + separator + "\n" + row3
end

def input_to_index(input)
    number = input.to_i
    number = number - 1
end

def move(board, position, char)
    board[position] = char
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
    # index = index - 1
    if index.between?(0, 8) == true && position_taken?(board, index) == false
        return true
    else
        return false
    end
end

def turn(board)
    puts "Please enter 1-9:"
    input = input_to_index(gets.strip)
    if valid_move?(board, input)
        move(board, input, current_player(board))
        display_board(board)

    else
        turn(board)
    end
end

def turn_count(board)
    turns = 0;
    board.each do |space|
        if space == "X" || space == "O"
            turns += 1
        end
    end
    return turns
end

def current_player(board)
    turn = turn_count(board)
    if turn.even?
        return "X"
    else
        return "O"
    end
end

def won?(board)
    counter = 0;
    WIN_COMBINATIONS.each do |trio|

        if trio.all? { |spot| position_taken?(board, spot) == true}  && (trio.all? {|spot| board[spot] == "X"} || trio.all? {|spot| board[spot] == "O"})
            return trio
        end

    end

    return false
end

def full?(board)
    board.all? do |spot|
        spot == "X" || spot == "O"
    end
end

# def draw?(board)
#     if full?(board) == true && won?(board) == false
#         return true
#     else
#         return false
#     end
# end

def draw?(board)
    won = won?(board);
    full = full?(board);

    if full == true && won == false
        return true
    else
        return false
    end
end

def over?(board)
    if won?(board) != false || full?(board) == true || draw?(board) == true
        return true
    else
        return false
    end
end

def winner(board)
    if won?(board) != false
        return board[won?(board)[0]]
    else
        return nil
    end
end


def play(board)
    turn(board)
    if over?(board)
        if draw?(board)
            puts "Cats Game!"
        elsif won?(board)
            puts "Congratulations #{winner(board)}!"
        end
    else
        play(board)
    end
end
