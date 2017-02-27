def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
def play(board)
    while !over?(board)
        turn(board)
        if draw?(board)
            break
        end
    end
    if draw?(board)
        puts("Cats Game!")
    end
    if won?(board)
        puts("Congratulations #{winner(board)}!")
    end
end

WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6],
]
def won?(board)
    WIN_COMBINATIONS.each do |combination|
        marksOK = true #same & is one of "O", "X"
        if  board[combination[0]] != board[combination[1]] ||
            board[combination[1]] != board[combination[2]]
            marksOK = false
        end
        next if marksOK == false

        combination.each do |index|
            if board[index] != "X" && board[index] != "O"
                marksOK = false
                break
            end
        end
        next if marksOK == false

        return combination
    end
    return false
end

def full?(board)
    board.each do |mark|
        if mark != "X" && mark != "O"
            return false
        end
    end
    return true
end

def draw?(board)
    isWon = won?(board)
    isFull = full?(board)
    if !isWon && isFull
        true
    else
        false
    end
end

def over?(board)
    if won?(board) || full?(board)
        true
    else
        false
    end
end

def winner(board)
    combination_won = won?(board)
    if combination_won != false
        board[combination_won[0]]
    else
        nil
    end
end
def turn_count(board)
    count = 0
    board.each do |mark|
        if mark == "O" || mark == "X"
            count += 1
        end
    end
    count
end

def current_player(board)
    countX = 0
    countO = 0
    board.each do |mark|
        if mark == "O"
            countO += 1
        elsif mark =="X"
            countX += 1
        end
    end
    if countX <= countO
        "X"
    else
        "O"
    end
end
