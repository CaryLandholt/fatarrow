# fatarrow
###An [AngularJS](http://angularjs.org/) application Reference Architecture
[![License][license-image]][license-url]
[![Version][version-image]][version-url]
[![Build Status][build-image]][build-url]
[![Dependency Status][dependencies-image]][dependencies-url]

Build [AngularJS](http://angularjs.org/) applications with [CoffeeScript](http://coffeescript.org/) - **without the ceremony**. By the way, you can write JavaScript too.


## Table of Contents
* [Installing](#installing)
* [Running](#running)
* [Scripting](#scripting)
* [Styling](#styling)
* [Templating](#templating)
* [Structure](#structure)
* [Features](#features)
* [Configuration](#conf)
* [Contributing](#contributing)
* [Changelog](#changelog)
* [License](#license)


## Installing
Before running, you must install and configure the following one-time dependencies:

* [Git](http://git-scm.com/)
* [Node.js](http://nodejs.org/)

Enter the following in the terminal

Option 1: Using Yeoman Generator (Recommended)
```bash
$ npm install -g gulp yo
$ npm install -g generator-fatarrow
$ mkdir my-new-project && cd $_
$ yo fatarrow
```

Option 2: Clone this repo
```bash
$ npm install -g gulp
$ git clone git@github.com:CaryLandholt/fatarrow.git
$ cd fatarrow
$ npm install
```

## Running
Here are some useful commands to get started:

Get all commands and options by typing

```bash
$ gulp help
```

Running with With a fake backend ([$httpBackend](https://docs.angularjs.org/api/ngMockE2E/service/$httpBackend))
```bash
$ gulp
```
With a real backend (gulp will proxy calls to the backend of your choice)
```bash
$ gulp --backend
```
Build for production
```bash
$ gulp --prod --no-serve
```
Run tests on your build server
```bash
$ npm test
```
Deploy your app<a name="deploy"></a>
```bash
$ npm test
$ gulp --prod --no-serve
# deploy to a path (configuration in /config/locationConfig.coffee)
$ gulp deploy
# deploy to S3 (configurtion in /config/s3Config.coffee)
$ gulp deploy --target s3
```

## Scripting
Your choice of scripting languages.

* **JavaScript**
* **[Babel](https://babeljs.io/)**
* **[CoffeeScript](coffeescript.org)**
* **[LiveScript](livescript.net)**
* **[TypeScript](http://www.typescriptlang.org/)**

## Styling
Your choice of styling languages.

* **CSS**
* **[LESS](http://lesscss.org/)**
* **[Sass](http://sass-lang.com/)**

## Templating
Your choice of templating engines.

* **HTML**
* **[Haml](http://haml.info/)**
* **[Jade](http://jade-lang.com/)**
* **[Markdown](http://daringfireball.net/projects/markdown/)**

## Structure
- File extensions supported by fatarrow:
  - Scripts: `.coffee`, `.js`, `.ls`, `.ts`, `.es6`
  - Styles: `.less`, `.css`, `.scss`
  - Templates: `.html`, `.haml`, `.jade`

**(Note: to keep the example succint, `.coffee`, `.html` and `.less` extensions are used below. However, all of the file extensions listed above can be used, and even can be mix-and-matched.)**

The root directory generated for a fatarrow app:
<pre>
├──  e2e/
├──  config/
├──  src/
│   ├──  components/
│   │   └──  comp/
│   │   │   ├──  test
│   │   │   ├──  └──  comp.spec.coffee
│   │   │   ├──  comp.coffee
│   │   │   └──  comp.html
│   │   │   └──  comp.backend.coffee
│   │   │   └──  comp.less
│   ├──  app/
│   │   ├──  app.coffee
│   │   ├──  appRoutes.coffee
│   │   └──  views.backend.coffee
│   ├──  home/
│   │   ├──  homeController.coffee
│   │   ├──  homeRoutes.coffee
│   │   └──  home.html
│   ├──  img/
│   │   └──  angularjs.jpg
│   └──  index.html
├──  tasks/
├──  bower_components/
├──  nodes_modules/
├──  .bowerrc
├──  .gitignore
├──  bower.json
├──  gulpfile.coffee
├──  package.json
</pre>

Explanation of the folders:
- *`src/app`*: Angular module for the app. All app level config should go here.
- *`src/home`*: Each feature of the app should go in its own folder. It should contain all scripts, styles, templates and tests within the feature folder.
- *`src/components`*: Reusable components (directives, factories, styles, etc.)
- *`e2e`*: Protractor tests. They should also be separated by features/components.
- *`config`*: Configurtion for gulp tasks broken up by each task.

## Features
- *Fake data*: Running `gulp` will include the `.backend.coffee` files and therefore Angular's $httpBackend will be utilized. This should be used for backendless development.
- *Real data*: Running `gulp --backend` will proxy all backend calls to the backend of your choice. [See below](#conf) for configuration instructions.
- *Production build*: Running `gulp --prod` will produce builds for production. This includes:
	- *ngAnnotate* : make your angular code minification proof
	- *[ngClassify](https://github.com/CaryLandholt/ng-classify)* : CoffeeScript classes for angular
	- *minification* : JS, CSS and HTML
	- *image minification*: images from teh `img` folder are compressed
	- *rev*: minified files are rev'ed for browser cache busting
	- *templatecache* : take all angular templates and include them in the minified scripts
	- *deploy*: deploy to a path or to [AWS S3](http://aws.amazon.com/s3/). [see above](#deploy) for commands.
- *Dev Workflow*:
	- *watch* : watch your `src` folder and rebuild and reload automatically
	- *linting* : lint `.js` and `.coffee` files. style checking and fixing with [JSCS](http://jscs.info/)
	- *test* : run e2e (protractor) and unit (karma) tests
	- *[browserSync](http://www.browsersync.io/)* : test on multiple devices simultaneously
	- *newer*: only process changed files
	- *HTML5Mode*: [Angular's html5Mode](https://docs.angularjs.org/guide/$location) is supported on the BrowserSync server. Be sure to [configure your production web server](https://docs.angularjs.org/guide/$location). HTMO5Mode is turned on by default. See Angular's documentation to turn it off for browser compatibility.
	- *plato*: perform code visualization, static analysis, and complexity analysis

## Configuration<a name="conf"></a>
- *.jscsrc*: options for JSCS. [See reference](http://jscs.info/rules.html)
- *.jshintrc*: options for jsHint. [See reference](http://jshint.com/docs/options/)

**(Note: Configuration for the rest of the gulp plug-ins lives in the `config` folder.)**
- *app.coffee*
	- *`APP_NAME`*: name of the angular module for the app
- *bower.coffee*
	- *`BOWER_COMPONENTS`*: consume dependencies from bower by specifying dependency name, version, dependency type (scripts, styles, etc.) and a list of files to be consumed (cherry picking files).
- *coffeeLint.coffee*: options for linting CoffeeScript. [See reference](http://www.coffeelint.org/#options)
- *e2e.coffee*: options for protractor. [See reference](https://github.com/angular/protractor/blob/master/docs/referenceConf.js).
- *karma.coffee*: options for karma. [See reference](http://karma-runner.github.io/0.8/config/configuration-file.html)
- *languages.coffee*: disable compilers not in use to optimize your build
- *less.coffee*: options for the less compiler. [See reference](http://lesscss.org/usage/)
- *locationDeploy.coffee*: deploy app to a path
- *plato.coffee*: options for plato. [See reference](https://github.com/es-analysis/plato)
- *s3Deploy.coffee*: options to deploy to AWS S3. [See reference](https://www.npmjs.com/package/s3)
- *`SCRIPTS`*: load order for scripts
- *server.coffee*: options for browser-sync development server
	- *`PROXY_CONFIG`*: proxy backend calls during development with connect-modrewrite. [See reference](https://www.npmjs.com/package/connect-modrewrite)
	- *`PORT`*: run app on a specific port (default: 8181)
- *`STYLES`*: load order for styles

### Add Bower Component
You need three pieces of information for each Bower component to include in your app.

1. The Bower component name (e.g. *restangular*)
2. The version of the component (e.g. *1.4.0*)
3. The files within the component to include in your app (e.g. *restangular.min.js*)

The following will include the **restangular** component, version **1.4.0**, and place the `dist/restangular.min.js` file in the `vendor/scripts` directory.  By default, all Bower components will be placed in the `vendor` directory.
```coffee
BOWER_COMPONENTS =
	'restangular': '1.4.0':
		scripts: 'dist/restangular.min.js'
```

If load order is important, include a reference to the file in the **SCRIPTS** section.

The following will ensure **restangular** is loaded prior to `app.js`.
```coffee
SCRIPTS =
	'**/angular.min.js'
	'**/restangular.min.js'
	'**/app.js'
	'**/*.js'
```

For AngularJS components, include a reference to the module within your application.  For example:
```coffee
angular.module('app', ['restangular']);
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
