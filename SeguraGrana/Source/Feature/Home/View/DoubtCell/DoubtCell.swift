//
//  DoubtCell.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 10/02/22.
//

import Foundation
import UIKit

class DoubtCell: UITableViewCell {

    // MARK: - Storyboard Outlets

    @IBOutlet private weak var doubtDateLabel: UILabel!
    @IBOutlet private weak var doubtNameLabel: UILabel!
    @IBOutlet private weak var doubtValueLabel: UILabel!
    @IBOutlet private weak var doubtCardLabel: UILabel!
    @IBOutlet private weak var doubtPaydayLabel: UILabel!
    @IBOutlet private weak var doubtCategoryLabel: UILabel!

    // MARK: - Private Properties

    private var viewModel: DoubtCellViewModel?

    // MARK: - Public Methods

    func setup(doubt: DoubtModel, card: CreditCardModel?) {
        self.viewModel = DoubtCellViewModel(doubt: doubt, card: card)
        setupLabels()
    }

    // MARK: - Private Methods

    private func setupLabels() {
        doubtDateLabel.text = viewModel?.doubtDate
        doubtNameLabel.text = viewModel?.doubtName
        doubtValueLabel.text = viewModel?.doubtValue
        doubtCardLabel.text = viewModel?.doubtCardName
        doubtPaydayLabel.text = viewModel?.doubtPayday
        doubtCategoryLabel.text = viewModel?.category
    }
}
