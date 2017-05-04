# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS=[[6,4,2],[0,4,8],[2,5,8],[1,4,7],[0,3,6],[6,7,8],[3,4,5],[0,1,2]]

def won?(board)
 winComb=[]
 WIN_COMBINATIONS.each do |comb|
     if board[comb[0]]!=" "&&board[comb[1]]!=" "&&board[comb[2]]!=" "
         if board[comb[0]]==board[comb[1]]&&board[comb[0]]==board[comb[2]]
             break winComb=comb
         else
             winComb=false
         end
     else
         winComb=false
     end
 end
 winComb
end

def full?(board)
    full=true
    board.each do |pos|
        if pos==" "
            full=false
        end
    end
    full
end

def draw?(board)
    draw=true
    if won?(board)
        draw=false
    elsif !full?(board)
        draw=false
    end
    draw
end

def over?(board)
    over=false
    if draw?(board)
        over=true
    elsif won?(board)
        over=true
    else
    end
    over
end


def winner(board)
    winner=""
    if won?(board)
        return board[won?(board)[0]]
    end
end



board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(input)
    if input >= "1" && input <="9"
        return input.to_i-1
    else
        return -1
    end
end

def move(board,index,value)
    board[index]=value
end

def position_taken?(board,index)
    if board[index]==" " || board[index]==nil||board[index]==""
        return false
    else
        return true
    end
end

def valid_move?(board,index)
    if index <9 && index >=0 && !position_taken?(board,index)
        return true
    else
        return false
    end
end

def turn(board)

    display_board(board)
    puts "Please enter 1-9:"
    input=gets.strip
    index=input_to_index(input)
    if valid_move?(board,index)
        move(board,index,current_player(board))
        display_board(board)
    else
        turn(board)
    end
end

def play(board)
    until over?(board) do
        turn(board)
    end
    if won?(board)
        puts "Congratulations #{winner(board)}!"

    elsif draw?(board)
        puts "Cats Game!"
        
    end
end

def turn_count(board)
    counter=0
    board.each do |position|
        if position != " "
            counter+=1
        end
    end
    return counter
end

def current_player(board)
    if turn_count(board)%2==0
        return "X"
    else
        return "O"
    end
end
