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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationAppearance()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(closeKeyboardWhenTapOutside))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }

    // MARK: - Private Methods

    private func setupNavigationAppearance() {
        navigationController?.navigationBar.topItem?.title = title
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        for view in self.navigationController?.navigationBar.subviews ?? [] {
             let subviews = view.subviews
             if subviews.count > 0, let label = subviews[0] as? UILabel {
                 label.textColor = .white
             }
        }
    }

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
