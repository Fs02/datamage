angular.module('OpenData')
.controller('ExploresCtrl',  [
'$scope',
'$stateParams',
'Item',
function($scope, $stateParams, Item) {
  Item.query({category_id: $stateParams.category_id }, function(data) {
    $scope.items = data.items;
  });
}]);
