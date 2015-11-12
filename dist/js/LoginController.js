(function(angular){
	var app = angular.module('SM');

	app.controller('LoginController', ['$scope', 'UserService', function($scope, UserService){
		$scope.username = null;
		$scope.password = null;

		$scope.hasErrors = false;

		$scope.errors = {};

		$scope.submit = function(){
			
			var login = {
				username: $scope.username,
				password: $scope.password
			};

			UserService.login(login, function(success, errors){
				if(!success)
				{
					$scope.hasErrors = true;
					$scope.errors = errors;
				}

				else{
					$scope.hasErrors = false;
				}
			});
		};
	}]);
})(angular);