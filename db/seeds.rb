# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

prisoners = Prisoner.create([
  {:id => 1, :name => 'bonnie'},
  {:id => 2, :name => 'clyde'}, 
  {:id => 3, :name => 'thelma'},
  {:id => 4, :name => 'louise'}
])

games = Game.create([
  {:id => 1, :name => 'Robbing a Bank', :player1_id => 1, :player2_id =>2},
  {:id => 2, :name => 'Shooting a Man', :player1_id => 3, :player2_id =>4, :player1_confess => true, :player2_confess => true},
  {:id => 3, :name => 'Public Nudity', :player1_id => 1, :player2_id =>2, :player1_confess => false, :player2_confess => true},
  {:id => 4, :name => 'Animal Cruelty', :player1_id => 3, :player2_id =>4, :player1_confess => false, :player2_confess => false}
])


