//
//  ViewController.swift
//  ToCheck
//
//  Created by Raffi Mekerdijian on 11/15/18.
//  Copyright © 2018 Sarkis Megrditchian. All rights reserved.
//

import UIKit

class CheckDoViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.Title = "lolloloolololo"
        itemArray.append(newItem)
        // Do any additional setup after loading the view, typically from a nib.

loadItems()
        
        
    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
        
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reuse", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.Title
        
        cell.accessoryType = item.Done == true ? .checkmark : .none
        
        return cell
        
    
    }
    
    
    //MARK - TableView DMs
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].Done = !itemArray[indexPath.row].Done
        

        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

    @IBAction func addButtonpressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new CheckDo item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What Will happen when You Press AddItem
            
            let newItem = Item()
            newItem.Title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        
            
            
            

        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        }
    
    func saveItems() {
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("ERROR ERROR!!! SIR THIS IS THE ERROR: \(error)")
    
        }
        self.tableView.reloadData()
        
        
    }
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            }catch {
                
            }
        }
        
    }
    }





