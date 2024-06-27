//
//  Validator.swift
//  ComponentsProject
//
//  Created by Abhishek B on 2024-05-13.
//

import Foundation
import SwiftUI

enum ValidatorResult: Equatable {
    static func == (lhs: ValidatorResult, rhs: ValidatorResult) -> Bool {
        switch (lhs, rhs) {
        case (.unvalidated, .unvalidated):
            return true
        case (.valid, .valid):
            return true
        case (.invalid(_), .invalid(_)):
            return true
        case (.ongoing, .ongoing):
            return true
        default:
            return false
        }
    }

    case invalid(String)
    case valid
    case unvalidated
    case ongoing
}

protocol Validator {
    func validate(_ value: String) -> ValidatorResult
    var errorMessage: String { get }
}

extension String {
    func valid(forRegex: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", forRegex)
        return test.evaluate(with: self)
    }
}

class EmailValidator: Validator {
    private let regex = "^[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}$"
    var errorMessage: String = "default_email_error_message"

    func validate(_ value: String) -> ValidatorResult {
        if value.isEmpty {
            return .unvalidated
        } else {
            return value.valid(forRegex: regex) ?
                .valid :
                .invalid(errorMessage)
        }
    }
}

class EmailVerificationValidator: Validator {
    private let regex = "^[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}$"
    var errorMessage: String = "default_email_error_message"
    var errorMessageVerification: String = "click_to_pay_contact_information_verify_email_error_message"
    var emptyErrorMessage: String = "default_empty_field_error_message"

    var verificationText: Binding<String>

    init(verificationText: Binding<String>) {
        self.verificationText = verificationText
    }

    func validate(_ value: String) -> ValidatorResult {
        if value.isEmpty {
            return .unvalidated
        } else if value.valid(forRegex: regex) {
            if value == verificationText.wrappedValue {
                return .valid
            } else {
                return .invalid(errorMessageVerification)
            }
        } else {
            return .invalid(errorMessage)
        }
    }
}

class MobileNumberValidator: Validator {
    private let regex = "^(([+]46)*\\s*((7)|07))[02369]\\s*(\\d{3})\\s*(\\d{2})\\s*(\\d{2})$"
    var errorMessage: String = "default_phone_error_message"

    func validate(_ value: String) -> ValidatorResult {
        if value.isEmpty {
            return .unvalidated
        } else {
            let isValid = value.valid(forRegex: regex)

            if isValid {
                return .valid
            } else {
                if value.prefix(3) != "+46" {
                    return value.count > 8 ?
                        .valid :
                        .invalid(errorMessage)
                } else {
                    return .invalid(errorMessage)
                }
            }
        }
    }
}
