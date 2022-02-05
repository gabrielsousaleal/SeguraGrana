//
//  UINavigationController+.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import UIKit

extension UINavigationController {
    func clearNavigation() {
        navigationBar.tintColor = .systemGreen
        navigationBar.topItem?.title = .empty
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
}
