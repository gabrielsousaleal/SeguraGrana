//
//  BaseViewController.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Private Properties

    private var loadingView = LoadingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(closeKeyboardWhenTapOutside))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }

    // MARK: - Private Methods

    @objc func closeKeyboardWhenTapOutside() {
        view.endEditing(true)
    }

    // MARK: - Public Methods

    func showLoading() {
        view.addSubview(loadingView)
        loadingView.showLoading()
    }

    func hideLoading() {
        loadingView.hideLoading()
    }
}
