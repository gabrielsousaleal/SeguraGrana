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
    @IBOutlet weak var paydayTextField: UITextField!
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
        paydayTextField.delegate = self
        paydayTextField.keyboardType = .numberPad
        salaryTextField.keyboardType = .decimalPad
        salaryTextField.keyboardAppearance = .dark
        paydayTextField.keyboardAppearance = .dark
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
        let currentPayday = paydayTextField.text ?? .empty
        viewModel.setSalary(value: currentSalary,
                            payday: currentPayday)
        RegisterCreditCardCoordinator().start(navigationController: navigationController)
    }
}

// MARK: - Textfield Delegate

extension OnboardSalaryViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let isBackspace = string.isBackSpace()
        let isSalaryTextfield = textField === salaryTextField
        if isBackspace || isSalaryTextfield { return true }

        if textField.text?.count == 2 {
            return false
        }

        let futureText = (textField.text ?? .empty) + string
        return viewModel.isValidPayDay(value: futureText)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        let isValidSalary = viewModel.isValidData(salary: salaryTextField.text ?? .empty,
                                                  payday: paydayTextField.text ?? .empty)
        changeContinueButtonState(enableButton: isValidSalary)
        DispatchQueue.main.async {
            self.setNeedsStatusBarAppearanceUpdate()

        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
