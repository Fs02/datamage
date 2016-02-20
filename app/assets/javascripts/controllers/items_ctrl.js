angular.module('OpenData')
.controller('ItemsCtrl', [
  '$scope',
  '$stateParams',
  '$http',
  'Item',
  'Category',
  'Upload',
  '$state',
  '$mdDialog',
  '$mdToast',
  function($scope, $stateParams, $http, Item, Category, Upload, $state, $mdDialog, $mdToast) {
    $scope.cropper = {
      cropWidth: 100,
      cropHeight: 100
    };

    $http.get('/api/categories/tree.json').
      success(function(data) {
         $scope.categories = data.categories;
      });

    $scope.item = new Item();
    $scope.create = function() {
      // display loading
      $mdDialog.show({
        templateUrl: 'views/items/_loading.html',
        parent: angular.element(document.body),
        clickOutsideToClose:false
      });

      Upload.upload({
        url: 'api/items.json',
        method: 'POST',
        fields: {
          'item[caption]': $scope.item.caption,
          'item[category_id]': $scope.item.category_id,
        },
        file: $scope.item.image,
        fileFormDataName: 'item[image]'
      })
      .then(function (resp) {
        $mdDialog.hide(); // hide loading
        $mdToast.show(
          $mdToast.simple()
            .textContent('Image saved!')
            .hideDelay(3000)
            .position('bottom right')
        );
        $state.transitionTo('items_new', {}, {reload: true});
      }, function (resp) {
        $mdDialog.hide(); // hide loading
        $mdToast.show(
          $mdToast.simple()
            .textContent('Error when saving image!')
            .action('OK')
            .hideDelay(0)
        );
      }, function (evt) {});
  }
}]);
