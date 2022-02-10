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
    private var viewModel: DoubtRegisterViewModel?

    // MARK: - Life Cycle

    init(homeDelegate: HomeViewControllerDelegate) {
        self.viewModel = DoubtRegisterViewModel(homeDelegate: homeDelegate)
    }
}

// MARK: - Coordinator Implementation

extension DoubtRegisterCoordinator: BaseCoordinator {
    func start(navigationController: UINavigationController?) {
        let storyboard = UIStoryboard(name: kStoryboardName, bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() as? DoubtRegisterController else {
            return
        }
        controller.setup(viewModel: self.viewModel)
        DispatchQueue.main.async {
            navigationController?.present(controller,
                                          animated: true)
        }
    }
}
