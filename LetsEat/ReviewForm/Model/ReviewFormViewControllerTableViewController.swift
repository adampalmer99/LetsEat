//
//  ReviewFormViewControllerTableViewController.swift
//  LetsEat
//
//  Created by Adam Palmer on 13/05/2022.
//

import UIKit

class ReviewFormViewControllerTableViewController: UITableViewController {
    
    var selectedRestaurantID: Int?
    
    @IBOutlet var ratingsView: RatingsView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var reviewTextView: UITextView!



    override func viewDidLoad() {
        super.viewDidLoad()
            
        print(selectedRestaurantID as Any)
    }
}

private extension ReviewFormViewControllerTableViewController {
    @IBAction func onSaveTapped(_ sender: Any) {
        var reviewItem = ReviewItem()
        reviewItem.rating = ratingsView.rating
        reviewItem.title = titleTextField.text
        reviewItem.name = nameTextField.text
        reviewItem.customerReview = reviewTextView.text
        if let selRestID = selectedRestaurantID {
            reviewItem.restaurantID = Int64(selRestID)
        }
        CoreDataManager.shared.addReview(reviewItem)
        dismiss(animated: true, completion: nil)
    }
}
