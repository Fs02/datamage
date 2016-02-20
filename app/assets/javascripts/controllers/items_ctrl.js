angular.module('OpenData')
.controller('ItemsCtrl', [
  '$scope',
  '$stateParams',
  '$http',
  'Item',
  'Category',
  'Upload',
  function($scope, $stateParams, $http, Item, Category, Upload) {
    $scope.cropper = {
      cropWidth: 100,
      cropHeight: 100
    };

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
      Upload.upload({
        url: 'api/items.json',
        method: 'POST',
        fields: {
          'item[caption]': $scope.item.caption,
          'item[category_id]': $scope.item.category_id,
        },
        file: $scope.item.image,
        fileFormDataName: 'item[image]'
      });
  }
}]);
