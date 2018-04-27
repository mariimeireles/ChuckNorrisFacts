# ChuckNorrisFacts

:pencil2: Project for studies purpose

MVVM iOS Swift project where is possible to search for Chuck Norris facts, consuming the REST API [Chuck Norris](https://api.chucknorris.io/) and using [RxSwift](https://github.com/ReactiveX/RxSwift) to handle asynchronous events. Unit and UI tests are included in the application and [Bitrise](https://www.bitrise.io/) is used for continuous integration.

### Run Tests

#### Xcode

Go to `Product > Test` or press `command + U`

#### Terminal

You can run project tests by entering in the terminal:

```
fastlane test
```

Make sure you have all needed settings. To know how to set up fastlane, check [fastlane docs](https://docs.fastlane.tools/getting-started/ios/setup/)

### Dependencies

Carthage is used for dependency management. It involves less friction than e.g. Cocoapods.

To get started with development or after an update by another developer, simply run:

```
$ carthage update --platform ios
```

Ensure that Carthage is set up. To know how to install, check [Carthage docs](https://github.com/Carthage/Carthage#installing-carthage)
