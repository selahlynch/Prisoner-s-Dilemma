class Game < ActiveRecord::Base
  has_many :game_prisoners
  has_many :prisoners, :through => :game_prisoners

  validates :name, :length => {:minimum => 1, :maximum => 100}
end


