//
//  UpdateViewController.swift
//  DırectoryApp
//
//  Created by Furkan Aykut on 17.11.2021.
//

import UIKit

class UpdateViewController: UIViewController {
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    
    let context = appDelegate.persistentContainer.viewContext
    
    var person : Directory?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let p = person{
            nameText.text = p.person_name!
            phoneText.text = p.person_phone!
        }
    }
    
    @IBAction func updateButtonClicked(_ sender: Any) {
        if let p = person ,let personName = nameText.text ,let personPhone = phoneText.text{
            p.person_name = personName
            p.person_phone = personPhone
            
            appDelegate.saveContext()
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
  

}
