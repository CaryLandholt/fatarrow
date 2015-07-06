# fatarrow
###An [AngularJS](http://angularjs.org/) large application Reference Architecture
[![License][license-image]][license-url]
[![Version][version-image]][version-url]
[![Build Status][build-image]][build-url]
[![Dependency Status][dependencies-image]][dependencies-url]

Build large [AngularJS](http://angularjs.org/) applications with [CoffeeScript](http://coffeescript.org/) - **without the ceremony**. By the way, you can write JavaScript too.


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
- All of the following file extensions are supported and will be processed by gulp:
  - Scripts: `.coffee`, `.js`, `.ls`, `.ts`, `.es6`
  - Styles: `.less`, `.css`, `.scss`
  - Templates: `.html`, `.haml`, `.jade`

**(Note: to keep the example succint, `.coffee`, `.html` and `.less` extension is used below)**

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
├──  gulp/
├──  e2e/
├──  bower_components/
├──  nodes_modules/
├──  .bowerrc
├──  .gitignore
├──  bower.json
├──  gulpfile.coffee
├──  protractor.conf.coffee
├──  package.json
</pre>

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
