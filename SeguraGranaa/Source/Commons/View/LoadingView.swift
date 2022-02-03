//
//  LoadingView.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import UIKit

class LoadingView: UIView {

    // MARK: - Private Properties

    private let activityIndicator = UIActivityIndicatorView()
    private let transparentView = UIView(frame: UIScreen.main.bounds)

    // MARK: - Life Cycle

    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
        setupIndicatorView()
    }

    // MARK: - Public Methods

    func showLoading() {
        let isLoadingShowing = subviews.contains(activityIndicator)

        if !isLoadingShowing {
            addSubview(activityIndicator)
        }
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.addSubview(self)
        }
        activityIndicator.startAnimating()
    }

    func hideLoading() {
        DispatchQueue.main.async {
            self.removeFromSuperview()
        }
    }

    // MARK: - Private Methods

    private func setupIndicatorView() {
        activityIndicator.hidesWhenStopped = true
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        activityIndicator.style = UIActivityIndicatorView.Style.medium
    }

    private func setupLayout() {
        frame = UIScreen.main.bounds
        activityIndicator.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
    }
}
