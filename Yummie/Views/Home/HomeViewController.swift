//
//  HomeViewController.swift
//  Yummie
//
//  Created by Christian Calixto on 14/4/23.
//

import UIKit
import ProgressHUD

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

    @IBOutlet weak var specialsCollectionView: UICollectionView! {
        didSet {
            specialsCollectionView.dataSource = self
            specialsCollectionView.delegate = self
            specialsCollectionView.register(UINib(nibName: DishLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishLandscapeCollectionViewCell.identifier)
        }
    }

    var categories = [DishCategory]()

    var populars = [Dish]()

    var specials = [Dish]()

    override func viewDidLoad() {
        super.viewDidLoad()

        ProgressHUD.show()
        NetworkService.shared.fetchAllCategories { [weak self] (result: Result<AllDishes, Error>) in
            guard let self else { return }
            switch result {
            case .success(let success):
                self.specials = success.specials ?? []
                self.categories = success.categories ?? []
                self.populars = success.populars ?? []
                self.categoryCollectionView.reloadData()
                self.popularCollectionView.reloadData()
                self.specialsCollectionView.reloadData()
                ProgressHUD.dismiss()
            case .failure(let failure):
                print("Error all dishes")
                ProgressHUD.showError(failure.localizedDescription)
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            return categories.count
        case popularCollectionView:
            return populars.count
        case specialsCollectionView:
            return specials.count
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
        case specialsCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishLandscapeCollectionViewCell.identifier, for: indexPath) as? DishLandscapeCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.setup(dish: specials[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }


    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case categoryCollectionView:
            let controller = ListDishesViewController.instantiate()
            controller.setup(category: categories[indexPath.row])
            navigationController?.pushViewController(controller, animated: true)
        default:
            let controller = DishDetailViewController.instantiate()
            controller.setup(dish: collectionView == popularCollectionView ? populars[indexPath.row] : specials[indexPath.row])
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}


