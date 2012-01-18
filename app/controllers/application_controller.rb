class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def choose_prisoner
    @prisoners = Prisoner.all
  end
  
  
  
  def choose_game
    prisoner_id = params[:prisoner_id]
    @prisoner = Prisoner.find(prisoner_id)
    @games = @prisoner.games  
  end
  
  
  
  def play_game
    prisoner_id = params[:prisoner_id]
    game_id = params[:game_id]
    @prisoner = Prisoner.find(prisoner_id)
    @game = Game.find(game_id)

    ##assuming two prisoners already in this game ##is this safe??
    @other_prisoner = nil
    @game.prisoners.each do |thispris| 
#    puts "TESTING - thispris.id=" + thispris.id.class.to_s + ' prisoner_id=' + prisoner_id.class.to_s + " - DONE TESTING"
      if thispris.id.to_i != prisoner_id.to_i  ##those to_i's are important
        @other_prisoner = thispris
      end
    end
    
    @you_went = ! @prisoner.game_prisoners.find_by_game_id(game_id).confess.nil?
    @they_went = ! @other_prisoner.game_prisoners.find_by_game_id(game_id).confess.nil?

    if(@you_went && @they_went)
      you_squealed = @prisoner.game_prisoners.find_by_game_id(game_id).confess
      they_squealed = @other_prisoner.game_prisoners.find_by_game_id(game_id).confess
      sentance(you_squealed, they_squealed)
    end

  end



  def plead_guilty
    prisoner_id = params[:prisoner_id]
    game_id = params[:game_id]

    gp = GamePrisoner.where(:prisoner_id => prisoner_id, :game_id => game_id).first
    gp.confess = TRUE
    gp.save!

    redirect_to(:action => 'play_game', :message => 'plead_guilty')
  end
 
 
 
  def plead_innocent
    prisoner_id = params[:prisoner_id]
    game_id = params[:game_id]

    gp = GamePrisoner.where(:prisoner_id => prisoner_id, :game_id => game_id).first
    gp.confess = FALSE
    gp.save!
   
   redirect_to(:action => 'play_game', :message => 'plead_innocent')
  end 
  
  
  def sentance(you_squeal, they_squeal)
    if you_squeal && they_squeal
      @your_sentance = 3
      @their_sentance = 3
    elsif !you_squeal && !they_squeal
      @your_sentance = 1
      @their_sentance = 1
    elsif you_squeal && !they_squeal
      @your_sentance = 0
      @their_sentance = 12
    elsif !you_squeal && they_squeal
      @your_sentance = 12
      @their_sentance = 0
    end  
  end
  
  
end
