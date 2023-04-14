//
//  OnBoardingViewController.swift
//  Yummie
//
//  Created by Christian Calixto on 14/4/23.
//

import UIKit

class OnBoardingViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }

    var slides = [OnboardingSlide]()
    var currentPage: Int = .zero {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        slides = [
            OnboardingSlide(title: "Delicious Dishes", description: "Experience a variety of amazing dishes from different cultures around the world", image: UIImage(named: "slide2")),
            OnboardingSlide(title: "World-Class Chefs", description: "Our dishes are prepared by only the best.", image: UIImage(named: "slide1")),
            OnboardingSlide(title: "Instant World-Wide Delivery", description: "Your orders will be deliverred instantly irrespective of your location around the world", image: UIImage(named: "slide3"))
        ]
        pageControl.numberOfPages = slides.count
    }


    @IBAction func didPressedNextBtn(_ sender: Any) {

        if currentPage == slides.count-1 {
            guard let controller = storyboard?.instantiateViewController(withIdentifier: "HomeNC") as? UINavigationController else {
                return
            }
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true)

        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: .zero)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }

}

extension OnBoardingViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCollectionViewCell.identifier, for: indexPath) as? OnBoardingCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(slides[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }

}

extension OnBoardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        print("scroll \(scrollView.contentOffset.x/width)")
        currentPage = Int(scrollView.contentOffset.x/width)
    }

}
