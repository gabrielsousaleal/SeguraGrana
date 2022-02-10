//
//  RegisterCreditCardCoordinator.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import UIKit

class DoubtRegisterCoordinator {
    // MARK: - Constants

    private let kStoryboardName = "DoubtRegister"
}

// MARK: - Coordinator Implementation

extension DoubtRegisterCoordinator: BaseCoordinator {
    func start(navigationController: UINavigationController?) {
        let storyboard = UIStoryboard(name: kStoryboardName, bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() as? DoubtRegisterController else {
            return
        }
        DispatchQueue.main.async {
            navigationController?.present(controller,
                                          animated: true)
        }
    }
}
