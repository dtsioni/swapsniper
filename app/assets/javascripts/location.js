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
  }
  var newOptions = "<option value='anywhere'>Anywhere</option>";
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
    var newOptions = "<option value='anywhere'>Anywhere</option>";
    for(i = 0; i < buildings.length; i++){
      newOptions += "<option value='" + buildings[i] + "'>" + buildings[i].toTitleCase() + "</option>";
    }
    $('#user_destination_attributes_building').html(newOptions);
  });
});
