//
//  HomeViewModel.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 05/02/22.
//

import Foundation

class HomeViewModel {

    // MARK: - Life Cycle

    init() {
        allCategories.insert(DoubtCategoryModel(name: "Todos",
                                                icon: "todos"), at: 0)

        allCategories.append(DoubtCategoryModel(name: "Add",
                                                icon: "add"))
    }

    // MARK: - Private Properties

    private let userDefaultsManager = UserDefaultsManager()
    private var allCategories: [DoubtCategoryModel] = [
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

    // MARK: - Public Methods

    func selectCategory(position: Int) {
        diselectAll()
        allCategories[position].isSelected = true
    }

    func getCategoryByPosition(position: Int) -> DoubtCategoryModel {
        allCategories[position]
    }

    var categoriesCount: Int {
        allCategories.count
    }

    var currentBalance: String {
        userDefaultsManager.get(key: .currentBalance).toCurrency()
    }

    var currentNegativeBalance: String {
        let totalDoubt = creditCardsTotalDoubt + totalBills
        let stringTotalDoubt = String(totalDoubt)
        return stringTotalDoubt.toCurrency()
    }

    func recieveSalary() {
        var currentBalance = Double(userDefaultsManager.get(key: .currentBalance)) ?? 0
        currentBalance += currentSalary?.value ?? 0
        userDefaultsManager.set(value: currentBalance as AnyObject,
                                key: .currentBalance)
    }

    // MARK: - Private Methods

    private func diselectAll() {
        for (i, _) in allCategories.enumerated() {
            allCategories[i].isSelected = false
        }
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
