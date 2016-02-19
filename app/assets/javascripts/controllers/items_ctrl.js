angular.module('OpenData')
.controller('ItemsCtrl', [
  '$scope',
  '$stateParams',
  'Item',
  function($scope, $stateParams, Item) {
    //the image
    $scope.image;
    $scope.displayHeight = 0;
    $scope.displayWidth = 0;
    $scope.scaledWidth = 0;
    $scope.scaledHeight = 0;
    $scope.scaledTop = 0;
    $scope.scaledLeft = 0;

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
  }
]);
