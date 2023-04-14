//
//  HomeViewController.swift
//  Yummie
//
//  Created by Christian Calixto on 14/4/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView! {
        didSet {
            categoryCollectionView.dataSource = self
            categoryCollectionView.delegate = self

            categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        }
    }

    @IBOutlet weak var popularCollectionView: UICollectionView! {
        didSet {
            popularCollectionView.dataSource = self
            popularCollectionView.delegate = self
            popularCollectionView.register(UINib(nibName: DishPortraitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishPortraitCollectionViewCell.identifier)
        }
    }


    var categories: [DishCategory] = [
        .init(id: "id1", name: "Africa Dish", image: "https://picsum.photos/100/200"),
        .init(id: "id1", name: "Africa Dish 2", image: "https://picsum.photos/100/200"),
        .init(id: "id1", name: "Africa Dish 3", image: "https://picsum.photos/100/200"),
        .init(id: "id1", name: "Africa Dish 4", image: "https://picsum.photos/100/200"),
        .init(id: "id1", name: "Africa Dish 5", image: "https://picsum.photos/100/200"),
    ]

    var populars: [Dish] = [
        .init(id: "id1", name: "Garri", description: "This is the best I have ever tasted", image: "https://picsum.photos/100/200", calories: 34),
        .init(id: "id1", name: "Indomie", description: "This is the best I have ever tasted", image: "https://picsum.photos/100/200", calories: 324),
        .init(id: "id1", name: "Pizza", description: "This is the best I have ever tasted", image: "https://picsum.photos/100/200", calories: 1004),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            return categories.count
        case popularCollectionView:
            return populars.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch collectionView {
        case categoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.setup(category: categories[indexPath.row])
            return cell
        case popularCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishPortraitCollectionViewCell.identifier, for: indexPath) as? DishPortraitCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.setup(dish: populars[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }


    }
}

extension HomeViewController: UICollectionViewDelegate {

}


