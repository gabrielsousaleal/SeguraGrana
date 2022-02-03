//
//  RegisterCreditCardViewModel.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 03/02/22.
//

import Foundation

class RegisterCreditCardViewModel {

    // MARK: - Public Methods

    func saveCreditCard(name: String, deadend: String) {
        guard let date = deadend.getDateMonthAndDay() else { return }

        let creditCard = CreditCardModel(name: name,
                                         deadline: date)
        let userDefaultsManager = UserDefaultsManager()
        userDefaultsManager.saveCreditCard(creditCard: creditCard)
    }

    func isValidData(name: String, date: String) -> Bool {
        isValidDate(date: date) && isValidName(name: name)
    }

    // MARK: - Private Methods

    private func isValidDate(date: String) -> Bool {
        date.getDateMonthAndDay() != nil
    }

    private func isValidName(name: String) -> Bool {
        name != .empty
    }
}
