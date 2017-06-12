# who is the current player?

require_relative './turn_count.rb'

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end
