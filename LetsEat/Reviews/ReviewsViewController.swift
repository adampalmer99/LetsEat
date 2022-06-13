//
//  ReviewsViewController.swift
//  LetsEat
//
//  Created by Adam Palmer on 07/06/2022.
//

import UIKit

class ReviewsViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    var selectedRestaurantID: Int?
    private var reviewItems: [ReviewItem] = []
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkReviews()
    }
   
}

private extension ReviewsViewController {
    func initialize() {
        setupCollectionView()
    }
    func setupCollectionView() {
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 7
        flow.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flow
    }
    
    func checkReviews() {
        let viewController = self.parent as? RestaurantDetailViewController
        if let restaurantID = viewController?.selectedRestaurant?.restaurantID {
            reviewItems = CoreDataManager.shared.fetchReviews(by: restaurantID)
            if !reviewItems.isEmpty {
                collectionView.backgroundView = nil
            } else {
                let view = NoDataView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height))
                view.set(title: "Reviews", desc: "There are currently no reviews")
                collectionView.backgroundView = view
            }
        }
        collectionView.reloadData()
    }
    
}

extension ReviewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reviewItems.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        let reviewItem = reviewItems[indexPath.item]
        cell.nameLabel.text = reviewItem.name
        cell.titleLabel.text = reviewItem.title
        cell.reviewLabel.text = reviewItem.customerReview
        if let reviewItemDate = reviewItem.date {
            cell.dateLabel.text = dateFormatter.string(from: reviewItemDate)
        }
        if let reviewItemRating = reviewItem.rating {
            cell.ratingsView.rating = reviewItemRating
        }
        return cell
    }
}


