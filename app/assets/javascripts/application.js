//= require jquery
//= require twitter/bootstrap
//= require libs/jquery.scrollTo-1.4.2-min
//= require libs/jquery.localscroll-1.2.7-min
$(function() {
	// Popover
  var search_button = $('#search_button');
  var tag_button  	 = $('#tag_button');
  search_button.popover({placement: 'left', trigger: 'manual'});
  tag_button   .popover({placement: 'left', trigger: 'manual'});
  $('body').click(function(jQueryEvent) {
  	var id = jQueryEvent.srcElement.id;
  	if (id === 'tag_button') {
  		search_button.popover('hide');
  		tag_button.popover('toggle');
  	} else if (id === 'search_button') {
  		tag_button.popover('hide');
  		search_button.popover('toggle');
  	} else if ($(jQueryEvent.srcElement).closest('.popover').length === 0) {
		  search_button.popover('hide');
			tag_button   .popover('hide');
  	};
  });
});