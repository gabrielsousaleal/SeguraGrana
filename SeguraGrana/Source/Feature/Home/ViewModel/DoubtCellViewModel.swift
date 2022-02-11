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
    private let card: CreditCardModel?

    // MARK: - Life Cycle

    init(doubt: DoubtModel, card: CreditCardModel?) {
        self.doubt = doubt
        self.card = card
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
        card?.name ?? "conta mensal"
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
