class Prisoner < ActiveRecord::Base
  has_many :game_prisoners
  has_many :games, :through => :game_prisoners
  
  validates :name, :length => {:minimum => 1, :maximum => 100}
end
