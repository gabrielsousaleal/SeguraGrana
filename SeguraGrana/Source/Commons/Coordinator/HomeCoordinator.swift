//
//  RegisterCreditCardCoordinator.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import UIKit

class HomeCoordinator {
    // MARK: - Constants

    private let kStoryboardName = "Home"
}

// MARK: - Coordinator Implementation

extension HomeCoordinator: BaseCoordinator {
    func start(navigationController: UINavigationController?) {
        let storyboard = UIStoryboard(name: kStoryboardName, bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() as? HomeViewController else {
            return
        }
        let newNavigationController = BaseNavigationController(rootViewController: controller)
        newNavigationController.modalPresentationStyle = .fullScreen
        newNavigationController.clearNavigation()
        navigationController?.present(newNavigationController,
                                      animated: true)
    }
}

