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

    // MARK: - Public Properties

    var window: UIWindow?

    // MARK: - Public Methods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        callInitialViewController()
        return true
    }

    // MARK: - Private Methods

    private func callInitialViewController() {
        let userDefaultsManager = UserDefaultsManager()
        let didOnboard = userDefaultsManager.get(key: .didOnboard) != .empty
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
        let navigationController = UINavigationController(rootViewController: selectedVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

