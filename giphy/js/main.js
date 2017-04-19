$(function(){
  var giphyBaseUrl = 'http://api.giphy.com/';
  var publicKey = 'dc6zaTOxFJmzC';

	var imageSearchUrl = giphyBaseUrl + 'v1/gifs/search';
  var url = imageSearchUrl + '?q=funny+cat&limit=5&api_key=' + publicKey;
  var renderhtml = '<ul class="results-list">';

	requestJSON(url, function(json) {

		if (json.message == "Not Found") {
			$('.results').html("<p>Something went wrong. Try another search!</p>");
		} else {
			var results = json;
			outputResult(results);
		}
	});

	function requestJSON(url, callback) {
		$.ajax({
			url: url,
			complete: function(xhr) {
				callback.call(null, xhr.responseJSON);
			}
		});
	}

	function outputResult(results) {
    var imageResults = results.data;

		if (imageResults.length > 0) {

			$.each(imageResults, function(index) {
        var imageResult = imageResults[index];
        var gifUrl = imageResult.images.original.url;

				renderhtml = renderhtml + '<li><img class="avatar" src="'+gifUrl+'"></li>';
			});

			renderhtml + '</ul>';
		} else {
			renderhtml = '<p>There are no results.</p>';
		}

		renderhtml = renderhtml;
		$('.results').html(renderhtml);
	}
});
