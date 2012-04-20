//= require jquery
//= require twitter/bootstrap
//= require libs/CoffeeTouch
//= require libs/jquery.scrollTo-1.4.2-min
//= require libs/jquery.localscroll-1.2.7-min

$(function() {
	// Popover
  var search_button = $('#search_button');
  var tag_button  	 = $('#tag_button');
  search_button.popover({placement: 'left', trigger: 'manual'});
  tag_button   .popover({placement: 'left', trigger: 'manual'});
  

  $('body').onGesture('tap', function(CoffeeTouchEvent) {
  	var id = CoffeeTouchEvent.targets[0].id;
  	if (id === 'tag_button') {
  		search_button.popover('hide');
  		tag_button.popover('toggle');
  	} else if (id === 'search_button') {
  		tag_button.popover('hide');
  		search_button.popover('toggle');
  	} else if ($(CoffeeTouchEvent.targets[0]).closest('.popover').length === 0) {
		  search_button.popover('hide');
			tag_button   .popover('hide');
  	};
  });  
});