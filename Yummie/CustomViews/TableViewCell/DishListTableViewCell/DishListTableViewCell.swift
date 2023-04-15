//
//  DishListTableViewCell.swift
//  Yummie
//
//  Created by Christian Calixto on 15/4/23.
//

import UIKit

class DishListTableViewCell: UITableViewCell {

    public static let indentifier = String(describing: DishListTableViewCell.self)

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!

    func setup(dish: Dish) {
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
    }

    func setup(order: Order) {
        dishImageView.kf.setImage(with: order.dish?.image?.asUrl)
        titleLbl.text = order.dish?.name
        descriptionLbl.text = order.dish?.description
    }
}
