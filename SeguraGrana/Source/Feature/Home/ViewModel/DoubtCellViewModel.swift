//
//  DoubtCellViewModel.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 10/02/22.
//

import Foundation

class DoubtCellViewModel{

    // MARK: - Private Properties

    private let doubt: DoubtModel

    // MARK: - Life Cycle

    init(doubt: DoubtModel) {
        self.doubt = doubt
    }

    // MARK: - Public Methods

    var doubtName: String {
        doubt.name
    }

    var doubtValue: String {
        let valueString = String(doubt.value)
        return valueString.toCurrency()
    }

    var doubtDate: String {
        doubt.date?.toString() ?? .empty
    }

    var doubtCardName: String {
        let cardName = doubt.creditCard?.name ?? .empty
        if cardName.isEmpty { return "conta mensal" }
        let format = "cartão %@"
        return String(format: format, cardName)
    }

    var doubtPayday: String {
        let format = "dia de pagamento %@"
        let paydayString = String(doubt.deadline)
        return String(format: format, paydayString)
    }

    var category: String {
        doubt.category.name.lowercased()
    }
}
