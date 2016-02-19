angular.module('OpenData')
.factory("Item", function($resource) {
  return $resource("/api/items/:id.json", {}, {
    query: { method: "GET", isArray: false }
  });
});
