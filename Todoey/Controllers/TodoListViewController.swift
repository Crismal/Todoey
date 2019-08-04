//
//  ViewController.swift
//  Todoey
//
//  Created by Cristian Misael Almendro Lazarte on 6/22/19.
//  Copyright © 2019 Cristian Misael Almendro Lazarte. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    var selectedCategoty : Category? {
        didSet {
            loadData()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK - TableView DataSource Methdos
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = self.itemArray[indexPath.row].title
        
        cell.accessoryType = self.itemArray[indexPath.row].done ? UITableViewCell.AccessoryType.checkmark : UITableViewCell.AccessoryType.none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
        
        //itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.deselectRow(at: indexPath, animated: true)
        self.saveData()
        
    }
    
    //MARK - Add new Items
    
    @IBAction func addNewItems(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "Add new todoey item", preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "Add item", style: UIAlertAction.Style.default) {
            (action) in
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategoty
            
            self.itemArray.append(newItem)
            self.saveData()
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveData()  {
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadData(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil)  {
        
        
        let categoryPredicaate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategoty!.name!)
        
        if let aditionalPredicate = predicate {
            
            let compountPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [aditionalPredicate, categoryPredicaate])
            
            request.predicate = compountPredicate
        } else {
            request.predicate = categoryPredicaate
        }
        do {
            itemArray = try context.fetch(request);
        } catch  {
            print(error)
        }
        
        self.tableView.reloadData()
    }
    
}

//MARK: - Search bar methods

extension TodoListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        if searchBar.text != "" {
            let predicate = NSPredicate.init(format: "title CONTAINS[cd] %@", searchBar.text!)
            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            self.loadData(with: request, predicate: predicate)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            self.loadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
