angular.module('app').service('greetingService', ['$log', function Greeting ($log) {
    this.sayHello = (name) => {
        return $log.info(name);
    };
}]);