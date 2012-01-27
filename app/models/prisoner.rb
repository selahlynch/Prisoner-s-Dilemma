class Prisoner < ActiveRecord::Base
  has_many :game_prisoners
  has_many :games, :through => :game_prisoners
  
  validates :name, :length => {:minimum => 1, :maximum => 100}
  
  def is_in_game(game_id)
    games.collect{|g| g.id}.include? game_id
  end

end
