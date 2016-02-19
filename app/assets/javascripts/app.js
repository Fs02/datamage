angular.module('OpenData', ['ngMaterial', 'ngResource', 'ui.router', 'templates'])
.factory("Category", function($resource) {
  return $resource("/api/categories/:id.json", {}, {
    query: { method: "GET", isArray: false }
  });
})
.factory("Item", function($resource) {
  return $resource("/api/items/:id.json", {}, {
    query: { method: "GET", isArray: false }
  });
})
.controller('AppCtrl', function ($scope, $timeout, $log, Category) {
  $scope.openLeftMenu = function() {
    $mdSidenav('left').toggle();
  }

  Category.query(function(data) {
    $scope.categories = data.categories;
  });

  $scope.togglecategories = function(category) {
    if (category.child_count) {
      if (Array.isArray(category.categories)) {
        category.expanded = !category.expanded;
      } else {
        $timeout(function() {
          Category.query({parent_slug: category.slug }, function(data) {
            category.categories = data.categories;
          });
          category.expanded = true;
        }, 500);
      }
    }
  };
})
.controller('GalleryCtrl', function ($scope, $log, Item) {
    Item.query(function(data) {
      $scope.items = data.items;
    });
});
