(function(){
insert_units = function(response, scroll_element){
    scroll_element.insertAdjacentHTML('beforeend', response);
    raplace_code_signs();
    $(".icon").css('background-color', function(){
        var color = generate_color($(this).html())
        return color
      });
  }
})();