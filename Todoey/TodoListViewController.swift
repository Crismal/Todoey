//
//  ViewController.swift
//  Todoey
//
//  Created by Cristian Misael Almendro Lazarte on 6/22/19.
//  Copyright © 2019 Cristian Misael Almendro Lazarte. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    
    let itemArray = ["Item 1", "Item 2", "Item 3"]
    
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
        
        cell.textLabel?.text = self.itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
}

