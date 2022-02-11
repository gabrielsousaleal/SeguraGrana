//
//  UIView+.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 11/02/22.
//

import Foundation
import UIKit

extension UIView {
    func circle() {
        layer.cornerRadius = frame.size.width/2
        clipsToBounds = true
    }
}
