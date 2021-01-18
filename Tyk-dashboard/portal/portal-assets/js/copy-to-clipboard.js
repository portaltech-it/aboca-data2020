$.fn.copyToClipboard = function(options) {
  return this.each(function(index, elem) {
    var $elem = $(elem),
      valueToCopy,
      $textArea = $('<textarea></textarea>'),
      pluginOptions = Object.assign(
        {},
        options
      );
    var selectCodeToBeCopied = function selectCodeToBeCopied() {
      valueToCopy = $elem.data('valueToCopy');
      $textArea.val(valueToCopy);
      $textArea.insertAfter($elem);
      $textArea.select();
    };

    $elem.tooltip({
      html: true
    });

    var copyTextToClipboard = function copyTextToClipboard() {
      try {
        document.execCommand('copy');
        $elem
          .attr('title', 'Copied!')
          .tooltip('fixTitle');
      } catch (err) {
        $elem.text('FAILED: Could not copy').prop('disabled', true);
      }

      $textArea.remove();

      setTimeout(function() {
        $elem
          .attr('title', 'Copy to Clipboard')
          .tooltip('fixTitle');
      }, 3000);
    };

    var bindEvents = function bindEvents() {
      $elem.on('click', function(e) {
        e.preventDefault();
        selectCodeToBeCopied();
        copyTextToClipboard();
      });
    };

    bindEvents();
  });
};

$('.copyToClipboard').copyToClipboard({});
