$(document).on("ready page:load", function() {

  $('#acceptModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget) // Button that triggered the modal
    var article_id = button.data('id') // Extract info from data-* attributes
    var title = button.data('title')
    // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
    // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
    var modal = $(this)
    modal.find('.modal-title').text('"'+title+'"')
    $('#acceptForm').attr('action', '/admin/articles/'+article_id);
  })

	$('#rejectModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var article_id = button.data('id') // Extract info from data-* attributes
	  var title = button.data('title')
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('"'+title+'"')
	  $('#rejectForm').attr('action', '/admin/articles/'+article_id);
	})

  // social media post
  $('input[name="facebook[post]"]').change(function() {
    $('#facebook_post_message').attr("disabled", false);
  });
  $('input[name="twitter[post]"]').change(function() {
    $('#twitter_post_message').attr("disabled", false);
  });

	autosize($('textarea'));

});
