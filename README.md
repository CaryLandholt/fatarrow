# fatarrow [![Build Status][build-image]][build-url] [![Dependency Status][dependencies-image]][dependencies-url] [![devDependency Status][dev-dependencies-image]][dev-dependencies-url]

> An [AngularJS](http://angularjs.org/) large application Reference Architecture

Build large [AngularJS](http://angularjs.org/) applications with minimal boilerplate setup and ceremony.


## Table of Contents

* [Installing](#installing)
* [Running](#running)
* [Issues](#issues)
* [Contributing](#contributing)
* [Commit Message Guidelines](#commit-message-guidelines)
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

Before you submit your pull request, consider the following guidelines:

* Search for an open or closed [Pull Request](https://github.com/CaryLandholt/fatarrow/pulls) that relates to your submission.  You don't want to duplicate effort.
* Make your changes in a new git branch
```bash
$ git checkout -b my-fix-branch master
```
* Create your patch, **including appropriate test cases**
* In lieu of a formal styleguide, take care to maintain the existing coding style.  Lint your code.
* Run the full test suite, and ensure that all tests pass
* Commit your changes using a descriptive commit message that follows the [Commit Message Guidelines](#commit-message-guidelines) and passes the commit message presubmit hook `validate-commit-msg.js`.  Adherence to the [Commit Message Guidelines](#commit-message-guidelines) is required, because release notes are automatically generated from these messages.
```bash
$ git commit -a
```
  Note: the optional commit `-a` command line option will automatically "add" and "rm" edited files
* Build your changes locally to ensure all the tests pass
```bash
$ grunt test
```
* Push your branch
```bash
$ git push origin my-fix-branch
```
* Send a pull request to `fatarrow:master`
* If changes are suggested then:
	- Make the required updates
	- Re-run the test suite to ensure tests are still passing
	- Rebase your branch and force push to your repository (this will update your Pull Request):
```bash
$ git rebase master -i
$ git push -f
```

**Thank you for your contribution!**

After your pull request is merged, you can safely delete your branch, and pull the changes from the main (upstream) repository:

* Delete the remote branch on GitHub either through the GitHub web UI or your local shell as follows:
```bash
$ git push origin --delete my-fix-branch
```
* Check out the master branch:
```bash
$ git checkout master -f
```
* Delete the local branch:
```bash
$ git branch -D my-fix-branch
```
* Update your master with the latest upstream version:
```bash
$ git pull --ff upstream master
```


## Commit Message Guidelines

We have very precise rules over how our git commit messages can be formatted.  This leads to **more readable messages** that are easy to follow when looking through the **project history**.  But also, we use the git commit messages to [Changelog](CHANGELOG.md).

### Commit Message Format

Each commit message consists of a **header**, a **body** and a **footer**.  The header has a special format that includes a **[Type](#type)**, a **[Scope](#scope)**, and a **[Subject](#subject)**:
```
<type>(<scope>): <subject>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>
```

Any line of the commit message cannot be longer than 100 characters!  This allows the message to be easier to read using various git tools.

#### Type

Must be one of the following:

* **feat**:  A new feature
* **fix**:  A bug fix
* **docs**:  Documentation only changes
* **style**:  Changes that do not affect the meaning of the code (white-space, formatting, etc.)
* **refactor**:  A code change that neither fixes a bug or adds a feature
* **perf**:  A code change that improves performance
* **test**:  Adding missing tests
* **chore**:  Changes to the build process or auxiliary tools and libraries such as documentation generation

#### Scope

The scope could be anything specifying place of the commit change.  For example `build`, `ci`, etc...

#### Subject

The subject contains a succinct description of the change:

* use the imperative, present tense: "change" not "changed" nor "changes"
* don't capitalize the first letter
* no dot (.) at the end

#### Body

Just as in the **[Subject](#subject)**, use the imperative, present tense: "change" not "changed" nor "changes".  The body should include the motivation for the change and contrast this with previous behavior.

#### Footer

The footer should contain any information about **[Breaking Changes](#breaking-changes)** and is also the place to reference issues that this commit **[Closes](#referencing-issues)**

##### Breaking Changes

All breaking changes have to be mentioned in the footer with the description of the change, justification, and migration notes
```
BREAKING CHANGE: gulp dev task has been deprecated

gulp dev was superfluous

Before:
gulp dev

After:
gulp
```

##### Referencing Issues

Closed bugs should be listed on a separate line in the footer prefixed with the "Closes" keyword like:
```
Closes #123
Closes #589
```


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