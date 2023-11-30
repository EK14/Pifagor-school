//
//  MyError.swift
//  Pifagor
//
//  Created by Элина Карапетян on 28.11.2023.
//

import Foundation

public enum MyError: Error {
    case noEmailError
    case noPasswordError
    case noNameError
}

extension MyError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noEmailError:
            return NSLocalizedString("Пожалуйста, введите ваш email.", comment: "")
        case .noPasswordError:
            return NSLocalizedString("Пожалуйста, введите ваш пароль.", comment: "")
        case .noNameError:
            return NSLocalizedString("Пожалуйста, введите ваше имя.", comment: "")
        }
    }
}
