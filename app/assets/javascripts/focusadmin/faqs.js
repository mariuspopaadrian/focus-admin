//= require jquery.ui.widget
//= require jquery.iframe-transport
//= require jquery.fileupload
//= require cloudinary

$(document).on("ready page:load", function() {

	$('.cloudinary-fileupload').bind('fileuploadprogress', function(e, data) {
	  $('.progress-bar').css('width', Math.round((data.loaded * 100.0) / data.total) + '%');
	});

	$('.cloudinary-fileupload').bind('cloudinarydone', function(e, data) {
	  $('.preview').html(
	    $.cloudinary.image(data.result.public_id,
	      { format: data.result.format, version: data.result.version,
	        crop: 'fill', width: 150, height: 100 })
	  );
	  $('.image_public_id').val(data.result.public_id);
	  return true;
	});

});

jQuery(function() {
  var cells, table_width;
  if ($('#sortable_faq').length > 0) {
    return $('#sortable_faq').sortable({
      axis: 'y',
      items: '.item',
      cursor: 'move',
      sort: function(e, ui) {
        return ui.item.addClass('active-item-shadow');
      },
      stop: function(e, ui) {
        ui.item.removeClass('active-item-shadow');
        return ui.item.children('td').effect('highlight', {}, 1000);
      },
      update: function(e, ui) {
        var item_id, position;
        item_id = ui.item.data('item-id');
        console.log(item_id);
        position = ui.item.index();
        return $.ajax({
          type: 'POST',
          url: '/admin/faqs/update_row_order',
          dataType: 'json',
          data: {
            faq: {
              faq_id: item_id,
              row_order_position: position
            }
          }
        });
      }
    });
  }
});

