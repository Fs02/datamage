angular.module('OpenData', ['ngMaterial', 'ngResource', 'ui.router', 'templates'])
.config([
'$stateProvider',
'$urlRouterProvider',
function($stateProvider, $urlRouterProvider) {

  $stateProvider
    .state('explores', {
      url: '/explores/:category_id',
      templateUrl: 'views/explores/_gallery.html',
      controller: 'ExploresCtrl'
    });

  $urlRouterProvider.otherwise('explores');
}]);
