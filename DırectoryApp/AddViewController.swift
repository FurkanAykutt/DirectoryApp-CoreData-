//
//  AddViewController.swift
//  DırectoryApp
//
//  Created by Furkan Aykut on 17.11.2021.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    
    let context = appDelegate.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        if let personName = nameText.text ,let personPhone = phoneText.text{
            let person = Directory(context: context)
            person.person_name = personName
            person.person_phone = personPhone
            
            appDelegate.saveContext()
            navigationController?.popToRootViewController(animated: true)
        }
       
        
    }
    
    

}
