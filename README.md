# fatarrow [![Version][version-image]][version-url] [![Build Status][build-image]][build-url] [![Dependency Status][dependencies-image]][dependencies-url] [![License][license-image]][license-url]
> An [AngularJS](http://angularjs.org/) large application Reference Architecture

Build large [AngularJS](http://angularjs.org/) applications with [CoffeeScript](http://coffeescript.org/) - **without the ceremony**.  By the way, you can write JavaScript too.


## Table of Contents
* [Installing](#installing)
* [Running](#running)
* [Writing Your App](#writing-your-app)
* [Contributing](#contributing)
* [Changelog](#changelog)
* [License](#license)


## Installing
Before running, you must install and configure the following one-time dependencies:

* [Git](http://git-scm.com/)
* [Node.js](http://nodejs.org/)
* [gulp.js](http://gulpjs.com/) - use the terminal command below
```bash
$ npm install -g gulp
```

Once the dependencies have been installed, enter the following commands in the terminal:
```bash
$ git clone git@github.com:CaryLandholt/fatarrow.git
$ cd fatarrow
$ npm install
```


## Running
Enter the following in the terminal:
```bash
$ gulp
```


## Writing Your App
fatarrow takes advantage of **[ng-classify](https://github.com/CaryLandholt/ng-classify)**, allowing you to write AngularJS modules as CoffeeScript classes.

Instead of writing your controllers like this:
```javascript
angular.module('app').controller('todoController', ['todoService', function (todoService) {
	this.todos = todoService.get();

	this.add = function (todo) {
		todoService.add(todo);
	};
}]);
```

Write them like this:
```coffee
class Todo extends Controller
	constructor: (@todoService) ->
		@todos = @todoService.get()

	add: (todo) ->
		@todoService.add todo
```


### Structure
**Source**
```
src/
├── app/
│   ├── app.coffee
│   ├── appRoutes.coffee
│   └── views.backend.coffee
├── home/
│   ├── home.html
│   ├── homeController.coffee
│   └── homeRoutes.coffee
└── index.html
```

**Distribution (Dev)**
```
dist/
├── app/
│   ├── app.js
│   ├── appRoutes.js
│   └── views.backend.js
├── home/
│   ├── home.html
│   ├── homeController.js
│   └── homeRoutes.js
├── vendor/
│   ├── angular/
│   │   └── scripts/
|   |       └── angular.min.js
│   ├── angular-animate/
│   │   └── scripts/
|   |       └── angular-animate.min.js
│   ├── angular-mocks/
│   │   └── scripts/
|   |       └── angular-mocks.js
│   ├── angular-route/
│   │   └── scripts/
|   |       └── angular-route.min.js
│   ├── bootstrap/
│   │   ├── fonts/
|   |   |   ├── glyphicons-halflings-regular.eot
|   |   |   ├── glyphicons-halflings-regular.svg
|   |   |   ├── glyphicons-halflings-regular.ttf
|   |   |   └── glyphicons-halflings-regular.woff
│   │   └── styles/
|   |       ├── bootstrap-theme.min.css
|   |       └── bootstrap.min.css
│   ├── google-code-prettify/
│   │   ├── scripts/
|   |   |   └── prettify.js
│   │   └── styles/
|   |       └── prettify.css
└── index.html
```

**Distribution (Prod)**
```
dist/
├── fonts/
│   ├── glyphicons-halflings-regular.eot
│   ├── glyphicons-halflings-regular.svg
│   ├── glyphicons-halflings-regular.ttf
│   └── glyphicons-halflings-regular.woff
├── scripts/
│   └── scripts.min.js
├── styles/
│   └── styles.min.css
└── index.html
```


## Contributing
See [CONTRIBUTING.md](CONTRIBUTING.md)


## Changelog
See [CHANGELOG.md](CHANGELOG.md)


## License
See [LICENSE](LICENSE)


[build-image]:            http://img.shields.io/travis/CaryLandholt/fatarrow.svg?style=flat
[build-url]:              http://travis-ci.org/CaryLandholt/fatarrow

[dependencies-image]:     http://img.shields.io/gemnasium/CaryLandholt/fatarrow.svg?style=flat
[dependencies-url]:       https://gemnasium.com/CaryLandholt/fatarrow

[license-image]:          http://img.shields.io/badge/license-MIT-blue.svg?style=flat
[license-url]:            LICENSE

[version-image]:          http://img.shields.io/github/tag/CaryLandholt/fatarrow.svg?style=flat
[version-url]:            https://github.com/CaryLandholt/fatarrow/tags