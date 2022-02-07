//
//  RegisterCreditCardViewController.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import Foundation
import UIKit

class BillRegisterViewController: BaseViewController {
    
    // MARK: - Storyboard Outlets

    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var deadendTextField: UITextField!

    // MARK: - Private Properties

    private let viewModel = BillRegisterViewModel()
    weak var homeDelegate: HomeViewControllerDelegate?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Public Methods

    func setup(delegate: HomeViewControllerDelegate?) {
        self.homeDelegate = delegate
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

        valueTextField.delegate = self
        deadendTextField.keyboardType = .decimalPad
        deadendTextField.keyboardAppearance = .dark
    }

    // MARK: - Storyboard Actions

    @IBAction func continueButtonDidTapped(_ sender: Any) {
        viewModel.saveBill(name: nameTextField.text ?? .empty,
                           deadend: deadendTextField.text ?? .empty,
                           value: valueTextField.text ?? .empty)
        dismiss(animated: true) {
            self.homeDelegate?.setupLabels()
            self.homeDelegate?.reloadTableViewData()
        }
    }
}

// MARK: - Textfield Delegate

extension BillRegisterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let isBackspace = string.isBackSpace()
        let isDeadEndTextField = textField === deadendTextField
        if isBackspace || !isDeadEndTextField { return true }

        let futureText = (textField.text ?? .empty) + string
        return futureText.isValidDayOfMounth()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        setupContinueButton(
            enabled: viewModel.isValidData(name: nameTextField.text ?? .empty,
                                           date: deadendTextField.text ?? .empty,
                                           value: valueTextField.text ?? .empty)
        )
    }
}
