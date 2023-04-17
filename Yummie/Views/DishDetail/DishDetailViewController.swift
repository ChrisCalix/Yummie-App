//
//  DishDetailViewController.swift
//  Yummie
//
//  Created by Christian Calixto on 15/4/23.
//

import UIKit
import ProgressHUD

class DishDetailViewController: UIViewController {


    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var nameField: UITextField!

    // make better with empty state
    private var dish: Dish!

    override func viewDidLoad() {
        super.viewDidLoad()

        populateView()
    }

    private func populateView() {
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
        caloriesLbl.text = dish.formattedCalories
    }

    public func setup(dish: Dish) {
        self.dish = dish
    }

    @IBAction func placeOrderButtonClicked(_ sender: Any) {
        guard let name = nameField.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty else {
            ProgressHUD.showError("Please enter your name")
            return
        }

        guard let dishId = self.dish.id else {
            ProgressHUD.showError(AppError.unknownError.localizedDescription)
            return
        }

        ProgressHUD.show("Placing Order...")
        NetworkService.shared.placeOrder(dishId: dishId, name: name) { result in
            switch result {
            case .success(_):
                ProgressHUD.showSucceed("Your ordered has been received 🥝")
            case .failure(let failure):
                ProgressHUD.showError("error wen the ordere was sended \(failure.localizedDescription)")
            }
        }
        print("Hello")
    }
}
