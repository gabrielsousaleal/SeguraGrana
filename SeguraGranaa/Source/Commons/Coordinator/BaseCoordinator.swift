//
//  BaseCoordinator.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import UIKit

@objc
protocol BaseCoordinator: AnyObject {
    @objc
    optional func start(navigationController: UINavigationController?)
}
