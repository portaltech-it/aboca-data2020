$.fn.dynamicInputs = function( options ) {
  return this.each(function() {
    var $elem = $( this ),
      $btn = $elem.find('.add-url-btn'),
      pluginOptions = Object.assign(
        {},
        options
      ),
      $nrInputsError = $('<div class="alert alert-warning">At least one redirect URL is required</div>');
      error = false;
      values = pluginOptions.values.slice(0);

    var _generateInput = function(name, value, fromInit) {
      var $div = $('<div class="input-group">'),
        $input = $('<input name="' + name + '" value="' + value + '" class="form-control" type="text" placeholder="http://localhost"/>'),
        $inputGroup = $('<span class="input-group-btn"></span>'),
        $button = $('<button type="button" data-name="' + name + '" class="btn btn-danger remove-field"><span class="fa fa-minus"></span></button>"');

      if($nrInputsError) {
        $nrInputsError.remove();
        error = false;
      }

      if(!fromInit) {
        values.push(value);
      }

      $inputGroup.append($button);
      $div.append($input);
      $div.append($inputGroup);
      $btn.before($div);
      options.onChange(values);
    };

    var _removeInput = function($inputWrapper, index) {
      if(values.length === 1) {
        if(error === false) {
          $btn.before($nrInputsError);
          error = true;
        }
        return;
      }

      values.splice(index, 1);
      $inputWrapper.remove();
      options.onChange(values);
    };

    var _bindEvents = function() {
      $btn.on('click', function() {
        _generateInput(pluginOptions.name + '[]', '');
      });

      $elem.on('click', '.remove-field', function(e) {
        let $inputGroup = $(this).closest('.input-group'),
          index = $inputGroup.index();

        _removeInput($inputGroup, index);
      });

      $elem.on('keyup', 'input[type="text"]', function(e) {
        let $inputGroup = $(this).closest('.input-group'),
          index = $elem.children('.input-group').index($inputGroup);
        values[index] = e.target.value;
        options.onChange(values);
      });
    };

    var init = function() {
      if(Object.keys(values).length === 0) {
        _generateInput(pluginOptions.name + '[]', '');
      } else {
        values.forEach((val) => {
          _generateInput(pluginOptions.name + '[]', val, true);
        });
      }

      _bindEvents();
    };

    init();
  });
};


var oauthNs = oauthNs || {};
oauthNs.$addAppDetailsStepBtn = $('.app-details-step-btn');

$('.dynamic-inputs').dynamicInputs({
  name: 'redirectURLs',
  label: 'Redirect URL(s)',
  values: [],
  onChange: function(values) {
    let hasValues = values.filter((value) => {
      return value !== ''
    }).length > 0;

    if(hasValues) {
      oauthNs.$addAppDetailsStepBtn.removeClass("disabled");
      oauthNs.$addAppDetailsStepBtn.removeAttr("disabled");
      return;
    }

    oauthNs.$addAppDetailsStepBtn.addClass("disabled");
    oauthNs.$addAppDetailsStepBtn.attr("disabled", true);
  }
});
