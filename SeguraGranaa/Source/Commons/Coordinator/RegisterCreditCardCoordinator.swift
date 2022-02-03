//
//  RegisterCreditCardCoordinator.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import UIKit

class RegisterCreditCardCoordinator {
    // MARK: - Constants

    private let kStoryboardName = "RegisterCreditCard"
}

// MARK: - Coordinator Implementation

extension RegisterCreditCardCoordinator: BaseCoordinator {
    func start(navigationController: UINavigationController?) {
        let storyboard = UIStoryboard(name: kStoryboardName, bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() as? RegisterCreditCardViewController else {
            return
        }
        controller.navigationController?.clearNavigation()
        DispatchQueue.main.async {
            navigationController?.pushViewController(controller,
                                                     animated: true)
        }
    }
}
