angular.module('OpenData', ['ngMaterial', 'ngResource', 'ui.router', 'templates'])
.factory("Category", function($resource) {
  return $resource("/api/categories/:id.json", {}, {
    query: { method: "GET", isArray: false }
  });
})
.controller('AppCtrl', function ($scope, $timeout, $mdSidenav, $log, Category) {
  $scope.openLeftMenu = function() {
    $mdSidenav('left').toggle();
  }

  Category.query(function(data) {
    $scope.items = data.categories;
  });

  $scope.toggleItems = function(item) {
    if (item.child_count) {
      if (Array.isArray(item.items)) {
        item.expanded = !item.expanded;
      } else {
        $timeout(function() {
          Category.query({parent_slug: item.slug }, function(data) {
            item.items = data.categories;
          });
          item.expanded = true;
        }, 500);
      }
    }
  };
});
