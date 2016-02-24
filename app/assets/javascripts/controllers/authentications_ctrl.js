angular.module('OpenData')
.controller('AuthenticationsCtrl', function($scope, $auth) {

  $scope.authenticate = function(provider) {
    $auth.authenticate(provider);
  };

  $scope.isAuthenticated = function() {
    return $auth.isAuthenticated();
  };

  $scope.logout = function() {
    $auth.logout();
  };
});
