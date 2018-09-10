# Checks if the position is taken.
def position_taken?(board, index)
  return !(board[index].nil? || board[index] == " ")
end

# Displays the current board.
def display_board(board)
    puts(" #{board[0]} | #{board[1]} | #{board[2]} ")
    puts("-----------")
    puts(" #{board[3]} | #{board[4]} | #{board[5]} ")
    puts("-----------")
    puts(" #{board[6]} | #{board[7]} | #{board[8]} ")
end

# Parses the input to index.
def input_to_index(input)
    return input.to_i - 1
end

# Makes the move.
def move(board, index, char)
    board[index] = char
end

# Checks if the move is valid.
def valid_move?(board, index)
    return !(index < 0 || index > 8 || position_taken?(board, index))
end

# Asks the player to make the turn.
def turn(board)
    puts("Please enter 1-9:")
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
        move(board, index, current_player(board))
        display_board(board)
    else
        turn(board)
    end
end

# Counts the turns played.
def turn_count(board)
    count = 0
    for element in board do
        if element == "X" || element == "O"
            count += 1
        end
    end
    return count
end

# Determines the current player.
def current_player(board)
    return turn_count(board).even? ? "X" : "O"
end

# Constants of all win combinations
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

# Checks if won.
def won?(board)
    WIN_COMBINATIONS.each do |win_combination|
        win_index_1 = win_combination[0]
        win_index_2 = win_combination[1]
        win_index_3 = win_combination[2]

        position_1 = board[win_index_1]
        position_2 = board[win_index_2]
        position_3 = board[win_index_3]

        if position_1 == "X" && position_2 == "X" &&
            position_3 == "X"
            return win_combination
        elsif position_1 == "O" && position_2 == "O" &&
            position_3 == "O"
            return win_combination
        end
    end
    return false
end

# Checks if the board is full.
def full?(board)
    return board.all? {|item| item == "X" || item == "O"}
end

# Checks if the game is draw.
def draw?(board)
    return !won?(board) && full?(board)
end

# Checks if the game is over.
def over?(board)
    return full?(board) || won?(board) || draw?(board)
end

# Finds the winner of the game.
def winner(board)
    if !won?(board)
        return nil
    end
    return board[won?(board)[0]]
end

# Plays the game.
def play(board)
    until over?(board) do
        turn(board)
    end
    if won?(board)
        puts("Congratulations #{winner(board)}!")
    elsif draw?(board)
        puts("Cats Game!")
    end
end

# puts("Welcome to Tic Tac Toe!")
# board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
# display_board(board)
# play(board)
