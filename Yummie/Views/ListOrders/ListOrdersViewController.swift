//
//  ListOrdersViewController.swift
//  Yummie
//
//  Created by Christian Calixto on 15/4/23.
//

import UIKit
import ProgressHUD

class ListOrdersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: DishListTableViewCell.indentifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.indentifier)
        }
    }

    var orders = [Order]()


    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Orders"

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ProgressHUD.show()
        NetworkService.shared.fetchOrders { [weak self] result in
            guard let self else { return }
            switch result {
                case let .success(orders):
                    ProgressHUD.dismiss()
                    self.orders = orders
                    self.tableView.reloadData()
                case let .failure(error):
                    ProgressHUD.showError(error.localizedDescription)
            }

        }
    }

}

extension ListOrdersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.indentifier) as? DishListTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(order: orders[indexPath.row])
        return cell
    }
}

extension ListOrdersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dishOrdered = orders[indexPath.row].dish else {
            return
        }
        let controller = DishDetailViewController.instantiate()
        controller.setup(dish: dishOrdered)
        navigationController?.pushViewController(controller, animated: true)
    }
}
