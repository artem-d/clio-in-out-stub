var update_users_statuses;

update_users_statuses = function() {
  return $.get('/users.json', null, function(data) {
    $("#users-container p").each( function( index, element ){
      var name = $("a.name", this).text();
      var status = $.map(data, function(val) {
        return val.full_name == name ? val.status : null;
      });
      $("span.status", this).removeClass("status-in status-out").
        addClass("status-"+status).html(status);
    });
    return setTimeout(update_users_statuses, 3000);
  });
};

update_users_statuses();
