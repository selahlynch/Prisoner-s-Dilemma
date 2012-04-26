// @@@@ !!! we typically prefer camel-case when writing javascript

// this global probably isn't needed
var game_data;

// scope everything
// short syntax is preferred IIRC
$(function() {
  var tblGames = $("#table_games");

  // do this stuff right away
  $("#table_games tr").not(".header").remove();

  // no error handler set
  $.getJSON('http://localhost:3000/games/list.json', function(data) {
    game_data = data;
    for(i = 0; i < game_data.length; i++){
      tblGames.append("<tr class='game_row' data-id='"+i+"'><td>" + game_data[i].name + "</td></tr>");
    }
  });

  tblGames.find("tr.game_row").live("click", display_edit_form);
  tblGames.find("button.ajax_submit").live("click", submit_form);
  
  // or use delegates
  tblGame.on('click', function(evt){
    var tgt = $(evt.target);
    if(tgt.is('tr.game_row')) {
      display_edit_form.apply(this);
    }
    else if(tgt.is('button.ajax_submit')) {
      submit_form.apply(this);
    }
    // you might also want to evt.preventDefault() or evt.stopPropagation()
  });

  // add documentation
  function display_edit_form(){
  
    tblGame.find("tr.game_edit_row").remove();
  
    var self = $(this),
      id = self.data("id"),
      td = self.after("<tr class='game_edit_row'><td ></td></tr>").children('td'),
      form = $("<form class='edit_game'></form>").appendTo(td);
    
    // you should look into using a templating engine such as underscore, moustache or handlebars
    form.append("<label for='name_input'>Name: </label><input type='text' name='game[name]' id='name_input_"+ id +"' value='"+ game_data[id].name +"'></input><br/>")
      .append("<select id='game_prisoners_"+ id +"' multiple='multiple' name='game[prisoner_ids][]' size=5></select><br/>")
      .append("<button class='ajax_submit' type='button' data-game_id='"+game_data[id].id+"'>Submit</button><br/>");
    
    var select = form.find('select#game_prisoners'+id);
  
    //populate select box
    // no error handling
    $.getJSON('game_members.json', function(data){
      for(var i = 0; i < data.length; i++){
        var option = $('<option></option>')
          .innerHTML(data[i].name)
          .attr('value', data[i].id)
          .appendTo(select);
        
        if(data[i].is_selected==="selected") {
          option.attr('selected','selected');
        }
      }
    });
  }
  
  
  function submit_form(){
    //$(this) is the button that I clicked
  
    var self = $(this);
    //serialize form input
    var form_inputs = self.closest("form").serialize();
    
    var this_row = self.closest("tr.game_edit_row");
    var prev_row = this_row.prev();
    
    //ajax post to rails app
    $.ajax({
      type: 'POST',
      url: "http://localhost:3000/games/update/" + self.data("game_id"),
      data: form_inputs,
      dataType: "html",
      success: function(){
        prev_row.find("td:first-child").html(this_row.find("input:text").val());          
        this_row.remove(); 
      },
      // it's good to have an error handler!
      error: function(jqXHR, textStatus, errorThrown){alert("failure!" + textStatus + errorThrown);}
    });
  
  
  }
  
  
  
   
  var x = function(){
    var data = [3,4,6];
    //put another function here
    
  }
});  
  
  
  
  
  
  
