//
//  ListDishesViewController.swift
//  Yummie
//
//  Created by Christian Calixto on 15/4/23.
//

import UIKit
import ProgressHUD

class ListDishesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: DishListTableViewCell.indentifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.indentifier)
        }
    }

    private var category: DishCategory?

    private var dishes = [Dish]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = category?.name

        ProgressHUD.show()
        NetworkService.shared.fetchCategoryDishes(categoryId: category?.id ?? "") { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(dishes):
                ProgressHUD.dismiss()
                self.dishes = dishes
                self.tableView.reloadData()
            case let .failure(error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }

    public func setup(category: DishCategory) {
        self.category = category
    }

}

extension ListDishesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dishes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.indentifier) as? DishListTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(dish: dishes[indexPath.row])
        return cell
    }


}

extension ListDishesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishDetailViewController.instantiate()
        controller.setup(dish: dishes[indexPath.row])
        navigationController?.pushViewController(controller, animated: true)
    }
}
