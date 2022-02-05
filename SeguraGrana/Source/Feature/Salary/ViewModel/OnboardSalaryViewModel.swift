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

    func isValidData(salary: String, payday: String) -> Bool {
        isValidSalary(value: salary) && isValidPayDay(value: payday)
    }

    func setSalary(value: String, payday: String) {
        let userDefaultsManager = UserDefaultsManager()
        let salary = SalaryModel(value: Double(value) ?? 0,
                                 payday: payday)
        userDefaultsManager.setModel(model: salary,
                                     key: .salary)
    }

    func isValidPayDay(value: String) -> Bool {
        value.isValidDayOfMounth()
    }

    // MARK: - Private Methods

    private func isValidSalary(value: String) -> Bool {
        Double(value) != nil
    }
}
