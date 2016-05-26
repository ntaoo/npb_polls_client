This is a public repository of [https://npb-polls.appspot.com/](https://npb-polls.appspot.com/) client app. (The server side code repository is private.)

This small app is an example to learn how to build web app with Angular2 Dart.

# About Angular2 Dart version

Angular2 is written in TypeScript, and transpiled into Dart. The API is essentially same to the TypeScript version. Thus developers can learn Angular2 in either language they prefer. Actually I have learned Angular2 with [angular.io TypeScript version document](https://angular.io/docs/ts/latest/quickstart.html) and have written actual code in Dart. Of course you can refer to [the document of Dart version](https://angular.io/docs/dart/latest/quickstart.html) thanks to recent excellent translation work.

# The pros and cons

## Pros

* Clean simple semantics.
* Great standard libraries and tooling support.
* You don't need to bother about JavaScript's basic flaws thanks to the JavaScript compilers(dart2js, DDC).

Personally I see "Dart for the web" as "ECMAScript fixed" with type system and stable standard libraries, without JavaScript's tooling fuss.

## Cons

* Angular2's primary ecosystem will grow with the TypeScript version.
* No upgrade support from AngularJSv1.
* The community and ecosystem is still much smaller than the ones of JavaScript.
* Cross browser development cycle support is poor. (Hope DDC would ease it.)
* Compiled JS payload size tends to be huge for small app, especially a bit hard to justify for mobile network. (Cache support like service worker is important.)
* Requires IE > 11.


# Style Guide

I don't deliberately follow the some of [styleguide](https://angular.io/styleguide) because it is for the TypeScript version and some of them conflicts with the [Dart style guides](https://www.dartlang.org/effective-dart/style/).
I will consider to follow the style guide after the Dart version is published.

## ./lib/component

The directory that represents View and Controller(ViewModel) layer.

## ./lib/domain/model

The directory that represents Model layer.

## ./lib/domain/service

The directory that represents Service layer. Often the facade of Model for Controller.

## ./lib/resource

The directory that represents a kind of repository layer, handling restful resource API.
Personally I prefer to set explicit resource(repository) layer.

Implementing and maintaining a large amount of restful resource API code by hand will quickly become a tedious task.
In that case it might be worth to try automatic code generation with something like jsonapi or Swagger(OpenApi).

### No HTTP_PROVIDERS (yet).

Unlike the TypeScript version, the Dart version does not (yet?) provide Rx(Stream) based HTTP_PROVIDERS.
So I have implemented [future based transitive http client with middleware](https://github.com/ntaoo/http_lift) by myself, that will be replaced after a stream based http client is available.

# UI

The native Dart material UI library is expected to be available, which is a different work from [https://github.com/angular/material2](https://github.com/angular/material2). See also [https://github.com/angular/material2/issues/37](https://github.com/angular/material2/issues/37).

# appendix

I added public gist of [an example of Appengine's app.yaml handlers section for SPA](https://gist.github.com/ntaoo/5314f017cf30130cf2c3ed857f9ab02c).