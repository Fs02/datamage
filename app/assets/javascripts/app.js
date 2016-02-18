angular.module('OpenData', ['ngMaterial', 'ui.router', 'templates'])
.controller('AppCtrl', function ($scope, $timeout, $mdSidenav, $log) {
  $scope.openLeftMenu = function() {
    $mdSidenav('left').toggle();
  }

  var ids = 1;

  function getId() {
    return ids++;
  }

  function createItems(count) {
    var i, id, items = [];
    for (i = 0; i < count; i += 1) {
      id = getId();
      items.push({
        id: id,
        title: 'Item #' + id,
        items: id % 4
      });
    }
    return items;
  }

  $scope.items = createItems(6); // 6 штук хвати всем!

  $scope.toggleItems = function(item) {
    if (item.items) {
      if (Array.isArray(item.items)) {
        item.expanded = !item.expanded;
      } else {
        $timeout(function() {
          item.items = createItems(Math.floor(Math.random(4)) + 3);
          item.expanded = true;
        }, 500);
      }
    }
  };
});
