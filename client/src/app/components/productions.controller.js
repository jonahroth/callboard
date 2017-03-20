export class ProductionsController {
    constructor ($scope, Production) {
        'ngInject';
        Production.query().then(productions => $scope.productions = productions);
    }
}
