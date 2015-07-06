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
$ npm install -g gulp yo bower
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

Running with With a fake backend ( [$httpBackend](https://docs.angularjs.org/api/ngMockE2E/service/$httpBackend))
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
$ gulp test --citest --no-open
```

## Scripting
Your choice of scripting languages.

* **[Babel](https://babeljs.io/)**
* **[CoffeeScript](coffeescript.org)**
* **[LiveScript](livescript.net)**
* **JavaScript**
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

## Directory structure
- File extensions supported by fatarrow:
  - Scripts: `.coffee`, `.js`, `.ls`, `.ts`, `.es6`
  - Styles: `.less`, `.css`, `.scss`
  - Templates: `.html`, `.haml`, `.jade`

**(Note: to keep the example succint, `.coffee`, `.html` and `.less` extensions are used below. However, all of the file extensions listed above can be used, and even can be mix-and-matched. )**

The root directory generated for a fatarrow app:
<pre>
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
├──  e2e/
│   ├──  home/
│   │   ├──  home.spec.coffee
│   │   ├──  homePage.coffee
├──  bower_components/
├──  nodes_modules/
├──  .bowerrc
├──  .gitignore
├──  bower.json
├──  gulpfile.coffee
├──  protractor.conf.coffee
├──  package.json
</pre>

Explanation of the folders:
- *`app`*: Angular module for the app. All app level config should go here.
- *`home`*: Each feature of the app should go in its own folder. It should contain all scripts, styles, templates and tests within the feature folder.
- *`components`*: Reusable components (directives, factories, styles, etc.)
- *`e2e`*: Protractor tests. They should also be separated by features/components.

## Features provided by the gulpfile
- *Fake data*: Running `gulp` will include the `.backend.coffee` files and therefore Angular's $httpBackend will be utilized. This should be used for backendless development.
- *Real data*: Running `gulp --backend` will proxy all backend calls to the backend of your choice. [See below](#conf) for configuration instructions.
- *Production build*: Running `gulp --prod` will produce builds for production. This includes:
	- *ngAnnotate* : make your angular code minification proof
	- *[ngClassify](https://github.com/CaryLandholt/ng-classify)* : CoffeeScript classes for angular
	- *minification* : JS, CSS and HTML
	- *image minification*: images from teh `img` folder are compressed
	- *rev*: minified files are rev'ed for browser cache busting
	- *templatecache* : take all angular templates and include them in the minified scripts
- *Dev Workflow*:
	- *watch* : watch your `src` folder and rebuild and reload automatically
	- *linting* : lint `.js` and `.coffee` files
	- *test* : run e2e (protractor) and unit (karma) tests
	- *[browserSync](http://www.browsersync.io/)* : test on multiple devices simultaneously
	- *newer*: only process changed files

## Configuration<a name="conf"></a>
### `config.coffee`
- *`APP_NAME`*: name of the angular module for the app
- *`BOWER_COMPONENTS`*: consume dependencies from bower by specifying dependency name, version, dependency type (scripts, styles, etc.) and a list of files to be consumed (cherry picking files).
- *`LANGUAGES`*: disable compilers not in use to optimize your build
- *`PROXY_CONFIG`*: [connect-modrewrite](https://www.npmjs.com/package/connect-modrewrite) config to proxy api calls during development.
- *`SCRIPTS`*: load order for scripts
- *`STYLES`*: load order for styles

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
