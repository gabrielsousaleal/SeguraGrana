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

    // MARK: - Private Properties

    private let viewModel = HomeViewModel()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLabels()
        viewModel.recieveSalary()
    }

    // MARK: - Private Properties

    private func setupUI() {
        addDoubtButton.layer.cornerRadius = addDoubtButton.frame.size.width/2
    }

    private func setupLabels() {
        positiveBalance.text = viewModel.currentBalance
        negativeBalance.text = viewModel.currentNegativeBalance
    }

    // MARK: - Storyboard Actions
    
    @IBAction func addDoubtButtonTapped(_ sender: Any) {
    }
}
