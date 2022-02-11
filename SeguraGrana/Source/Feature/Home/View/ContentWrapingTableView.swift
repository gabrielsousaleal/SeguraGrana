//
//  ContentWrapingTableView.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 10/02/22.
//

import Foundation
import UIKit

class ContentWrappingTableView: UITableView {
  override var intrinsicContentSize: CGSize {
    return self.contentSize
  }

  override var contentSize: CGSize {
    didSet {
        self.invalidateIntrinsicContentSize()
    }
  }
}
