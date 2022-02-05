//
//  HomeViewController.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import UIKit

class HomeViewController: BaseViewController {

    // MARK: - Storyboard Outlets

    @IBOutlet weak var addDoubtButton: UIButton!
    @IBOutlet weak var positiveBalance: UILabel!
    @IBOutlet weak var negativeBalance: UILabel!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Properties

    private func setupUI() {
        addDoubtButton.layer.cornerRadius = addDoubtButton.frame.size.width/2
    }

    // MARK: - Storyboard Actions
    
    @IBAction func addDoubtButtonTapped(_ sender: Any) {
    }
}
