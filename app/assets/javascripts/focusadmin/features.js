jQuery(function() {
  var cells, table_width;
  if ($('#sortable_feature').length > 0) {
    return $('#sortable_feature').sortable({
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
          url: '/admin/features/update_row_order',
          dataType: 'json',
          data: {
            feature: {
              feature_id: item_id,
              row_order_position: position
            }
          }
        });
      }
    });
  }
});

