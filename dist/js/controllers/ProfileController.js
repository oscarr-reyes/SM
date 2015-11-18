(function(angular){
	var app = angular.module('SM');
	app.controller('ProfileController', ['$scope', '$location', 'UserService', function($scope, $location, UserService){
		$scope.name=UserService.getName();
		$scope.success = function(file, message, flow){
			console.log(JSON.parse(message));
		};
	}]);
})(angular);