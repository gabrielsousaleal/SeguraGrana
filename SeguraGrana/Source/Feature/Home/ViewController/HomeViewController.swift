//
//  HomeViewController.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func reloadScreenData()
    func addNewCategory()
}

class HomeViewController: BaseViewController {

    // MARK: - Storyboard Outlets

    @IBOutlet weak var totalInCategory: UILabel!
    @IBOutlet weak var addDoubtButton: UIButton!
    @IBOutlet weak var positiveBalance: UILabel!
    @IBOutlet weak var negativeBalance: UILabel!
    @IBOutlet weak var doubtsTableView: ContentWrappingTableView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!

    // MARK: - Constants

    private let kCategoryCellIdentifier = "CategoryCollectionViewCell"
    private let kDoubtCellIdentifier = "DoubtCell"

    // MARK: - Private Properties

    private var viewModel: HomeViewModel!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel(delegate: self)
        setupUI()
        setupLabels()
        setupElements()
    }

    // MARK: - Private Properties

    private func setupLabels() {
        positiveBalance.text = viewModel.currentBalance
        negativeBalance.text = viewModel.currentNegativeBalance
        totalInCategory.text = viewModel.totalInCategory
    }

    private func showCategoryRegisterAlert() {
        let alert = UIAlertController(title: "Cadastrar categoria",
                                      message: "qual o nome da nova categoria?",
                                      preferredStyle: .alert)
        alert.addTextField { _ in }
        let save = UIAlertAction(title: "salvar", style: .default) { _ in
            let text = alert.textFields?[0].text ?? .empty
            self.viewModel.saveCategory(name: text)
            self.categoriesCollectionView.reloadData()
        }
        let cancel = UIAlertAction(title: "cancelar", style: .cancel) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(save)
        alert.addAction(cancel)
        present(alert, animated: true)
    }

    private func showDoubtRegisterAlert() {
        let alert = UIAlertController(title: "Cadastrar nova d??vida",
                                      message: "que tipo de d??vida voc?? quer cadastrar?",
                                      preferredStyle: .actionSheet)
        let card = UIAlertAction(title: "cart??o", style: .default) { _ in
            DoubtRegisterCoordinator(homeDelegate: self).start(navigationController: self.navigationController)
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
        categoriesCollectionView.register(
            UINib(
                nibName: kCategoryCellIdentifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: kCategoryCellIdentifier
        )
        doubtsTableView.register(
            UINib(
                nibName: kDoubtCellIdentifier,
                bundle: nil
            ), forCellReuseIdentifier: kDoubtCellIdentifier
        )

        doubtsTableView.delegate = self
        doubtsTableView.dataSource = self
    }

    private func setupUI() {
        addDoubtButton.circle()
    }

    // MARK: - Storyboard Actions
    
    @IBAction func recieveSalary(_ sender: Any) {
        let alert = UIAlertController(title: "Receber sal??rio?",
                                      message: "voc?? j?? recebeu o sal??rio desse m??s?",
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "n??o", style: .cancel) { _ in
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

// MARK: - CollectionView

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
        reloadScreenData()
    }
}

// MARK: - Controller Delegate

extension HomeViewController: HomeViewControllerDelegate {
    func reloadScreenData() {
        doubtsTableView.reloadData()
        categoriesCollectionView.reloadData()
        setupLabels()
    }

    func addNewCategory() {
        showCategoryRegisterAlert()
    }
}

// MARK: - TableView

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filtredDoubtsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kDoubtCellIdentifier) as? DoubtCell else { return UITableViewCell() }
        let doubt = viewModel.getDoubtByPosition(position: indexPath.row)
        cell.setup(doubt: doubt)
        return cell
    }
}
