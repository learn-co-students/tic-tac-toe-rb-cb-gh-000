require_relative './position_taken.rb'

def valid_move?(board, index)
  if index < 0 || index > 8
    false
  elsif position_taken?(board, index)
    false
  else
    true
  end
end
