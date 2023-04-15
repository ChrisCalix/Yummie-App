//
//  ListOrdersViewController.swift
//  Yummie
//
//  Created by Christian Calixto on 15/4/23.
//

import UIKit

class ListOrdersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: DishListTableViewCell.indentifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.indentifier)
        }
    }

    var orders: [Order] = [
        .init(id: "id", name: "Emmanuel Okinawa", dish: .init(id: "id1", name: "Garri", description: "This is the best I have ever tasted", image: "https://picsum.photos/100/200", calories: 34)),
        .init(id: "id", name: "Uzoc Okinawa", dish: .init(id: "id1", name: " Beans Garri", description: "This is the best I have ever tasted", image: "https://picsum.photos/100/200", calories: 34)),
        .init(id: "id", name: "David Okinawa", dish: .init(id: "id1", name: "Also", description: "This is the best I have ever tasted", image: "https://picsum.photos/100/200", calories: 34)),
        .init(id: "id", name: "Grace Okinawa", dish: .init(id: "id1", name: "Coiunt counted", description: "This is the best I have ever tasted", image: "https://picsum.photos/100/200", calories: 34)),
    ]


    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Orders"

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
