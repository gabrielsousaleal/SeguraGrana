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

    func setModel<T: Codable>(model: T, key: UserDefaultsKey) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(model)
            set(value: data as AnyObject, key: key)
        } catch {}
    }

    func getModel<T: Codable>(model: T.Type, key: UserDefaultsKey) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key.rawValue) else { return nil }
        do {
            let decoder = JSONDecoder()
            let creditCards = try decoder.decode(T.self, from: data)
            return creditCards
        } catch {
            return nil
        }
    }
}
