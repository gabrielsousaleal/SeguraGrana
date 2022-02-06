//
//  ValueInAccount.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 06/02/22.
//

import Foundation
import UIKit

class ValueInAccountViewController: BaseViewController {

    // MARK: - Storyboard Outlets

    @IBOutlet private weak var valueTextField: UITextField!
    @IBOutlet private weak var continueButton: UIButton!

    // MARK: - Private Properties

    private let viewModel = ValueInAccountViewModel()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        setupContinueButton(enabled: false)
        valueTextField.delegate = self
        valueTextField.keyboardType = .decimalPad
        valueTextField.keyboardAppearance = .dark
    }

    private func setupContinueButton(enabled: Bool) {
        continueButton.isEnabled = enabled
    }

    // MARK: - Storyboard Actions

    @IBAction func continueButtonDidTapped(_ sender: Any) {
        UserDefaultsManager().set(value: true as AnyObject,
                                  key: .didOnboard)
        viewModel.addValueToBalance(value: valueTextField.text ?? .empty)
        HomeCoordinator().start(navigationController: navigationController)
    }
}

extension ValueInAccountViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isValidValue = viewModel.isValidValue(value: textField.text ?? .empty)
        setupContinueButton(enabled: isValidValue)
    }
}
