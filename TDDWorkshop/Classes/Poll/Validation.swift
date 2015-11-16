//
// Created by Maciej Oczko on 16.11.2015.
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

protocol Validator {

    func validateText(text: String?) -> Bool

    func validationFailMessage() -> String
}

// MARK: Factory

class ValidatorFactory {

    func validatorForKey(key: String) -> Validator? {
        switch key {
        case "name": return IllegalSymbolsValidator()
        case "username": return EmailValidator()
        case "feedback": return CharactersMinimalCountValidator(20)
        case "comment": return CharactersMinimalCountValidator(10)
        default: return nil
        }
    }

}

// MARK: Validators

class CharactersMinimalCountValidator: Validator {
    let minimalCharactersCount: Int

    init(_ minimalCharactersCount: Int) {
        self.minimalCharactersCount = minimalCharactersCount
    }

    func validateText(text: String?) -> Bool {
        guard let text = text where !text.isEmpty else {
            return false
        }
        return text.characters.count >= self.minimalCharactersCount
    }

    func validationFailMessage() -> String {
        return "less than \(self.minimalCharactersCount) characters"
    }
}

class EmailValidator: Validator {

    func validateText(text: String?) -> Bool {
        guard let text = text where !text.isEmpty else {
            return false
        }
        return self.validateEmail(text)
    }

    func validationFailMessage() -> String {
        return "invalid email format"
    }

    private func validateEmail(email: String) -> Bool {
        let pattern = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let regex = NSPredicate(format: "SELF MATCHES %@", pattern)
        return regex.evaluateWithObject(email)
    }
}

class IllegalSymbolsValidator: Validator {

    func validateText(text: String?) -> Bool {
        guard let text = text where !text.isEmpty else {
            return false
        }
        return [
                NSCharacterSet.illegalCharacterSet(),
                NSCharacterSet.symbolCharacterSet(),
                NSCharacterSet.punctuationCharacterSet(),
                NSCharacterSet.nonBaseCharacterSet(),
                NSCharacterSet.controlCharacterSet(),
        ].reduce(true) {
            $0 && text.rangeOfCharacterFromSet($1) == nil
        }
    }

    func validationFailMessage() -> String {
        return "invalid characters"
    }

}
