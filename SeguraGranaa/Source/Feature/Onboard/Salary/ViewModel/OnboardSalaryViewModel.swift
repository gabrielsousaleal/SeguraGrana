//
//  OnboardSalaryViewModel.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import UIKit

class OnboardSalaryViewModel {

    // MARK: - Public Methods

    func getContinueButtonAlpha(isEnabled: Bool) -> CGFloat {
        isEnabled ? 1 : 0.5
    }

    func isValidSalary(value: String) -> Bool {
        Double(value) != nil
    }

    func setSalary(value: String) {
        let userDefaultsManager = UserDefaultsManager()
        userDefaultsManager.set(value: value as AnyObject,
                                key: .salary)
    }
}
