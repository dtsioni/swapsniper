$(document).ready(function(){
  selected_building = $("#user_origin_attributes_campus>option:selected").text().toLowerCase();
  var buildings = "";
  switch(selected_building){
    case "busch":
      buildings = BUILDINGS_BUSCH;
      break;
    case "college avenue":
      buildings = BUILDINGS_COLLEGE_AVENUE;
      break;
    case "cook/douglass":
      buildings = BUILDINGS_COOK_DOUGLASS;
      break;
    case "livingston":
      buildings = BUILDINGS_LIVINGSTON;
  }
  var newOptions = "";
  for(i = 0; i < buildings.length; i++){
    newOptions += "<option value='" + buildings[i] + "'>" + buildings[i].toTitleCase() + "</option>";
  }
  $('#user_origin_attributes_building').html(newOptions);
  $('#user_origin_attributes_campus').change(function(){
    selected_building = $("#user_origin_attributes_campus>option:selected").text().toLowerCase();
    var buildings = "";
    switch(selected_building){
      case "busch":
        buildings = BUILDINGS_BUSCH;
        break;
      case "college avenue":
        buildings = BUILDINGS_COLLEGE_AVENUE;
        break;
      case "cook/douglass":
        buildings = BUILDINGS_COOK_DOUGLASS;
        break;
      case "livingston":
        buildings = BUILDINGS_LIVINGSTON;
    }
    var newOptions = "";
    for(i = 0; i < buildings.length; i++){
      newOptions += "<option value='" + buildings[i] + "'>" + buildings[i].toTitleCase() + "</option>";
    }
    $('#user_origin_attributes_building').html(newOptions);
  });
  //destination
  selected_building = $("#user_destination_attributes_campus>option:selected").text().toLowerCase();
  var buildings = "";
  switch(selected_building){
    case "busch":
      buildings = BUILDINGS_BUSCH;
      break;
    case "college avenue":
      buildings = BUILDINGS_COLLEGE_AVENUE;
      break;
    case "cook/douglass":
      buildings = BUILDINGS_COOK_DOUGLASS;
      break;
    case "livingston":
      buildings = BUILDINGS_LIVINGSTON;
      break;
    case "anywhere":
      $('#user_destination_attributes_building').hide();
  }
  var newOptions = "<option value='anywhere'>Any building</option>";
  for(i = 0; i < buildings.length; i++){
    newOptions += "<option value='" + buildings[i] + "'>" + buildings[i].toTitleCase() + "</option>";
  }
  $('#user_destination_attributes_building').html(newOptions);
  $('#user_destination_attributes_campus').change(function(){
    selected_building = $("#user_destination_attributes_campus>option:selected").text().toLowerCase();
    var buildings = "";
    switch(selected_building){
      case "busch":
        buildings = BUILDINGS_BUSCH;
        $('#user_destination_attributes_building').fadeIn();
        break;
      case "college avenue":
        buildings = BUILDINGS_COLLEGE_AVENUE;
        $('#user_destination_attributes_building').fadeIn();
        break;
      case "cook/douglass":
        buildings = BUILDINGS_COOK_DOUGLASS;
        $('#user_destination_attributes_building').fadeIn();
        break;
      case "livingston":
        buildings = BUILDINGS_LIVINGSTON;
        $('#user_destination_attributes_building').fadeIn();
        break;
      case "anywhere":
        $('#user_destination_attributes_building').fadeOut();
    }
    var newOptions = "<option value='anywhere'>Any building</option>";
    for(i = 0; i < buildings.length; i++){
      newOptions += "<option value='" + buildings[i] + "'>" + buildings[i].toTitleCase() + "</option>";
    }
    $('#user_destination_attributes_building').html(newOptions);
  });
});
