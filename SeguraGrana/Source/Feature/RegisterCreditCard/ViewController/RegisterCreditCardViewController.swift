//
//  RegisterCreditCardViewController.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import Foundation
import UIKit

class RegisterCreditCardViewController: BaseViewController {
    
    // MARK: - Storyboard Outlets

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var deadendTextField: UITextField!

    // MARK: - Private Properties

    private let viewModel = RegisterCreditCardViewModel()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Properties

    private func setupUI() {
        setupSalaryTextField()
        setupContinueButton(enabled: false)
    }

    private func setupContinueButton(enabled: Bool) {
        continueButton.isEnabled = enabled
    }

    private func setupSalaryTextField() {
        nameTextField.delegate = self
        nameTextField.keyboardAppearance = .dark

        deadendTextField.delegate = self
        deadendTextField.keyboardType = .numberPad
        deadendTextField.keyboardAppearance = .dark
    }

    // MARK: - Storyboard Actions

    @IBAction func continueButtonDidTapped(_ sender: Any) {
        viewModel.saveCreditCard(name: nameTextField.text ?? .empty,
                                 deadend: deadendTextField.text ?? .empty)
        ValueInAccountCoordinator().start(navigationController: navigationController)
    }
}

// MARK: - Textfield Delegate

extension RegisterCreditCardViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let isBackspace = string.isBackSpace()
        let isNameTextField = textField === nameTextField
        if isBackspace || isNameTextField { return true }

        let futureText = (textField.text ?? .empty) + string
        return futureText.isValidDayOfMounth()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        setupContinueButton(
            enabled: viewModel.isValidData(name: nameTextField.text ?? .empty,
                                           date: deadendTextField.text ?? .empty)
        )
    }
}
