// http://stackoverflow.com/a/32011326
angular.module('OpenData')
.directive("fileread", [
  function() {
    return {
      scope: {
        fileread: "="
      },
      link: function(scope, element, attributes) {
        element.bind("change", function(changeEvent) {
          var reader = new FileReader();
          reader.onload = function(loadEvent) {
            scope.$apply(function() {
              scope.fileread = loadEvent.target.result;
            });
          }
          reader.readAsDataURL(changeEvent.target.files[0]);
        });
      }
    }
  }
]);
