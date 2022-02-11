//
//  RegisterCreditCardViewModel.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 03/02/22.
//

import Foundation

class BillRegisterViewModel {

    // MARK: - Public Methods

    func saveBill(name: String, deadend: String, value: String) {
        guard let date = Int(deadend), let value = Double(value) else { return }

        let category = DoubtCategoryModel(name: "Contas",
                                          icon: "bills")
        let bill = DoubtModel(value: value,
                              name: name,
                              category: category,
                              isReccurent: true,
                              deadline: date)
        let userDefaultsManager = UserDefaultsManager()
        let updatedBillList = appendBillOnList(bill: bill)
        userDefaultsManager.setModel(model: updatedBillList,
                                     key: .bills)
    }

    func isValidData(name: String, date: String, value: String) -> Bool {
        isValidDate(date: date) && isValidName(name: name) && isValidValue(value: value)
    }

    // MARK: - Private Methods

    private func isValidValue(value: String) -> Bool {
        Double(value) != nil
    }

    private func appendBillOnList(bill: DoubtModel) -> [DoubtModel] {
        var billCardList = UserDefaultsManager().getModel(model: [DoubtModel].self,
                                                          key: .bills) ?? []
        billCardList.append(bill)
        return billCardList
    }

    private func isValidDate(date: String) -> Bool {
        date.isValidDayOfMounth()
    }

    private func isValidName(name: String) -> Bool {
        name != .empty
    }
}
