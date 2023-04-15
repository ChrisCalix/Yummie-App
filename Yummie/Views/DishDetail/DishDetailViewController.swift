//
//  DishDetailViewController.swift
//  Yummie
//
//  Created by Christian Calixto on 15/4/23.
//

import UIKit

class DishDetailViewController: UIViewController {


    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var nameField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()


    }


    @IBAction func placeOrderButtonClicked(_ sender: Any) {
    }
}
