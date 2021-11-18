//
//  DetailsViewController.swift
//  DırectoryApp
//
//  Created by Furkan Aykut on 17.11.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var person : Directory?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let p = person{
            nameLabel.text = p.person_name!
            phoneLabel.text = p.person_phone!
        }
    }
    
}
