//
//  RegisterCreditCardCoordinator.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import UIKit

class ValueInAccountCoordinator {
    // MARK: - Constants

    private let kStoryboardName = "ValueInAccount"
}

// MARK: - Coordinator Implementation

extension ValueInAccountCoordinator: BaseCoordinator {
    func start(navigationController: UINavigationController?) {
        let storyboard = UIStoryboard(name: kStoryboardName, bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() as? ValueInAccountViewController else {
            return
        }
        DispatchQueue.main.async {
            navigationController?.pushViewController(controller,
                                                     animated: true)
        }
    }
}

