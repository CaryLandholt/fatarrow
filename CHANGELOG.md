### 1.1.0 (2014-12-10)


#### Bug Fixes

* **app:** make IDE friendly ([1ae02635](https://github.com/CaryLandholt/fatarrow/commit/1ae026357dbcb768f91f4b85420ae5b3ceecb5fa), closes [#18](https://github.com/CaryLandholt/fatarrow/issues/18))
* **appName:** pass config option to ng-classify ([eecac027](https://github.com/CaryLandholt/fatarrow/commit/eecac027c0b03586adb9d6760462cb9f22bcae56), closes [#17](https://github.com/CaryLandholt/fatarrow/issues/17))
* **bower:** add support for component urls ([3b9b1ad3](https://github.com/CaryLandholt/fatarrow/commit/3b9b1ad3bbfe3ecb73fe9129195a19cdfbe7e006), closes [#21](https://github.com/CaryLandholt/fatarrow/issues/21))
* **childProcess:** pass args to child process ([e43a4215](https://github.com/CaryLandholt/fatarrow/commit/e43a4215ea65c5e22a1a623110a257ed4d25bfb5), closes [#13](https://github.com/CaryLandholt/fatarrow/issues/13))
* **less:** add paths to less configuration ([c5f8d9c1](https://github.com/CaryLandholt/fatarrow/commit/c5f8d9c1f69e1d455c73da6c3d4b5364c08e56a9), closes [#20](https://github.com/CaryLandholt/fatarrow/issues/20))


#### Features

* **bowerSwitch:** add switch to turn off bower component retrieval ([a6e5a58f](https://github.com/CaryLandholt/fatarrow/commit/a6e5a58f3959d962070399347711a77ab9694891))


## 1.0.0 (2014-10-15)


#### Bug Fixes

* **avatar:** use avatar path from reportcard response ([8c2b453e](https://github.com/CaryLandholt/fatarrow/commit/8c2b453e5ec16331baf1d825c5f84d039706bbde))
* **bower:** use latest version when conflicted ([5e42dcbb](https://github.com/CaryLandholt/fatarrow/commit/5e42dcbb8132b0f18dd5e0fc361dedc3b8e1733d))


### 0.9.4 (2014-09-03)


#### Bug Fixes

* **karma config:** load external templates ([7b0a8a34](https://github.com/CaryLandholt/fatarrow/commit/7b0a8a34dabf196816cd377769dafd7806662bbe))
* **path:** file path was off ([6ef797e1](https://github.com/CaryLandholt/fatarrow/commit/6ef797e11383cea9aadc3611779315d79e4dabd6))
* **reportCard:** use jsonp instead of get ([04cb1d3b](https://github.com/CaryLandholt/fatarrow/commit/04cb1d3bdc60735bb9e0716e6f366e27b46ad230))


### 0.9.3 (2014-08-14)


#### Bug Fixes

* **bower:** clean prior to running bower task ([87629086](https://github.com/CaryLandholt/fatarrow/commit/876290865a6aeee7e1ebeb887dfcf9794c9afc95), closes [#2](https://github.com/CaryLandholt/fatarrow/issues/2))


### 0.9.2 (2014-07-29)


#### Bug Fixes

* **README:** fix sass logo path ([be4a0a84](https://github.com/CaryLandholt/fatarrow/commit/be4a0a84578f80e6f929d149881aef11e31dec19))
* **subDomain:** remove prefixed / to ensure app is functional within a sub domain ([17339c9b](https://github.com/CaryLandholt/fatarrow/commit/17339c9bd7d3a1fcfd3523517fbdb2cc7ac8192a))


### 0.9.1 (2014-06-29)


#### Bug Fixes

* **package.json:** require specific package version when not following semver ([5b5ff52b](https://github.com/CaryLandholt/fatarrow/commit/5b5ff52b9d99f1629f86ccf3b0bb44eddfaee77b))


## 0.9.0 (2014-06-23)


#### Features

* **LiveScript:** add LiveScript support ([eb44217b](https://github.com/CaryLandholt/fatarrow/commit/eb44217b0a5e26ae2e246652d0770db0d7428633))


## 0.8.0 (2014-06-20)


#### Features

* **jshint:** add jshint for JavaScript files ([9427b7d9](https://github.com/CaryLandholt/fatarrow/commit/9427b7d9a3da3d4167266da6a4fc04cefe64db1b))
* **loading-bar:** add angular-loading-bar ([9d72f44a](https://github.com/CaryLandholt/fatarrow/commit/9d72f44ae094a63dbfa1cf8a7b03e632233c02be))


#### Breaking Changes

* update gulp-ng-classify

See https://github.com/CaryLandholt/ng-classify/blob/master/CHANGELOG.md#300-2014-06-18

 ([c913cf7a](https://github.com/CaryLandholt/fatarrow/commit/c913cf7a2f1ebcd6a8e2706d4dfdd3aea2027f40))
* some Protractor locators have been deprecated

See https://github.com/angular/protractor/commit/9e5d9e4abb7d0928e6092a711fda527554994be7

Instead of By.input, use By.model, for example

 ([db08eb53](https://github.com/CaryLandholt/fatarrow/commit/db08eb53b87982049237fac8d48f9bfbf201c033))


## 0.7.0 (2014-06-12)


#### Features

* **haml:** add haml support ([c2e7cec9](https://github.com/CaryLandholt/fatarrow/commit/c2e7cec99da19b1d6b6ba92274670aec0cb6a60d))
* **sass:** add sass support ([86db0cd9](https://github.com/CaryLandholt/fatarrow/commit/86db0cd911baec1ab3f0de7883bd396f6abccefb))


## 0.6.0 (2014-06-02)


#### Bug Fixes

* **cli:** prevent stats from executing on changelog if switch set ([01c60aca](https://github.com/CaryLandholt/fatarrow/commit/01c60aca7cb33dbacf3277258313f77cc846e1fa))
* **script:** build correct url ([48679143](https://github.com/CaryLandholt/fatarrow/commit/48679143e799767848d1810ced293f0bff4ac2dc))
* **stats:**
  * serve stats in non prod ([7a8394d8](https://github.com/CaryLandholt/fatarrow/commit/7a8394d88f358ff299034b0975b2d7f935cddfaa))
  * run stats on changelog ([0491e2c3](https://github.com/CaryLandholt/fatarrow/commit/0491e2c3648d9558ec60c9df98f2255e74dc3076))


#### Features

* **cli:** add stats ([f4d0b867](https://github.com/CaryLandholt/fatarrow/commit/f4d0b8678bf619b534f59c858ec82af97f18fbff))


<a name="0.5.0"></a>
## 0.5.0  (2014-05-27)


#### Features

* **YouTubePlayer:** add YouTubePlayer widget ([eebde83c](https://github.com/CaryLandholt/fatarrow/commit/eebde83c0ca407de0ff6519e0fa4a2f4dbd76007))


<a name="0.4.2"></a>
### 0.4.2  (2014-05-27)


#### Bug Fixes

* **bower.json:** recreate bower.json on changelog ([f1f26fcb](https://github.com/CaryLandholt/fatarrow/commit/f1f26fcb91d64127a721e21031ac8af4ca428aa2))
* **paths:** Windows paths are file paths ([3121a2c1](https://github.com/CaryLandholt/fatarrow/commit/3121a2c1b44fe5eac61bad949c2763e888de0929))


<a name="0.4.1"></a>
### 0.4.1  (2014-05-26)


#### Bug Fixes

* **imagemin:** add .png files ([7f039036](https://github.com/CaryLandholt/fatarrow/commit/7f0390361d5ee4da0818c7248a21d653b20efec5))


<a name="0.4.0"></a>
## 0.4.0  (2014-05-25)


#### Features

* **stats:**
  * make stats available when running the app ([0ea9825d](https://github.com/CaryLandholt/fatarrow/commit/0ea9825dbb3894259c3adb14e63bef1d912c5cc3))
  * add plato stats ([6e4dc435](https://github.com/CaryLandholt/fatarrow/commit/6e4dc43585d4344a57f679f6cd9e71c39ad16fbb))


<a name="0.3.0"></a>
## 0.3.0  (2014-05-20)


#### Features

* **imagemin:** add imagemin ([13ff2d49](https://github.com/CaryLandholt/fatarrow/commit/13ff2d4952e41622add01d842fe8f25b1e9e35de))


<a name="0.2.0"></a>
## 0.2.0  (2014-05-18)


#### Features

* **backend:** add backend config ([6e4aa93b](https://github.com/CaryLandholt/fatarrow/commit/6e4aa93b904b645f8c3aa35b296382c143eb9b3b))
* **ngmin:** add ngmin ([7513cb3f](https://github.com/CaryLandholt/fatarrow/commit/7513cb3f40dbaa2224a54cd38cd72908ce7e7552))


<a name="0.1.2"></a>
### 0.1.2  (2014-05-16)


#### Bug Fixes

* **minifyHtml:** do not minify prior to templateCache ([06bb4aa1](https://github.com/CaryLandholt/fatarrow/commit/06bb4aa1662d99a525842a467e5ec5537984205c))


<a name="0.1.1"></a>
### 0.1.1  (2014-05-16)


#### Bug Fixes

* **ngAnimate:** remove ngAnimate ([3fbf7991](https://github.com/CaryLandholt/fatarrow/commit/3fbf79917ab0f7012003e67e8e6dd56d67e54ab1))


<a name="0.1.0"></a>
## 0.1.0  (2014-05-16)


#### Bug Fixes

* **bower:** properly set component map for .map files ([5cb876d5](https://github.com/CaryLandholt/fatarrow/commit/5cb876d577c89a5c8a8052d53e206f5bfbfd56be))
* **build:** add unixify to path ([8279a27d](https://github.com/CaryLandholt/fatarrow/commit/8279a27db3d1be6fbe0c17e9a2724d84145f48dc))
* **e2e:** tweaks ([4a2747fa](https://github.com/CaryLandholt/fatarrow/commit/4a2747fa827b6720522cc713b0882b94947cc8d9))
* **gulp:** prevent stop of gulp watch on error ([13de78bd](https://github.com/CaryLandholt/fatarrow/commit/13de78bda10421a47f0aebef9564739e68af827c))
* **name:** rename to fatarrow ([4cb889f0](https://github.com/CaryLandholt/fatarrow/commit/4cb889f0954f34b35a63b4be79b578c188950573))
* **package.json:** remove .git extension from repository ([84ccdd1a](https://github.com/CaryLandholt/fatarrow/commit/84ccdd1a7c6f0eb11595f262b0699441be0ecacb))
* **phantomjs:**
  * now fix Mac ([a6d7375e](https://github.com/CaryLandholt/fatarrow/commit/a6d7375e16d1f6ca30536af15ce03492c974daa4))
  * fix windows binary path ([3a4b1afb](https://github.com/CaryLandholt/fatarrow/commit/3a4b1afb960ccd02b5b815df25eb54d860c62cf9))
* **syntaxHighlighter:**
  * fix sourceMap path ([1484d31a](https://github.com/CaryLandholt/fatarrow/commit/1484d31a7843a5161e3ee360555ee4f09e0ed8ed))
  * allow for html ([43a977cc](https://github.com/CaryLandholt/fatarrow/commit/43a977cca5f0663a0f5ca9bb1f3c1d91a8d4e21e))


#### Features

* **ReportCard:** add open source report card ([1cb5a0f1](https://github.com/CaryLandholt/fatarrow/commit/1cb5a0f15735aadae26e468a6620898f5ae0b718))
* **TypeScript:** add TypeScript support ([6cf47d7c](https://github.com/CaryLandholt/fatarrow/commit/6cf47d7ca3cb4056d1cb34584b6ef724b88c6adf))
* **app:** add app ([bc8edbb8](https://github.com/CaryLandholt/fatarrow/commit/bc8edbb826e2004fb253865408da5b7280aee357))
* **changelog:**
  * write to changelog.md ([ecde5966](https://github.com/CaryLandholt/fatarrow/commit/ecde59662d0512317a9f66efa47b6a1affc4b196))
  * reference package.json version ([2e2ccff5](https://github.com/CaryLandholt/fatarrow/commit/2e2ccff50fcaf860967bc7f6ad8894f7638eaafb))
  * add changelog ([a8d6de8a](https://github.com/CaryLandholt/fatarrow/commit/a8d6de8ae7a4d7de760395b24b9e9b43bffc67a8))
* **connect:** add gulp-connect ([5c5197fe](https://github.com/CaryLandholt/fatarrow/commit/5c5197fed7a68d400729642a6f050607c7ef092f))
* **e2e:** add e2e support via protractor ([71650f6a](https://github.com/CaryLandholt/fatarrow/commit/71650f6ab2f69b9f04ae32b86811819c7b7ab915))
* **includify:** initial support for including scripts and styles in index.html ([7fc768b2](https://github.com/CaryLandholt/fatarrow/commit/7fc768b29f403797275986157b3b7ca45de02a68))
* **logo:** add AngularJS logo ([ace135db](https://github.com/CaryLandholt/fatarrow/commit/ace135dbb0a9e4a1c5d9df43ed3553583d53bdd6))
* **markdown:** add markdown directive ([c894ed4b](https://github.com/CaryLandholt/fatarrow/commit/c894ed4b5e5302d060a1a8a54ad3b7f2d2e3e2b0))
* **ng-classify:** add ng-classify support ([818f90a2](https://github.com/CaryLandholt/fatarrow/commit/818f90a28d23d4f07c2639ee78024aecde29d232))
* **optimize:** add optimizations ([7434fbf6](https://github.com/CaryLandholt/fatarrow/commit/7434fbf6a61041c62af421b575b107aae7c31e3d))
* **routes:** add routes directive ([29aaafa3](https://github.com/CaryLandholt/fatarrow/commit/29aaafa393c5173f027f758034f5f18df41cca52))
* **script:** add script directive ([d6863d68](https://github.com/CaryLandholt/fatarrow/commit/d6863d68b6e122693115d538011ab40fa4f2221c))
* **specReporter:** add karma-spec-reporter ([d551cbed](https://github.com/CaryLandholt/fatarrow/commit/d551cbedc48a536838ac52a9f192ae498f1e7948))
* **syntaxHighlighter:**
  * add styles ([dc938143](https://github.com/CaryLandholt/fatarrow/commit/dc93814392bd01d0396020b3d0f00325082ea2e2))
  * change provider to google-code-prettify ([707c6d49](https://github.com/CaryLandholt/fatarrow/commit/707c6d493c0d500cbb4652677635a16293657b91))
  * add syntax highlighting functionality ([04b33975](https://github.com/CaryLandholt/fatarrow/commit/04b33975f2363f1d430ff77259fff424fe3cb21e))