//
// Created by Maciej Oczko on 16.11.2015.
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable
import TDDWorkshop

// MARK: Factory

class ValidatorFactorySpec: QuickSpec {
    override func spec() {
        var factory: ValidatorFactory!

        beforeEach() {
            factory = ValidatorFactory()
        }

        afterEach {
            factory = nil
        }

        it("should return illegal symbols validator for name") {
            expect(factory.validatorForKey("name") is IllegalSymbolsValidator).to(beTrue())
        }

        it("should return email validator for username") {
            expect(factory.validatorForKey("username") is EmailValidator).to(beTrue())
        }

        it("should return minimal characters cound validator for feedback") {
            expect(factory.validatorForKey("feedback") is CharactersMinimalCountValidator).to(beTrue())
        }

        it("should return minimal characters cound validator for comment") {
            expect(factory.validatorForKey("comment") is CharactersMinimalCountValidator).to(beTrue())
        }
    }
}

// MARK: Validators

class CharactersMinimalCountValidatorSpec: QuickSpec {
    override func spec() {
        var validator: CharactersMinimalCountValidator!

        beforeEach() {
            validator = CharactersMinimalCountValidator(10)
        }

        afterEach {
            validator = nil
        }

        it("should pass if more than 10 chars") {
            expect(validator.validateText("ten chars ten chars ten chars")).to(beTrue())
        }

        it("should pass if equal to 10 chars") {
            expect(validator.validateText("12345678910")).to(beTrue())
        }

        it("should fail if less than 10 chars") {
            expect(validator.validateText("abcd")).to(beFalse())
        }
    }
}

class EmailValidatorSpec: QuickSpec {
    override func spec() {
        var validator: EmailValidator!

        beforeEach() {
            validator = EmailValidator()
        }

        afterEach {
            validator = nil
        }

        it("should pass for valid email") {
            expect(validator.validateText("example@example.com")).to(beTrue())
        }

        it("should fail for invalid email") {
            expect(validator.validateText("bad@example")).to(beFalse())
        }
    }
}

class IllegalSymbolsValidatorSpec: QuickSpec {
    override func spec() {
        var validator: IllegalSymbolsValidator!

        beforeEach() {
            validator = IllegalSymbolsValidator()
        }

        afterEach {
            validator = nil
        }

        it("should pass for legal chars") {
            expect(validator.validateText("sample text")).to(beTrue())
        }

        it("should fail for illegal chars") {
            expect(validator.validateText("sample ^ text")).to(beFalse())
            expect(validator.validateText("sample - text")).to(beFalse())
            expect(validator.validateText("sample () text")).to(beFalse())
            expect(validator.validateText("sample \n text")).to(beFalse())
        }
    }
}

