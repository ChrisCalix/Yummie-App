//
//  ListDishesViewController.swift
//  Yummie
//
//  Created by Christian Calixto on 15/4/23.
//

import UIKit

class ListDishesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: DishListTableViewCell.indentifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.indentifier)
        }
    }

    private var category: DishCategory?

    private var dishes : [Dish] =  [
        .init(id: "id1", name: "Garri", description: "This is the best I have ever tasted", image: "https://picsum.photos/100/200", calories: 34),
        .init(id: "id1", name: "Indomie", description: "This is the best I have ever tasted This is the best I have ever tasted, This is the best I have ever tasted. This is the best I have ever tasted,This is the best I have ever tasted This is the best I have ever tasted. This is the best I have ever tasted, This is the best I have ever tasted: This is the best I have ever tasted", image: "https://picsum.photos/100/200", calories: 324),
        .init(id: "id1", name: "Pizza", description: "This is the best I have ever tasted", image: "https://picsum.photos/100/200", calories: 1004),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = category?.name
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
