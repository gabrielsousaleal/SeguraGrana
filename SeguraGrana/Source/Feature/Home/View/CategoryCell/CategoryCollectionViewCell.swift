//
//  CategoryCollectionViewCell.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 06/02/22.
//

import Foundation
import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    // MARK: - Storyboard Outlets

    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Private Properties

    override func layoutSubviews() {
        super.layoutSubviews()
        
        changeState(select: model?.isSelected ?? false)
    }

    private var model: DoubtCategoryModel?

    func setup(model: DoubtCategoryModel) {
        self.model = model
        setupLabels()
        setupUI()
    }

    // MARK: - Private Properties

    private func changeState(select: Bool) {
        let color = select ? UIColor.systemGreen : UIColor.clear
        backGroundView?.backgroundColor = color
    }

    private func setupUI() {
        backGroundView.layer.cornerRadius = 8
        backGroundView.backgroundColor = .clear
    }

    private func setupLabels() {
        nameLabel.text = model?.name
    }
}
