//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Cristian Misael Almendro Lazarte on 8/3/19.
//  Copyright © 2019 Cristian Misael Almendro Lazarte. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()
    }
    
    //MARK - TableViewDelegate Methdos
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { 
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategoty = categoryArray?[indexPath.row]
        }
    }
    
    //MARK - TableView DataSource Methdos
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = self.categoryArray?[indexPath.row].name ?? "No categories added yet"
        
        return cell
    }
    
    //MARK - Add new Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add category", message: "Add new category", preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "Add category", style: UIAlertAction.Style.default) {
            (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.saveData(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Data Manipulation Methods
    
    func saveData(category : Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadData(){
        
        categoryArray = realm.objects(Category.self)
        self.tableView.reloadData()
    }
}
