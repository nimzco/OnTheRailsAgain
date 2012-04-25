//= require jquery
//= require twitter/bootstrap
//= require libs/CoffeeTouch
//= require libs/jquery.scrollTo-1.4.2-min
//= require libs/jquery.localscroll-1.2.7-min

$(function() {
	// Popover
  var searchButton = $('#search_button');
  var tagButton  	 = $('#tag_button');
  searchButton.popover({placement: 'left', trigger: 'manual'});
  tagButton   .popover({placement: 'left', trigger: 'manual'});
  var toggle_responsive_button = function (target) {
    var id = target.id;
    if (id === 'tag_button') {
      searchButton.popover('hide');
      tagButton.popover('toggle');
    } else if (id === 'search_button') {
      tagButton.popover('hide');
      searchButton.popover('toggle');
    } else if ($(target).closest('.popover').length === 0) {
      searchButton.popover('hide');
      tagButton   .popover('hide');
    };
  };

  $('body').onGesture('tap', function(CoffeeTouchEvent) {
    var target = CoffeeTouchEvent.targets[0];
    toggle_responsive_button(target);
  });
  $('body').click(function(jQueryEvent) {
    var target = jQueryEvent.target;
    toggle_responsive_button(target);
  });
});