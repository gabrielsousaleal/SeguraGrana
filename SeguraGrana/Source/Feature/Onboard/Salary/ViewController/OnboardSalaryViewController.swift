//
//  OnboardSalaryViewController.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import Foundation
import UIKit

class OnboardSalaryViewController: BaseViewController {

    // MARK: - Storyboard Outlets

    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!

    // MARK: - Private Properties

    private let viewModel = OnboardSalaryViewModel()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        setupSalaryTextField()
        setupContinueButton(enabled: false)
    }

    private func setupContinueButton(enabled: Bool) {
        continueButton.isEnabled = enabled
    }

    private func setupSalaryTextField() {
        salaryTextField.delegate = self
        salaryTextField.keyboardType = .decimalPad
        salaryTextField.becomeFirstResponder()
    }

    private func changeContinueButtonState(enableButton: Bool) {
        continueButton.isEnabled = enableButton
        continueButton.alpha = viewModel.getContinueButtonAlpha(isEnabled: enableButton)
    }

    // MARK: - Storyboard Actions

    @IBAction func textFieldEndEditing(_ sender: Any) {
    }

    @IBAction func continueButtonDidTapped(_ sender: Any) {
        let currentSalary = salaryTextField.text ?? .empty
        viewModel.setSalary(value: currentSalary)
        RegisterCreditCardCoordinator().start(navigationController: navigationController)
    }
}

// MARK: - Textfield Delegate

extension OnboardSalaryViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isValidSalary = viewModel.isValidSalary(value: textField.text ?? .empty)
        changeContinueButtonState(enableButton: isValidSalary)
    }
}
