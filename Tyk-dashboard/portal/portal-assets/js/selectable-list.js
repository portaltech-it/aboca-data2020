$.fn.selectableList = function( options ) {
  return this.each(function() {
    var $elem = $( this ),
      $searchForm = $elem.find('.selectable-list-form'),
      $markup = $elem.html(),
      itemsList = [],
      $selectableList = $elem.find('.selectable-list'),
      $selectedItemsList = $elem.find('.selected-items'),
      itemSelector = '.item',
      pluginOptions = Object.assign(
        {},
        {
          multiselect: false
        },
        options
      ),
      selectedItems = pluginOptions.selectedItems.splice(0) || [],
      searchParams = {
      },
      maxSelectedItems = (pluginOptions.multiselect) ? pluginOptions.maxSelectedItems : 1;

    var getApis = function(params) {
      let promise = $.ajax({
        crossDomain: true,
        url: pluginOptions.apisUrl,
        data: params
      });

      promise.then((rsp) => {
        itemsList = JSON.parse(rsp).suggestions;
        _generateList(itemsList, $selectableList);
        _disableNonActiveElements();
      });

      return promise;
    };

    var init = function() {
      getApis(searchParams).then(function(rsp) {
        _generateList(selectedItems, $selectedItemsList);
        _bindEvents();
      });
    };

    var onSearch = function(arrData) {
      arrData.forEach(function(obj) {
        if(obj.value) {
          searchParams[obj.name] = obj.value;
        }
      });

      if(!searchParams.p) {
        delete searchParams.p;
      }

      getApis(searchParams);
    };

    let _disableNonActiveElements = function() {
      let actionMethod = (selectedItems.length === maxSelectedItems) ? 'addClass' : 'removeClass';

      $selectableList.find('li:not(".not-activable")')[actionMethod]('disabled');
    };

    var _generateList = function(list, $elemContainer) {
      let $container = $('<div>');

      list.forEach((item) => {
        $container.append(_generateItem(item));
      });

      $elemContainer.empty().append($container.children());

      if(selectedItems.length === 0) {
        $elem.find('.selected-items-title').hide();
        $elem.find('.selected-items').hide();
      } else {
        $elem.find('.selected-items-title').show();
        $elem.find('.selected-items').show();
      }

      $elem.find('[data-toggle="tooltip"]').tooltip({
        html: true
      });
    };

    var _generateItem = function(data) {
      let oauthEnabled = (data.data.usageLimit >= -1 && data.data.usageLimit !== 0);

      let selectedItemIndex = _getSelectedItemIndex(data.data.policy_id),
        diff = (data.data.usageLimit !== -1) ? (data.data.usageLimit - data.data.nrOfUsage) : -1,
        disabled = (data.data.nrOfUsage >= data.data.usageLimit && [-1, 0].indexOf(data.data.usageLimit) == -1),
        activeClass = (typeof selectedItemIndex === 'number') ? 'active' : '';

      let $listItem = $('<li class="list-group-item item ' + activeClass + (disabled  ? ' disabled not-activable' : '') + '" data-id="' + data.data.policy_id + '">'),
        $detailsContainer = $('<div class="details-container">');
        $addBtn = $('<button type="button" class="btn btn-success add-item-btn"><span class="fa fa-check"></span><br />Select API</button>'),
        $removeBtn = $('<button type="button" class="btn btn-danger remove-item-btn"><span class="fa fa-times"></span><br />Remove API</button>'),
        $itemDetails = $('<span class="item-title">' + data.value + '</span>');

      let $badge = null;

      if (oauthEnabled && diff > 0) {
        $badge = $('<span data-toggle="tooltip" data-placement="top" title="<h5>OAuth client limit per API</h5> The owner of this API has set a limit on the amount of OAuth clients that can use it" class="badge ' + (disabled  ? 'disabled' : '') + '">' + (disabled  ? 'no' : diff) + ' oAuth clients left</span>');
      } else if([-1, 0].indexOf(data.data.usageLimit) > -1) {
        $badge = $('<span class="badge"></span>');
      } else {
        $badge = $('<span data-toggle="tooltip" data-placement="top" title="<h5>OAuth client limit per API</h5> The owner of this API has set a limit on the amount of OAuth clients that can use it" class="badge disabled">OAuth not enabled</span>');
      }

      $detailsContainer.append($addBtn);
      $detailsContainer.append($removeBtn);
      $detailsContainer.append($itemDetails);
      $listItem.append($detailsContainer);
      $listItem.append($badge);

      return $listItem;
    };

    var _isDuplicated = function(item) {
      return selectedItems.filter((selectedItem) => {
        return selectedItem.data === item.data;
      }).length;
    };

    var _getItem = function(itemId) {
      return itemsList.filter((listItem) => {
        return listItem.data.policy_id === itemId;
      })[0];
    };

    var _getSelectedItemIndex = function(itemId) {
      let itemIndex;

      selectedItems.forEach((listItem, index) => {
        if(listItem.data.policy_id === itemId) {
          itemIndex = index;
        };
      });

      return itemIndex;
    };

    var _selectItem = function($item) {
      var itemId = $item.data('id'),
        item = _getItem(itemId);

      if(!pluginOptions.multiselect) {
        $elem.find(itemSelector).removeClass('active');
      }

      $item.addClass('active');

      if(_isDuplicated(item)) {
        return;
      }

      if(!pluginOptions.multiselect) {
        selectedItems = [item];
      } else {
        selectedItems.push(item);
      }

      _generateList(selectedItems, $selectedItemsList);
      _disableNonActiveElements();

      $('#oauth_policy_id').val($item.data('id'));

      // Remove existing elements:
      $('#key_request_fields').empty();

      // Append key request fields:
      for (i in item.data.key_request_fields) {
        var fieldName = item.data.key_request_fields[i];
        $label = $('<label for="' + fieldName + '">' + fieldName + '</label>');
        $f = $('<input class="form-control" type="text" value="" name="' + fieldName + '" id="' + fieldName + '" />');
        $('#key_request_fields').append($label);
        $('#key_request_fields').append($f);
      }
      options.onChange(selectedItems);
    };

    var _unselectItem = function($item) {
      var itemId = $item.data('id'),
        itemIndex = _getSelectedItemIndex(itemId);

      selectedItems.splice(itemIndex, 1);
      $selectableList.find('[data-id="' + itemId + '"]').removeClass('active');

      _generateList(selectedItems, $selectedItemsList);
      _disableNonActiveElements();
      options.onChange(selectedItems);
    };

    var _bindEvents = function _bindEvents() {
      $elem.on('click', '.selectable-list li:not(".disabled") .add-item-btn', function() {
        _selectItem($(this).closest('li'));
      });

      $elem.on('click', 'li .remove-item-btn', function(e) {
        e.stopPropagation();
        _unselectItem($(this).closest('li'));
      });

      $searchForm.on('submit', function(e) {
        e.preventDefault();
        onSearch($(this).serializeArray());
      });
    };

    init();
  });
};

var oauthNs = oauthNs || {};
oauthNs.$chooseApiStepBtn = $('.choose-api-oauth-step-btn');

$('.oauth-clients').selectableList({
  multiselect: false,
  maxSelectedItems: 5,
  uniqueName: 'api-list',
  apisUrl: portalRoot + 'oauth-clients/catalogue',
  onChange: function(selectedItems) {
    if(selectedItems.length > 0) {
      oauthNs.$chooseApiStepBtn.removeClass("disabled");
      oauthNs.$chooseApiStepBtn.removeAttr("disabled");
      return;
    }

    oauthNs.$chooseApiStepBtn.addClass("disabled");
    oauthNs.$chooseApiStepBtn.attr("disabled", true);
  },
  selectedItems: []
});
