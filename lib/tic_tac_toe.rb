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


def current_player( board )
    number = turn_count(board)
    if number % 2 == 0
        return "X"
    else
        return "O"
    end
    # (number%2 == 0) ? return "X" : return "O"
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    turn_count(board)
    move(board, index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end


def turn_count( board )
    counter = 0
    board.each do |position|
        if(position == "X" || position == "O")
            counter += 1
        end
    end
        return counter
end


def current_player( board )
    number = turn_count(board)
    if number % 2 == 0
        return "X"
    else
        return "O"
    end
    # (number%2 == 0) ? return "X" : return "O"
end


def won?( board )
    WIN_COMBINATIONS.each do |combination|
        # puts "#{combination}\n"
        if board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X"
            return combination
        elsif board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"
            return combination
        end
    end
    return false
end


def full?( board )
    board.each do |element|
        if element.nil? || element == " "
            return false
        end
    end
    return true
end


def draw?( board )
    if full?(board)
        # puts won?(board)
        won = if won?(board)!=false
            true
        end

        if won
            return false
        else
            return true
        end
    else
        if won?(board)
            return false
        else
            return false
        end
    end
end


def over?( board )
    if won?(board) || draw?(board) || full?(board)
        return true
    else
        return false
    end
end


def winner( board )
    x_elements = board.select do |element|
        element == "X"
    end
    o_elements = board.select do |element|
        element == "O"
    end
    if won?(x_elements)
        return "X"
    elsif  won?(o_elements)
        return "O"
    end
    return nil
end


def play( board )
    until over?(board) == true
        turn(board)
    end

    if won?(board)
        puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
        puts "Cats Game!"
    end
end
