export function routerConfig ($stateProvider, $urlRouterProvider) {
  'ngInject';
  $stateProvider
    .state('home', {
      url: '/',
      templateUrl: 'app/main/main.html',
      controller: 'MainController',
      controllerAs: 'main'
    }).state('productions', {
        url: '/productions',
        templateUrl: 'app/components/productions.html',
        controller: 'ProductionsController',
        controllerAs: 'productions'
    });

  $urlRouterProvider.otherwise('/');
}
