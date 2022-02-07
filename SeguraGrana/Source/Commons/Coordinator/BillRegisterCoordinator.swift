//
//  RegisterCreditCardCoordinator.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import UIKit

class BillRegisterCoordinator {
    // MARK: - Constants

    private let kStoryboardName = "BillRegister"
}

// MARK: - Coordinator Implementation

extension BillRegisterCoordinator: BaseCoordinator {
    func start(navigationController: UINavigationController?, delegate: HomeViewControllerDelegate?) {
        let storyboard = UIStoryboard(name: kStoryboardName, bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() as? BillRegisterViewController else {
            return
        }
        controller.setup(delegate: delegate)
        DispatchQueue.main.async {
            navigationController?.present(controller,
                                          animated: true)
        }
    }
}
