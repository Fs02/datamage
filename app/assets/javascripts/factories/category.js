angular.module('OpenData')
.factory("Category", function($resource) {
  return $resource("/api/categories/:id.json", {}, {
    query: { method: "GET", isArray: false }
  });
});
