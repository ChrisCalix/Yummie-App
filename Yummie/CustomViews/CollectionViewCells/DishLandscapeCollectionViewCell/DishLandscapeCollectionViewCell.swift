//
//  DishLandscapeCollectionViewCell.swift
//  Yummie
//
//  Created by Christian Calixto on 14/4/23.
//

import UIKit

class DishLandscapeCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: DishLandscapeCollectionViewCell.self)
    
    @IBOutlet weak var dishCaloryLbl: UILabel!
    @IBOutlet weak var dishDescriptionLbl: UILabel!
    @IBOutlet weak var dishTitleLbl: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!


    func setup(dish: Dish) {
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        dishTitleLbl.text = dish.name
        dishDescriptionLbl.text = dish.description
        dishCaloryLbl.text = dish.formattedCalories
    }
}
