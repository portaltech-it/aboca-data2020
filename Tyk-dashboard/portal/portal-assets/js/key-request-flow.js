$.fn.keyRequestFlow = function( options ) {
  return this.each(function() {
    var $elem = $( this );
    var hasFixedApi = $elem.data('fixedApi');
    var $selectableListComponent = $elem.find('.selectable-list-component');
    var $selectableList = $elem.find('.selectable-list');
    var $selectedItems = $elem.find('.selected-items');
    var $listItem = $selectableListComponent.find('.clickable-item');
    var $nextStepBtn = $elem.find('.next-auth-step');
    var $prevStepBtn = $elem.find('.prev-auth-step');
    var $reqKeyBtn = $elem.find('.req-key-btn-first-step');
    var $authApisTab = $elem.find('.cogs');
    var $authApisList = $elem.find('.auth-apis');
    var $reqKeyForm = $elem.find('.request-key-form');
    var $reqKeyFormTab = $elem.find('.info');
    var $clickableItem = $elem.find('.clickable-item');
    var $noSelectedItemsMsg = $elem.find('.no-selected-api-msg');
    var $noAvailableItemsMsg = $elem.find('.no-available-apis-msg');
    var $noItemsMessage = $elem.find('.no-items-error');
    var $useCertificateForm = $elem.find('.use-certificate-form');
    var $jwtForm = $elem.find('.jwt-form');

    var showSameAuthTypeItems = function($item) {
      var authType = $item.data('authType');
      $selectableList.find('.item').hide();
      $selectableList.find('[data-auth-type=' + authType + ']').show();
    };

    var toggleItem = function($button) {
      var $inputEl = $button.siblings('input');
      var $listItem = $button.closest('.item');

      $inputEl.prop('checked', !$inputEl.is(':checked'));
      $listItem.toggleClass('active');
    };

    var showAllItems = function () {
      $selectableList.find('.item').show();
    }

    var setItemSelected = function ($button) {
      var $listItem = $button.closest('.item');
      $listItem = $listItem.detach();

      $selectedItems.prepend($listItem);
      showSameAuthTypeItems($listItem);

      if($selectedItems.find('.item:visible').length) {
        $noSelectedItemsMsg.hide();
        $noItemsMessage.hide();
      }

      if($selectableList.find('.item:visible').length === 0) {
        $noAvailableItemsMsg.show();
      }

      setVisibleButton();

    };

    var removeItemSelected = function ($button) {
      var $listItem = $button.closest('.item');
      $listItem = $listItem.detach();

      $selectableList.prepend($listItem);

      if(!$selectedItems.find('.item').length) {
        showAllItems();
      }

      if($selectedItems.find('.item:visible').length === 0) {
        $noSelectedItemsMsg.show();
      }

      if($selectableList.find('.item:visible').length) {
        $noAvailableItemsMsg.hide();
      }

      setVisibleButton();
    };

    var bindEvents = function () {
      $selectableList.on('click', '.item button', function(e) {
        e.preventDefault();
        toggleItem($(this));
        setItemSelected($(this));
      });

      $selectedItems.on('click', '.item button', function(e) {
        e.preventDefault();
        toggleItem($(this));
        removeItemSelected($(this));
      });

      $nextStepBtn.on('click', function(e) {
        e.preventDefault();

        if(!$selectedItems.find('.item').length) {
          $noItemsMessage.show();
          return;
        }
        $authApisTab.removeClass('active').addClass('disabled');
        $authApisList.hide();
        $reqKeyForm.show();
        $reqKeyFormTab.removeClass('disabled').addClass('active');
      });

      $prevStepBtn.on('click', function(e) {
        e.preventDefault();
        $authApisTab.removeClass('disabled').addClass('active');
        $authApisList.show();
        $reqKeyForm.hide();
        $reqKeyFormTab.removeClass('active').addClass('disabled');
      });

      $clickableItem.on('click')
    };

    var shouldShowSecondStep = function () {
      var jwtItemsLength = $selectedItems.find('[data-auth-type="jwt"]').length;
      var useCertificateItemsLength = $selectedItems.find('[data-use-certificate="true"]').length;
      var keyRequestFieldsLength = $elem.data('keyReqFieldsLength');

      if(useCertificateItemsLength) {
        $useCertificateForm.show();
      } else {
        $useCertificateForm.hide();
      }

      if(jwtItemsLength) {
        $jwtForm.show();
      } else {
        $jwtForm.hide();
      }

      return jwtItemsLength || useCertificateItemsLength || keyRequestFieldsLength;
    };

    var setVisibleButton = function () {
      if(shouldShowSecondStep()) {
        $nextStepBtn.show();
        $reqKeyBtn.hide();
      } else {
        $nextStepBtn.hide();
        $reqKeyBtn.show();
      }

      if($selectedItems.find('.item:visible').length === 0) {
        $nextStepBtn.hide();
        $reqKeyBtn.hide();
      }
    };

    var init = function () {
      bindEvents();
      setVisibleButton();
    };

    init();
  });
};

$('.key-request-flow-wrapper').keyRequestFlow();
