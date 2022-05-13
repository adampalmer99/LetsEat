//
//  ReviewFormViewControllerTableViewController.swift
//  LetsEat
//
//  Created by Adam Palmer on 13/05/2022.
//

import UIKit

class ReviewFormViewControllerTableViewController: UITableViewController {
    
    @IBOutlet var ratingsView: RatingsView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var reviewTextView: UITextView!



    override func viewDidLoad() {
        super.viewDidLoad()
            
        
    }

    @IBAction func onSaveTapped(_ sender: Any) {
        print(ratingsView.rating)
        print(titleTextField.text as Any)
        print(nameTextField.text as Any)
        print(reviewTextView.text as Any)
        dismiss(animated: true, completion: nil)
    }
    
   
}
