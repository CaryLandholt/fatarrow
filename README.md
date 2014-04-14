# fatarrow [![Build Status][build-image]][build-url] [![Dependency Status][dependencies-image]][dependencies-url] [![devDependency Status][dev-dependencies-image]][dev-dependencies-url]

> An [AngularJS](http://angularjs.org/) large application Reference Architecture

Build large [AngularJS](http://angularjs.org/) applications with minimal boilerplate setup and ceremony.


## Table of Contents

* [Installing](#installing)
* [Running](#running)
* [Issues](#issues)
* [Contributing](#contributing)
* [Release History](#release-history)
* [License](#license)


## Installing

Before you can run, you must install and configure the following dependencies one time:

* [Git](http://git-scm.com/)
* [Node.js](http://nodejs.org/)
* [gulp.js](http://gulpjs.com/) - `npm install -g gulp`

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


## Issues

If you find a bug in the source code or a mistake in the documentation, you can help by submitting an [issue](https://github.com/CaryLandholt/fatarrow/issues) to the repository.  Even better, you can submit a Pull Request with a fix.  See [Contributing](#contributing) for details.

Before you submit your issue, search the [archive](https://github.com/CaryLandholt/fatarrow/issues).  Maybe your question was already answered.

If your issue appears to be a bug, and hasn't been reported, open a new issue.
Help to maximize the effort we can spend fixing issues and adding new features, by not reporting duplicate issues.  Providing the following information will increase the chances of your issue being dealt with quickly:

* **Overview of the issue** - if an error is being thrown a non-minified stack trace helps
* **Motivation for or Use Case** - explain why this is a bug for you
* **Version(s)** - is it a regression?
* **Operating System** - is this a problem with only Windows?
* **Reproduce the error** - provide a live example (using [Plunker](http://plnkr.co/edit) or [JSFiddle](http://jsfiddle.net/)) or an unambiguous set of steps.
* **Related issues** - has a similar issue been reported before?
* **Suggest a Fix** - if you can't fix the bug yourself, perhaps you can point to what might be causing the problem (line of code or commit)


## Contributing

In lieu of a formal styleguide, take care to maintain the existing coding style.  Add unit tests for any new or changed functionality. Lint and test your code.

[Pull Requests](https://github.com/CaryLandholt/fatarrow/pulls) are welcome!


## Release History

See the [Changelog](CHANGELOG.md)


## License

[The MIT License](http://opensource.org/licenses/MIT)

Copyright (c) 2014 Cary Landholt

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


[build-image]:            https://secure.travis-ci.org/CaryLandholt/fatarrow.svg
[build-url]:              http://travis-ci.org/CaryLandholt/fatarrow

[dependencies-image]:     https://david-dm.org/CaryLandholt/fatarrow.svg?theme=shields.io
[dependencies-url]:       https://david-dm.org/CaryLandholt/fatarrow

[dev-dependencies-image]: https://david-dm.org/CaryLandholt/fatarrow/dev-status.svg?theme=shields.io
[dev-dependencies-url]:   https://david-dm.org/CaryLandholt/fatarrow#info=devDependencies