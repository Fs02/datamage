angular.module('OpenData')
.controller('SidenavCtrl', function ($scope, $timeout, $log, Category) {
  $scope.openLeftMenu = function() {
    $mdSidenav('left').toggle();
  }

  Category.query({level: 0}, function(data) {
    $scope.categories = data.categories;
  });

  $scope.togglecategories = function(category) {
    if (category.child_count) {
      if (Array.isArray(category.categories)) {
        category.expanded = !category.expanded;
      } else {
        $timeout(function() {
          Category.query({parent_id: category.id }, function(data) {
            category.categories = data.categories;
            category.depth = 1;
          });
          category.expanded = true;
        }, 500);
      }
    }
  };
});
