class Game < ActiveRecord::Base
  has_many :game_prisoners
  has_many :prisoners, :through => :game_prisoners
  
  accepts_nested_attributes_for :game_prisoners, :prisoners  #, :reject_if => :new_record?

  validates :name, :length => {:minimum => 1, :maximum => 100}
  ###why doesnt this work??? it should
  ###  @names_list = "xxxxx"

  def names_list
    prisoners.collect{|p| p.name}.join(', ')
  end
  

end


