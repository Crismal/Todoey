//
//  ViewController.swift
//  Todoey
//
//  Created by Cristian Misael Almendro Lazarte on 6/22/19.
//  Copyright © 2019 Cristian Misael Almendro Lazarte. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    
    var itemArray = [Item]()
    
    //let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first?.appendingPathComponent("items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.loadData()
        
    }

    //MARK - TableView DataSource Methdos

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = self.itemArray[indexPath.row].item
        
        cell.accessoryType = self.itemArray[indexPath.row].selected ? UITableViewCell.AccessoryType.checkmark : UITableViewCell.AccessoryType.none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].selected = !itemArray[indexPath.row].selected
        tableView.deselectRow(at: indexPath, animated: true)
        self.saveData() 
    }
    
    //MARK - Add new Items
    
    @IBAction func addNewItems(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "Add new todoey item", preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "Add item", style: UIAlertAction.Style.default) {
            (action) in
            
            let newItem = Item()
            newItem.item = textField.text!
            
            self.itemArray.append(newItem)
            self.saveData()
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
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
            self.tableView.reloadData()
        } catch {
            print("Error al encode \(error)")
        }
    }
    
    func loadData()  {
        
        do {
            let data = try Data(contentsOf: self.dataFilePath!)
            let decoder = PropertyListDecoder()
            
            itemArray = try decoder.decode([Item].self, from: data)
            
        } catch  {
            print("Error el decode \(error)")
        }
    }
}

