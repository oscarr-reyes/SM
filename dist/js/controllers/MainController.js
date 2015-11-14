(function(angular){
	var app = angular.module('SM');

	app.controller('MainController', ['$scope', '$location', function($scope, $location){
		$scope.navbar = {
			links: [
				{
					route: '/',
					content: 'home',
					active: true
				},
				{
					route: '/line',
					content: 'line',
					active: false
				}
			]
		};

		$scope.route = function(route){
			$location.path(route);
		};

		$scope.$on('$locationChangeSuccess', function(obj, url){
			for(i in $scope.navbar.links){
				var link = $scope.navbar.links[i];

				if($location.path() == link.route)
					link.active = true;

				else
					link.active = false;
			}
		});
	}]);
})(angular);