//
//  DoubtRegisterViewModel.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 10/02/22.
//

import Foundation

class DoubtRegisterViewModel {


    // MARK: - Public Properties

    var categoryPickerContent: [String] {
        var categoriesList: [String] = []
        for category in allCategories {
            categoriesList.append(category.name)
        }
        return categoriesList
    }

    var cardPickerContent: [String] {
        var cardList: [String] = []
        for card in allCards {
            cardList.append(card.name)
        }
        return cardList
    }

    // MARK: - Private Properties

    private let userDefaultsManager = UserDefaultsManager()

    private var allCards: [CreditCardModel] {
        userDefaultsManager.getModel(model: [CreditCardModel].self,
                                     key: .creditCards) ?? []
    }

    private var allCategories: [DoubtCategoryModel] {
        userDefaultsManager.getModel(model: [DoubtCategoryModel].self,
                                     key: .categories) ?? []
    }
}
