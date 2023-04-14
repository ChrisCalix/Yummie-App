//
//  OnBoardingCollectionViewCell.swift
//  Yummie
//
//  Created by Christian Calixto on 14/4/23.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: OnBoardingCollectionViewCell.self)

    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLbl: UILabel!
    @IBOutlet weak var slideDescriptionLbl: UILabel!

    func setup(_ slide: OnboardingSlide) {
        
        slideImageView.image = slide.image
        slideTitleLbl.text = slide.title
        slideDescriptionLbl.text = slide.description
    }

}
