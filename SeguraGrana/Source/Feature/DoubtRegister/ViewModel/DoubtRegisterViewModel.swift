//
//  DoubtRegisterViewModel.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 10/02/22.
//

import Foundation

class DoubtRegisterViewModel {

    // MARK: - Private Properties

    private weak var homeDelegate: HomeViewControllerDelegate?

    init(homeDelegate: HomeViewControllerDelegate) {
        self.homeDelegate = homeDelegate
    }

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

    // MARK: - Public Methods

    func saveDoubt(name: String, value: String, date: Date, creditCardName: String, category: String) {
        let category = DoubtCategoryModel(name: category, icon: category)
        guard var creditCard = getCardByName(name: creditCardName) else { return }
    
        let doubt = DoubtModel(value: Double(value) ?? 0,
                               name: name,
                               category: category,
                               isReccurent: false,
                               deadline: creditCard.deadline,
                               date: date,
                               creditCard: creditCard)
        creditCard.doubts.append(doubt)
        updateCreditCards(newCard: creditCard)
        homeDelegate?.reloadTableViewData()
    }

    func validadeData(name: String, value: String) -> Bool {
        name != .empty && Double(value) != nil
    }

    // MARK: - Private Properties

    private let userDefaultsManager = UserDefaultsManager()

    private func updateCreditCards(newCard: CreditCardModel) {
        var allCards = self.allCards
        allCards.removeAll { $0.name == newCard.name }
        allCards.append(newCard)
        userDefaultsManager.setModel(model: allCards,
                                     key: .creditCards)
    }

    private func getCardByName(name: String) -> CreditCardModel? {
        allCards.first { $0.name == name }
    }

    private var allCards: [CreditCardModel] {
        userDefaultsManager.getModel(model: [CreditCardModel].self,
                                     key: .creditCards) ?? []
    }

    private var allCategories: [DoubtCategoryModel] {
        var allCategories = userDefaultsManager.getModel(model: [DoubtCategoryModel].self,
                                                         key: .categories) ?? []
        allCategories.removeAll { $0.name == "Contas" }
        return allCategories
    }
}
