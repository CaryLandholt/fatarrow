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

```bash
$ npm install -g gulp
$ git clone git@github.com:CaryLandholt/fatarrow.git
$ cd fatarrow
$ npm install
```

## Running
Get all commands and options by typing

```bash
$ gulp help
```

Here are some useful commands to get started:

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
