
var game_data;


$(document).ready(function(){

  $("#table_games").find("tr").not("tr.header").remove();

  $.getJSON('http://localhost:3000/games/list.json', function(data) {
    game_data = data;
    for(i = 0; i < game_data.length; i++){
      $("#table_games").append("<tr class='game_row' data-id='"+i+"'><td>" + game_data[i].name + "</td></tr>");
    }
  });

  $("#table_games").find("tr.game_row").live("click", display_edit_form);

  $("#table_games").find("button.ajax_submit").live("click", submit_form);

});




function display_edit_form(){

  $("#table_games").find("tr.game_edit_row").remove();

  var id = $(this).data("id");
  
  $(this).after("<tr class='game_edit_row'><td ></td></tr>");
  
  $(this).next().find('td').append("<form class='edit_game'></form>");
  
  var form = $(this).next().find('form');
  
  form.append("<label for='name_input'>Name: </label><input type='text' name='game[name]' id='name_input_"+ id +"' value='"+ game_data[id].name +"'></input><br/>");
  form.append("<select id='game_prisoners_"+ id +"' multiple='multiple' name='game[prisoner_ids][]' size=5></select><br/>");
  form.append("<button class='ajax_submit' type='button' data-game_id='"+game_data[id].id+"'>Submit</button><br/>");
  
  var select = form.find('select');

  //populate select box
    $.getJSON('game_members.json', function(data){
      for(var i = 0; i < data.length; i++){
        //data[i].name
        var select_string = "";
        if (data[i].is_selected==="selected"){
          select_string = "selected = 'selected'";
        }
        
        select.append("<option value='"+data[i].id+"' "+ select_string +">"+data[i].name+"</option>");
      }
    });
  
  var x = "dum";
}


function submit_form(){
  //$(this) is the button that I clicked

  //serialize form input
  var form_inputs = $(this).closest("form").serialize();
  
  var this_row = $(this).closest("tr.game_edit_row");
  var prev_row = $(this).closest("tr.game_edit_row").prev();
  
  //ajax post to rails app
  $.ajax({
    type: 'POST',
    url: "http://localhost:3000/games/update/"+$(this).data("game_id"),
    data: form_inputs,
    dataType: "html",
    success: function(){
      prev_row.find("td:nth-child(1)").html(this_row.find("input:text").val());          
      this_row.remove(); 
    },
    error: function(jqXHR, textStatus, errorThrown){alert("failure!" + textStatus + errorThrown);}
  });


}



 
var x = function(){
  var data = [3,4,6];
  //put another function here
  
}







