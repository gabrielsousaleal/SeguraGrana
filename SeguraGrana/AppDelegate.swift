//
//  AppDelegate.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Constants

    private let kHomeVCName = "Home"
    private let kSalaryVCName = "OnboardSalary"

    // MARK: - Private Properties

    private let userDefaultsManager = UserDefaultsManager()

    // MARK: - Public Properties

    var window: UIWindow?

    // MARK: - Life Cycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        callInitialViewController()
        return true
    }

    // MARK: - Private Methods

    private func callInitialViewController() {
        let didOnboard = userDefaultsManager.get(key: .didOnboard) == "1"
        guard let homeVC = UIStoryboard(
            name: kHomeVCName,
            bundle: nil
        ).instantiateInitialViewController() as? HomeViewController,
              let salaryVC = UIStoryboard(
                name: kSalaryVCName,
                bundle: nil
              ).instantiateViewController(withIdentifier: kSalaryVCName) as? OnboardSalaryViewController
        else { return }
        let selectedVC = didOnboard ? homeVC : salaryVC
        let navigationController = BaseNavigationController(rootViewController: selectedVC)
        navigationController.clearNavigation()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

