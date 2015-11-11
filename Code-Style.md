# Code style

## Header files

Use only two line header:

```
//
//  Copyright © 2015 Mobile Academy. All rights reserved.
//

```

## Class template

Class template proposal:
```swift
class Foo {
	//MARK: Constants

	let key = "FOO BAR 123"

	//MARK: Properties

	var foo: String?

	//MARK: Initialisers

	init() {

	}

	//MARK: Public methods

	func doSomethingWith(foo: Sting) -> Bool {
		return false
	}

	//MARK: Private methods

	func someCalculation() -> Int {
		return 1+1
	}

}
```

## Spec template

Spec template proposal:

```swift
import Quick
import Nimble

@testable
import TDDWorkshop

class PhotoStreamViewControllerSpec: QuickSpec {
    override func spec() {
        describe("PhotoStreamViewController") {
            var photoStreamViewController: PhotoStreamViewController!

            beforeEach {
                photoStreamViewController = PhotoStreamViewController()
            }

            it("should work") {
                expect(true) == true
            }
        }
    }
}

```

## Spec helpers

Add suffix `Fake` to the class fake, e.g `Foo` should have `FooFake`.

## Variables in tests

Subject under test variables should be declared as explicitly unwrapped (it's really bad if your `sut` is nil):
```swift

var foo: Bar!

beforeEach {
	foo = Bar()
}
```

Other variables should be declared as optionals:

```swift

var foo: Bar?

beforeEach {
	foo = (...)
}
```

## License

Copyright © 2015 Mobile Academy. All rights reserved.
