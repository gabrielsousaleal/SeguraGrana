//
//  ValueInAccountViewModel.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 06/02/22.
//

import Foundation

class ValueInAccountViewModel {

    // MARK: - Private Properties

    private let userDefaultsManager = UserDefaultsManager()

    // MARK: - Public Methods

    func isValidValue(value: String) -> Bool {
        Double(value) != nil
    }

    func addValueToBalance(value: String) {
        userDefaultsManager.set(value: value as AnyObject,
                                key: .currentBalance)
    }
}
