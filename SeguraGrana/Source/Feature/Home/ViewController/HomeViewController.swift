//
//  HomeViewController.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func reloadTableViewData()
}

class HomeViewController: BaseViewController {

    // MARK: - Storyboard Outlets

    @IBOutlet weak var addDoubtButton: UIButton!
    @IBOutlet weak var positiveBalance: UILabel!
    @IBOutlet weak var negativeBalance: UILabel!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!

    // MARK: - Constants

    private let kCategoryCellIdentifier = "CategoryCollectionViewCell"

    // MARK: - Private Properties

    private let viewModel = HomeViewModel()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLabels()
        setupElements()
    }

    // MARK: - Private Properties

    private func showDoubtRegisterAlert() {
        let alert = UIAlertController(title: "Cadastrar nova dívida",
                                      message: "que tipo de dívida você quer cadastrar?",
                                      preferredStyle: .actionSheet)
        let card = UIAlertAction(title: "cartão", style: .default) { _ in
        }
        let bill = UIAlertAction(title: "conta", style: .default) { _ in
            BillRegisterCoordinator().start(navigationController: self.navigationController,
                                            delegate: self)
        }
        let cancel = UIAlertAction(title: "cancelar", style: .cancel) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(card)
        alert.addAction(bill)
        alert.addAction(cancel)
        present(alert, animated: true)
    }

    private func setupElements() {
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.register(UINib(nibName: kCategoryCellIdentifier, bundle: nil), forCellWithReuseIdentifier: kCategoryCellIdentifier)

    }

    private func setupUI() {
        addDoubtButton.layer.cornerRadius = addDoubtButton.frame.size.width/2
    }

    private func setupLabels() {
        positiveBalance.text = viewModel.currentBalance
        negativeBalance.text = viewModel.currentNegativeBalance
    }

    // MARK: - Storyboard Actions
    
    @IBAction func recieveSalary(_ sender: Any) {
        let alert = UIAlertController(title: "Receber salário?",
                                      message: "você já recebeu o salário desse mês?",
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "não", style: .cancel) { _ in
            alert.dismiss(animated: true)
        }
        let confirmAction = UIAlertAction(title: "sim", style: .default) { _ in
            self.viewModel.recieveSalary()
            self.setupLabels()
        }
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }

    @IBAction func addDoubtButtonTapped(_ sender: Any) {
        showDoubtRegisterAlert()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.categoriesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCategoryCellIdentifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        let category = viewModel.getCategoryByPosition(position: indexPath.row)
        cell.setup(model: category)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectCategory(position: indexPath.row)
        collectionView.reloadData()
    }
}

extension HomeViewController: HomeViewControllerDelegate {
    func reloadTableViewData() {
        print(viewModel.getBillByPosition(position: 0))
        print(viewModel.billsCount)
    }
}
