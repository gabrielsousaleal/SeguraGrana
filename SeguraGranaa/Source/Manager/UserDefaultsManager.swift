//
//  UserDefaultsManager.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import Foundation

class UserDefaultsManager {

    // MARK: - Private Properties

    private let userDefaults = UserDefaults.standard

    // MARK: - Public Methods

    func set(value: AnyObject, key: UserDefaultsKey) {
        userDefaults.set(value, forKey: key.rawValue)
        userDefaults.synchronize()
    }

    func get(key: UserDefaultsKey) -> String {
        userDefaults.string(forKey: key.rawValue) ?? .empty
    }

    func saveCreditCard(creditCard: CreditCardModel) {
        var creditCards = getCreditCards()
        creditCards.append(creditCard)
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(creditCards)
            set(value: data as AnyObject, key: .creditCards)
        } catch {}
    }

    func getCreditCards() -> [CreditCardModel] {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultsKey.creditCards.rawValue) else { return [] }
        do {
            let decoder = JSONDecoder()
            let creditCards = try decoder.decode([CreditCardModel].self, from: data)
            return creditCards
        } catch {
            return []
        }
    }
}
