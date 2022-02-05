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
        guard let date = Int(deadend) else { return }

        let creditCard = CreditCardModel(name: name,
                                         deadline: date)
        let userDefaultsManager = UserDefaultsManager()
        let updatedCreditCardList = appendCreditCardOnList(creditCard: creditCard)
        userDefaultsManager.setModel(model: updatedCreditCardList,
                                     key: .creditCards)
        userDefaultsManager.set(value: true as AnyObject,
                                key: .didOnboard)
        let didOnboard = userDefaultsManager.get(key: .didOnboard)
        print(didOnboard)
    }

    func isValidData(name: String, date: String) -> Bool {
        isValidDate(date: date) && isValidName(name: name)
    }

    // MARK: - Private Methods

    private func appendCreditCardOnList(creditCard: CreditCardModel) -> [CreditCardModel] {
        var creditCardList = UserDefaultsManager().getModel(model: [CreditCardModel].self,
                                                            key: .creditCards)
        creditCardList?.append(creditCard)
        return creditCardList ?? []
    }

    private func isValidDate(date: String) -> Bool {
        date.isValidDayOfMounth()
    }

    private func isValidName(name: String) -> Bool {
        name != .empty
    }
}
