$('#notice').hide();
$('#cart').html '<%= j render(@cart) %>'
$('#current_item').css({ 'background-color': "#f0f0f0" }).animate({ 'background-color' : "#828282", lineHeight:"3em"}, 1000); 
