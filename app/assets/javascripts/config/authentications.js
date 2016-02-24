angular.module('OpenData')
  .config(function($authProvider) {
    $authProvider.httpInterceptor = true;

    $authProvider.github({
      url: '/api/auth/github',
      clientId: 'fa043436c0c74f178f25'
    });
  });
