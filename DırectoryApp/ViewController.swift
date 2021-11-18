//
//  ViewController.swift
//  DırectoryApp
//
//  Created by Furkan Aykut on 17.11.2021.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let context = appDelegate.persistentContainer.viewContext
    var directoryList = [Directory]()
    
    var isItMakingSearch = false
    var searchWord:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isItMakingSearch{
            search(person_name: searchWord!)
        }else{
            takeAllPerson()
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        if segue.identifier == "toUpdate"{
            let destination = segue.destination as! UpdateViewController
            destination.person = directoryList[index!]
        }
        if segue.identifier == "toDetail"{
            let destination = segue.destination as! DetailsViewController
            destination.person = directoryList[index!]
        }
    }
    
    func takeAllPerson(){
        do {
            directoryList = try context.fetch(Directory.fetchRequest())
        } catch  {
            print("Error")
        }
    }
    
    func search(person_name:String){
        let fetchRequest:NSFetchRequest<Directory> = Directory.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "person_name CONTAINS %@",person_name)
        
        do {
            directoryList = try context.fetch(fetchRequest)
        } catch  {
            print("Error")
        }
    }
    
  
}

//              TABLE VİEW
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directoryList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let person = directoryList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! HomeTableViewCell
        cell.cellLabel.text =  "\(person.person_name!) - \(person.person_phone!)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){
            (contextualAction,view,boolValue) in
            
            let person = self.directoryList[indexPath.row]
            
            self.context.delete(person)
            
            appDelegate.saveContext()
            
            if self.isItMakingSearch{
                self.search(person_name: self.searchWord!)
            }else{
                self.takeAllPerson()
            }
            
            self.tableView.reloadData()
        }
        let updateAction = UIContextualAction(style: .normal, title: "Update"){
            (contextualAction,view,boolValue) in
            
            
            self.performSegue(withIdentifier: "toUpdate", sender: indexPath.row)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction,updateAction])
    }
}


//                  SEARCH BAR
extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchWord = searchText
        if searchText == ""{
            isItMakingSearch = false
            takeAllPerson()
        }else{
            isItMakingSearch = true
            search(person_name: searchText)
        }
        
        
        tableView.reloadData()
    }
   
}

