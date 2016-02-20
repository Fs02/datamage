angular.module('OpenData')
.controller('ItemsCtrl', [
  '$scope',
  '$stateParams',
  '$http',
  'Item',
  'Category',
  function($scope, $stateParams, $http, Item, Category) {
  //the image
  $scope.image;
  $scope.displayHeight = 0;
  $scope.displayWidth = 0;
  $scope.scaledWidth = 0;
  $scope.scaledHeight = 0;
  $scope.scaledTop = 0;
  $scope.scaledLeft = 0;

  $http.get('/api/categories/tree.json').
    success(function(data) {
       $scope.categories = data.categories;
    });

  $scope.uploadImage = function() {
    var fd = new FormData();
    var imgBlob = dataURItoBlob($scope.image);
    fd.append('file', imgBlob);
    $http.post(
      'imageURL',
      fd, {
        transformRequest: angular.identity,
        headers: {
          'Content-Type': undefined
        }
      }
    )
    .success(function(response) {
      console.log('success', response);
    })
    .error(function(response) {
      console.log('error', response);
    });
  }

  $scope.item = new Item();
  $scope.create = function() {
    console.log($scope.item);
    $scope.item.$save(function() {
      //data saved. $scope.entry is sent as the post body.
    });
  }
}]);
