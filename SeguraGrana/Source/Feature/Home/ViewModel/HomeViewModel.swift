//
//  HomeViewModel.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 05/02/22.
//

import Foundation

class HomeViewModel {

    // MARK: - Private Properties

    private let userDefaultsManager = UserDefaultsManager()
    private var defaultDoubtCategories: [DoubtCategoryModel] {
        [
            DoubtCategoryModel(name: "Saúde",
                               icon: "health"),
            DoubtCategoryModel(name: "Lazer",
                               icon: "play"),
            DoubtCategoryModel(name: "Mercado",
                               icon: "market"),
            DoubtCategoryModel(name: "Uber",
                               icon: "uber"),
            DoubtCategoryModel(name: "Carro",
                               icon: "car"),
            DoubtCategoryModel(name: "Casa",
                               icon: "house")
        ]
    }

    // MARK: - Public Methods

    var currentBalance: String {
        userDefaultsManager.get(key: .currentBalance).toCurrency()
    }

    var currentNegativeBalance: String {
        let totalDoubt = creditCardsTotalDoubt + totalBills
        let stringTotalDoubt = String(totalDoubt)
        return stringTotalDoubt.toCurrency()
    }

    func recieveSalary() {
        if !isPayday { return }
        if hasRecievedSalary { return }
        var currentBalance = Double(userDefaultsManager.get(key: .currentBalance)) ?? 0
        currentBalance += currentSalary?.value ?? 0
        userDefaultsManager.set(value: currentBalance as AnyObject,
                                key: .currentBalance)
        userDefaultsManager.set(value: true as AnyObject,
                                key: .salaryRecieved)
    }

    // MARK: - Private Methods

    private var hasRecievedSalary: Bool {
        let hasRecievedSalaryString = userDefaultsManager.get(key: .salaryRecieved)
        let hasRecievedSalaryBool = hasRecievedSalaryString == "0"
        return hasRecievedSalaryBool
    }

    private var isPayday: Bool {
        let currentDay = Date().get(.day)
        let payday = Int(currentSalary?.payday ?? .empty) ?? 0
        let isPayday = currentDay >= payday
        return isPayday
    }

    private var currentSalary: SalaryModel? {
        userDefaultsManager.getModel(model: SalaryModel.self,
                                     key: .salary)
    }

    private var totalBills: Double {
        let bills = userDefaultsManager.getModel(model: [DoubtModel].self,
                                                 key: .bills) ?? []
        var total: Double = 0
        for bill in bills {
            total += bill.value
        }
        return total
    }

    private var creditCardsDoubts: [Double] {
        var creditCardsDoubts: [Double] = []
        for creditCard in creditCards {
            for doubt in creditCard.doubts {
                creditCardsDoubts.append(doubt.value)
            }
        }
        return creditCardsDoubts
    }

    private var creditCardsTotalDoubt: Double {
        var totalDoubt: Double = 0
        for doubt in creditCardsDoubts {
            totalDoubt += doubt
        }
        return totalDoubt
    }

    private var creditCards: [CreditCardModel] {
        userDefaultsManager.getModel(model: [CreditCardModel].self,
                                     key: .creditCards) ?? []
    }
}
