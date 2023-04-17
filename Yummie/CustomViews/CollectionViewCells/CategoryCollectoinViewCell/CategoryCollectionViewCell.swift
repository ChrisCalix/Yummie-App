//
//  CategoryCollectionViewCell.swift
//  Yummie
//
//  Created by Christian Calixto on 14/4/23.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell, ReusableView {

    static let identifier = String(describing: CategoryCollectionViewCell.self)
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(category: DishCategory) {
        categoryTitleLbl.text = category.name
        categoryImageView.kf.setImage(with: category.image?.asUrl)
    }

}

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}
