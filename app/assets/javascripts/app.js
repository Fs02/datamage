angular.module('OpenData', ['ngMaterial', 'ngResource', 'ngImgCrop', 'ngFileUpload', 'ui.router', 'templates'])
.config([
'$stateProvider',
'$urlRouterProvider',
function($stateProvider, $urlRouterProvider) {

  $stateProvider
    .state('explores', {
      url: '/explores/:category_id',
      templateUrl: 'views/explores/gallery.html',
      controller: 'ExploresCtrl'
    })
    .state('items_new', {
        url: '/items/new',
        templateUrl: 'views/items/new.html',
        controller: 'ItemsCtrl'
      });

  $urlRouterProvider.otherwise('explores');
}]);
