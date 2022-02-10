//
//  DoubtRegisterViewController.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 08/02/22.
//

import Foundation
import UIKit

class DoubtRegisterController: BaseViewController {

    // MARK: - Storyboard Outlets

    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var doubtNameTextField: UITextField!
    @IBOutlet weak var selectCategoryTextField: UITextField!
    @IBOutlet weak var selectDateTextField: UITextField!
    @IBOutlet weak var selectCardTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!

    // MARK: - Constants

    private let kKeyboardDoneButtonTitle = "selecionar"

    // MARK: - Private Properties

    private var datePickerView = UIDatePicker()
    private var categoryPickerView = UIPickerView()
    private var cardPickerView = UIPickerView()
    private let viewModel = DoubtRegisterViewModel()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardNotifications()
        setupPickerViews()
        setupTextFields()
        setupLabels()
    }

    // MARK: - Private Methods

    private func setupLabels() {
        selectCardTextField.text = viewModel.cardPickerContent.first
        selectCategoryTextField.text = viewModel.categoryPickerContent.first
        selectDateTextField.text = Date.now.toString()
    }

    private func setupPickerViews() {
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self

        cardPickerView.dataSource = self
        cardPickerView.delegate = self

        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.locale = Locale(identifier: "pt_BR")
        datePickerView.maximumDate = .now
        datePickerView.minimumDate = .distantPast
        datePickerView.datePickerMode = .date
        datePickerView.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
    }

    @objc private func handleDatePicker() {
        selectDateTextField.text = datePickerView.date.toString()
    }

    private func setupTextFields() {
        selectCardTextField.addDoneButtonOnKeyboard(title: kKeyboardDoneButtonTitle)
        selectCategoryTextField.addDoneButtonOnKeyboard(title: kKeyboardDoneButtonTitle)
        selectDateTextField.addDoneButtonOnKeyboard(title: kKeyboardDoneButtonTitle)

        selectCardTextField.inputView = cardPickerView
        selectCategoryTextField.inputView = categoryPickerView
        selectDateTextField.inputView = datePickerView

        selectCardTextField.keyboardAppearance = .dark
        selectCategoryTextField.keyboardAppearance = .dark
        selectDateTextField.keyboardAppearance = .dark
    }

    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = view.convert(keyboardFrame.cgRectValue, from: nil).size.height
        scrollView.contentInset.bottom = keyboardHeight + 20
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
        scrollView.setContentOffset(.zero, animated: true)
    }

    // MARK: - Storyboard Actions

    @IBAction func continueButtonDidTapped(_ sender: Any) {
    }
}

// MARK: - DatePicker

// MARK: - PickerView Delegate

extension DoubtRegisterController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case cardPickerView:
            selectCardTextField.text = viewModel.cardPickerContent[row]
        case categoryPickerView:
            selectCategoryTextField.text = viewModel.categoryPickerContent[row]
        default:
            return
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case cardPickerView:
            return viewModel.cardPickerContent[row]
        case categoryPickerView:
            return viewModel.categoryPickerContent[row]
        default:
            return .empty
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case cardPickerView:
            return viewModel.cardPickerContent.count
        case categoryPickerView:
            return viewModel.categoryPickerContent.count
        default:
            return 0
        }
    }
}
