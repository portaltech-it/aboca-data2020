$('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
  var $target = $(e.target);

  if ($target.parent().hasClass('disabled')) {
    return false;
  }
});

$('.next-step').click(function (e) {
  var $active = $('.content-wrapper .breadcrumb li.active');
  $active.removeClass('active');
  $active.next().removeClass('disabled');
  nextTab($active);
});

$('.prev-step').click(function (e) {
  var $active = $('.content-wrapper .breadcrumb li.active');
  $active.removeClass('active');
  $active.prev().removeClass('active');
  prevTab($active);
});

function nextTab(elem) {
  $(elem).next().find('a[data-toggle="tab"]').click();
}
function prevTab(elem) {
  $(elem).prev().find('a[data-toggle="tab"]').click();
}

$(document).ready(function () {
  let baseURL = window.baseURL || '',
    getOauthID;

  $('.delete-client').on('click', function () {
    getOauthID = $(this).data('client');
    $('.oauth-delete').val(getOauthID);
  });

  $('.revoke-tokens').on('click', function () {
    getOauthID = $(this).data('client');
    $('.revoke-all-tokens').val(getOauthID);
  });

  $('.oauth-delete').click(function (e) {
    var oauthID = $('.oauth-delete').val(),
      targetURL = portalRoot + 'oauth-clients/' + oauthID;

    // TODO: handle errors
    $.ajax({
      url: targetURL,
      headers: {
        'X-CSRF-Token': $('#csrf_token').val()
      },
      type: 'DELETE',
      success: function (result) {
        location.reload();
      },
      error: function () {
        $("#apiAction .modal-body").text("Couldn't delete the OAuth client");
        $('#apiAction').modal('toggle');
      }
    });

    e.preventDefault();
  });

  $('.revoke-all-tokens').click(function(e) {
    const client = $('.revoke-all-tokens').val().split(' ');
    const clientId = client[0].replace('{', '')
    const secret = client[1];
    const targetURL = portalRoot + 'oauth-clients/'+ clientId + '/revoke_all';
    $.ajax({
      url: targetURL,
      headers: {
        'X-CSRF-Token': $('#csrf_token').val(),
        "Content-Type": "application/json",
      },
      xhrFields: { withCredentials:true },
      type: 'POST',
      data: JSON.stringify({ "client_secret": secret }),
      success: function (result) {
        $("#apiAction .modal-body").text(result.Message || 'Tokens revoked successfully');
        $('#revokeTokens').modal('toggle');
        $('#apiAction').modal('toggle');
      },
      error: function (error) {
        $("#apiAction .modal-body").text("Couldn't revoke all tokens");
        $('#revokeTokens').modal('toggle');
        $('#apiAction').modal('toggle');
      }
    });
    e.preventDefault();
  });
});